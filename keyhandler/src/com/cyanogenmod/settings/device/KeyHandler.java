package com.cyanogenmod.settings.device;

import android.content.Context;
import android.os.PowerManager;
import android.os.SystemClock;
import android.view.KeyEvent;

import com.android.internal.os.DeviceKeyHandler;

public class KeyHandler implements DeviceKeyHandler {

    private static final String TAG = KeyHandler.class.getSimpleName();

    // Supported scancodes
    private static final int KEY_PALM = 249;
    private static final int KEY_POWER = 116;

    private final Context mContext;
    private final PowerManager mPowerManager;
    
    private static long power_button_timestamp = 0;
    private static boolean action_down_consumed = false;
    private static final int POWER_TIMESTAMP_DELTA = 400;

    public KeyHandler(Context context) {
        mContext = context;
        mPowerManager = (PowerManager) context.getSystemService(Context.POWER_SERVICE);
    }


    public boolean handleKeyEvent(KeyEvent event) {
        boolean consumed = false;
        switch(event.getScanCode()) {
        case KEY_PALM:
            if (mPowerManager.isScreenOn()) {
                mPowerManager.goToSleep(SystemClock.uptimeMillis());
            }
            consumed = true;
            break;
        case KEY_POWER:
            if(event.getAction() == KeyEvent.ACTION_UP && action_down_consumed) {
                consumed = true;
                action_down_consumed = false;
            } else if (event.getAction() == KeyEvent.ACTION_DOWN && action_down_consumed) {
                long new_timestamp = System.currentTimeMillis();
                if(new_timestamp - power_button_timestamp < POWER_TIMESTAMP_DELTA) {
                    consumed = true;
                    action_down_consumed = true;
                }
                power_button_timestamp = new_timestamp;
            }
            break;
        }
        return consumed;
    }

}
