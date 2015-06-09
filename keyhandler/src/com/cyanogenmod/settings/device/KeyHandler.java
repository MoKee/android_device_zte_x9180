package com.cyanogenmod.settings.device;

import android.database.ContentObserver;
import android.content.Context;
import android.content.Intent;
import android.media.session.MediaSessionLegacyHelper;
import android.os.Handler;
import android.os.PowerManager;
import android.os.SystemClock;
import android.provider.Settings.System;
import android.telephony.TelephonyManager;
import android.view.KeyEvent;

import com.android.internal.os.DeviceKeyHandler;

public class KeyHandler implements DeviceKeyHandler {

    private static final String TAG = KeyHandler.class.getSimpleName();

    // Supported scancodes
    private static final int KEY_PALM = 249;
    private static final int KEY_POWER = 116;
    private static final int KEY_DT2W_SCREEN = 250;
    private static final int KEY_DT2W_LEFT = 251;
    private static final int KEY_DT2W_MIDDLE = 252;
    private static final int KEY_DT2W_RIGHT = 253;

    private final Context mContext;
    private final PowerManager mPowerManager;
    private final TelephonyManager mTelephonyManager;
    private final Handler mHandler;
    
    private static long power_button_timestamp = 0;
    private static boolean action_down_consumed = false;
    private static final int POWER_TIMESTAMP_DELTA = 400;

    enum Dt2wPolicy {
        TURN_ON,
        DOZE,
        CAMERA,
        TRACK_PREV,
        TRACK_NEXT,
        PLAY_PAUSE,
        TORCH,
        NONE
    }

    private Dt2wPolicy dt2w_policy_screen = Dt2wPolicy.TURN_ON;
    private Dt2wPolicy dt2w_policy_left = Dt2wPolicy.DOZE;
    private Dt2wPolicy dt2w_policy_middle = Dt2wPolicy.DOZE;
    private Dt2wPolicy dt2w_policy_right = Dt2wPolicy.DOZE;

    private CameraActivationAction cameraAction = null;
    private TorchAction torchAction = null;

    private static final String DOZE_INTENT = "com.android.systemui.doze.pulse";

    private SettingsObserver mSettingsObserver;

    class SettingsObserver extends ContentObserver {
        SettingsObserver(Handler handler) {
            super(handler);
        }

        void observe() {
            KeyHandler.this.mContext.getContentResolver().registerContentObserver(System.getUriFor("dt2w_screen_policy"), false, this);
            KeyHandler.this.mContext.getContentResolver().registerContentObserver(System.getUriFor("dt2w_left_policy"), false, this);
            KeyHandler.this.mContext.getContentResolver().registerContentObserver(System.getUriFor("dt2w_middle_policy"), false, this);
            KeyHandler.this.mContext.getContentResolver().registerContentObserver(System.getUriFor("dt2w_right_policy"), false, this);
        }

        public void onChange(boolean selfChange) {
            KeyHandler.this.updateSettings();
        }
    }

    public KeyHandler(Context context) {
        mContext = context;
        mPowerManager = (PowerManager) context.getSystemService(Context.POWER_SERVICE);
        mTelephonyManager = (TelephonyManager) context.getSystemService(Context.TELEPHONY_SERVICE);
        mHandler = new Handler();
        mSettingsObserver = new SettingsObserver(mHandler);
        mSettingsObserver.observe();
        updateSettings();
    }

    private void dispatchMediaKeyWithWakeLockToMediaSession(int keycode) {
        MediaSessionLegacyHelper helper = MediaSessionLegacyHelper.getHelper(mContext);
        if (helper != null) {
            KeyEvent event = new KeyEvent(SystemClock.uptimeMillis(),
                    SystemClock.uptimeMillis(), KeyEvent.ACTION_DOWN, keycode, 0);
            helper.sendMediaButtonEvent(event, true);
            event = KeyEvent.changeAction(event, KeyEvent.ACTION_UP);
            helper.sendMediaButtonEvent(event, true);
        }
    }

    public boolean handleKeyEvent(KeyEvent event) {
        boolean consumed = false;
        switch(event.getScanCode()) {
        case KEY_PALM:
            if (mPowerManager.isScreenOn() && mTelephonyManager.getCallState()==TelephonyManager.CALL_STATE_IDLE) {
                mPowerManager.goToSleep(SystemClock.uptimeMillis());
            }
            consumed = true;
            break;
        case KEY_POWER:
            if(event.getAction() == KeyEvent.ACTION_UP && action_down_consumed) {
                consumed = true;
                action_down_consumed = false;
            } else if (event.getAction() == KeyEvent.ACTION_DOWN && action_down_consumed) {
                long new_timestamp = java.lang.System.currentTimeMillis();
                if(new_timestamp - power_button_timestamp < POWER_TIMESTAMP_DELTA) {
                    consumed = true;
                    action_down_consumed = true;
                }
                power_button_timestamp = new_timestamp;
            }
            break;
        case KEY_DT2W_SCREEN:
            consumed = handleDt2wEvent(event, dt2w_policy_screen);
            break;
        case KEY_DT2W_LEFT:
            consumed = handleDt2wEvent(event, dt2w_policy_left);
            break;
        case KEY_DT2W_MIDDLE:
            consumed = handleDt2wEvent(event, dt2w_policy_middle);
            break;
        case KEY_DT2W_RIGHT:
            consumed = handleDt2wEvent(event, dt2w_policy_right);
            break;
        }
        return consumed;
    }

    public boolean handleDt2wEvent(KeyEvent event, Dt2wPolicy policy) {
        if(event.getAction() == KeyEvent.ACTION_DOWN) {
            return true;
        }
        boolean consumed = false;
        switch(policy) {
        case TURN_ON:
            if (!mPowerManager.isScreenOn()) {
                mPowerManager.wakeUp(SystemClock.uptimeMillis());
            }
            consumed = true;
            break;
        case CAMERA:
            if(cameraAction == null)
                cameraAction = new CameraActivationAction(mContext, 50);
            cameraAction.action();
            consumed = true;
            break;
        case DOZE:
            mContext.sendBroadcast(new Intent(DOZE_INTENT));
            consumed = true;
            break;
        case TRACK_PREV:
            dispatchMediaKeyWithWakeLockToMediaSession(KeyEvent.KEYCODE_MEDIA_PREVIOUS);
            consumed = true;
            break;
        case TRACK_NEXT:
            dispatchMediaKeyWithWakeLockToMediaSession(KeyEvent.KEYCODE_MEDIA_NEXT);
            consumed = true;
            break;
        case PLAY_PAUSE:
            dispatchMediaKeyWithWakeLockToMediaSession(KeyEvent.KEYCODE_MEDIA_PLAY_PAUSE);
            consumed = true;
            break;
        case TORCH:
            if(torchAction == null)
                torchAction = new TorchAction(mContext, 50);
            torchAction.action();
            consumed = true;
            break;
        case NONE:
            consumed = true;
            break;
        }
        return consumed;
    }

    public void updateSettings() {
        String value = null;

        value = System.getString(mContext.getContentResolver(), "dt2w_screen_policy");
        if(value != null)
            dt2w_policy_screen = Dt2wPolicy.valueOf(value);

        value = System.getString(mContext.getContentResolver(), "dt2w_left_policy");
        if(value != null)
            dt2w_policy_left = Dt2wPolicy.valueOf(value);

        value = System.getString(mContext.getContentResolver(), "dt2w_middle_policy");
        if(value != null)
            dt2w_policy_middle = Dt2wPolicy.valueOf(value);

        value = System.getString(mContext.getContentResolver(), "dt2w_right_policy");
        if(value != null)
            dt2w_policy_right = Dt2wPolicy.valueOf(value);
    }

}
