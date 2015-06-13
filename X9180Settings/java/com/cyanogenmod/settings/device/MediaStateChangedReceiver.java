package com.cyanogenmod.settings.device;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.pm.IPackageManager;
import android.os.Handler;
import android.os.RemoteException;
import android.os.ServiceManager;
import android.util.Log;

public class MediaStateChangedReceiver extends BroadcastReceiver {

    public MediaStateChangedReceiver() {
    }

    @Override
    public void onReceive(Context context, Intent intent) {
        String mountPoint = intent.getDataString();
        if(!("file:///storage/usbdisk".equals(mountPoint)))
            return;
        Log.d("X9180", String.format("Usb drive eject. Trying to restore asec mounts", mountPoint));
        final IPackageManager pm = IPackageManager.Stub.asInterface(
                ServiceManager.getService("package"));
        try {
            pm.updateExternalMediaStatus(true, true);
        } catch (RemoteException e) {
            Log.e("X9180", "Unable to update external media status");
        }
    }
}
