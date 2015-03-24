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

    private final Context mContext;
    private final PowerManager mPowerManager;

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
        }
        return consumed;
    }

}
