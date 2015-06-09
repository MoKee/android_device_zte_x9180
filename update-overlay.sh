#!/bin/sh

MYABSPATH=$(readlink -f "$0")
PATCHBASE=$(dirname "$MYABSPATH")

cd "$PATCHBASE"

mkdir -p overlay/packages/apps/Settings/res/xml/

xmlstarlet ed \
--insert '/dashboard-categories/dashboard-category[@android:id="@+id/system_section"]/dashboard-tile[@android:id="@+id/about_settings"]' \
--type elem -n dashboard-tile \
--insert '/dashboard-categories/dashboard-category[@android:id="@+id/system_section"]/dashboard-tile[not(@android:id)]' \
--type attr -n android:title -v "@string/device_settings" \
--insert '/dashboard-categories/dashboard-category[@android:id="@+id/system_section"]/dashboard-tile[not(@android:id)]' \
--type attr -n android:icon -v "@drawable/ic_settings_profiles" \
--subnode '/dashboard-categories/dashboard-category[@android:id="@+id/system_section"]/dashboard-tile[not(@android:id)]' \
--type elem -n intent \
--insert '/dashboard-categories/dashboard-category[@android:id="@+id/system_section"]/dashboard-tile[not(@android:id)]/intent' \
--type attr -n android:action -v "android.intent.action.MAIN" \
--insert '/dashboard-categories/dashboard-category[@android:id="@+id/system_section"]/dashboard-tile[not(@android:id)]/intent' \
--type attr -n android:targetPackage -v "com.cyanogenmod.settings.device" \
--insert '/dashboard-categories/dashboard-category[@android:id="@+id/system_section"]/dashboard-tile[not(@android:id)]/intent' \
--type attr -n android:targetClass -v "com.cyanogenmod.settings.device.SettingsActivity" \
--insert '/dashboard-categories/dashboard-category[@android:id="@+id/system_section"]/dashboard-tile[not(@android:id)]' \
--type attr -n android:id -v "@+id/device_settings" \
../../../packages/apps/Settings/res/xml/dashboard_categories.xml > overlay/packages/apps/Settings/res/xml/dashboard_categories.xml

if grep -qs cm_updates ../../../packages/apps/Settings/res/xml/device_info_settings.xml; then
  xmlstarlet ed \
  -u '/PreferenceScreen/PreferenceScreen[@android:key="cm_updates"]/intent/@android:targetPackage' -v "com.ota.updates" \
  -u '/PreferenceScreen/PreferenceScreen[@android:key="cm_updates"]/intent/@android:targetClass' -v "com.ota.updates.OtaUpdates.activities.MainActivity" \
  ../../../packages/apps/Settings/res/xml/device_info_settings.xml > overlay/packages/apps/Settings/res/xml/device_info_settings.xml;
fi
