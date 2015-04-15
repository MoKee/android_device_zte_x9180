add_lunch_combo cm_X9180-userdebug
add_lunch_combo cm_X9180-eng

add_lunch_combo nameless_X9180-userdebug
add_lunch_combo nameless_X9180-eng

add_lunch_combo mk_X9180-userdebug
add_lunch_combo mk_X9180-eng

add_lunch_combo pac_X9180-userdebug
add_lunch_combo pac_X9180-eng

add_lunch_combo liquid_X9180-userdebug
add_lunch_combo liquid_X9180-eng

sh device/ZTE/X9180/update-overlay.sh

cd frameworks/base
if grep -q "ro.storage_list.override" services/core/java/com/android/server/MountService.java
then
    echo '[storages] Frameworks/base already patched';
else
    git am ../../device/ZTE/X9180/patches/frameworks-base-1.patch || git am --abort
    git am ../../device/ZTE/X9180/patches/frameworks-base-2.patch || git am --abort
fi
if grep -q "SHOW_SU_INDICATOR" core/java/android/provider/Settings.java
then
    echo '[su icon] Frameworks/base already patched';
else
    git am ../../device/ZTE/X9180/patches/su-icon-frameworks-base.patch || git am --abort
fi
if grep -qs "statusbar_powerkey v01" packages/SystemUI/src/com/atx/siyang/PowerKey.java
then
    echo '[statusbar powerkey] Frameworks/base already patched';
else
    git am ../../device/ZTE/X9180/patches/statusbar-powerkey-frameworks-base.patch || git am --abort
fi
if grep -q "mShowExclamationMarks" packages/SystemUI/src/com/android/systemui/statusbar/policy/MSimNetworkControllerImpl.java
then
    echo '[signal icons] Frameworks/base already patched';
else
    git am ../../device/ZTE/X9180/patches/signal-without-exclamation-mark-frameworks-base.patch || git am --abort
fi
if grep -q "NOISE_SUPPRESSION" core/java/android/provider/Settings.java
then
    echo '[noise suppression] Frameworks/base already patched';
else
    git am ../../device/ZTE/X9180/patches/noise-suppression-frameworks-base.patch || git am --abort
fi
croot

cd packages/apps/Settings
if grep -q "show_su_indicator" res/xml/status_bar_settings.xml
then
    echo '[su icon] Settings already patched';
else
    git am ../../../device/ZTE/X9180/patches/su-icon-settings.patch || git am --abort
fi
if grep -q "statusbar_powerkey v01" res/xml/status_bar_settings.xml
then
    echo '[statusbar powerkey] Settings already patched';
else
    git am ../../../device/ZTE/X9180/patches/statusbar-powerkey-settings.patch || git am --abort
fi
if grep -q "exclamation marks v01" res/xml/status_bar_settings.xml
then
    echo '[signal icons] Settings already patched';
else 
    git am ../../../device/ZTE/X9180/patches/signal-without-exclamation-mark-settings.patch || git am --abort
fi
croot

cd hardware/qcom/media-caf/msm8974
if grep -q "QCOM_MEDIA_DISABLE_BUFFER_SIZE_CHECK" mm-video-v4l2/vidc/vdec/src/omx_vdec_msm8974.cpp
then
    echo '[buffer check] Media-caf mm-video-v4l2 already patched';
else
    git am ../../../../device/ZTE/X9180/patches/media-disable-buffer-check.patch || git am --abort
fi
croot

cd packages/services/Telecomm
if grep -q "turnOnNoiseSuppression" src/com/android/server/telecom/CallAudioManager.java
then
    echo '[noise suppression] Telecomm service already patched';
else
    git am ../../../device/ZTE/X9180/patches/noise-suppression-telecomm.patch || git am --abort
fi
croot

cd packages/services/Telephony
if grep -q "BUTTON_NOISE_SUPPRESSION_KEY" src/com/android/phone/CallFeaturesSetting.java
then
    echo '[noise suppression] Telephony service already patched';
else
    git am ../../../device/ZTE/X9180/patches/noise-suppression-telephony.patch || git am --abort
fi
croot

cd packages/apps/Contacts
if grep -q "WRITE_MEDIA_STORAGE" AndroidManifest.xml
then
    echo '[vcards export] Contacts already patched';
else
    git am ../../../device/ZTE/X9180/patches/export-vcards-contacts.patch || git am --abort
fi
croot

cd device/ZTE/X9180
if [ "$WITH_EXTERNAL_WRITABLE" = "1" ]; then
if grep -q "\-w 1023" rootdir/etc/init.qcom.rc
then
	git am ../../../device/ZTE/X9180/patches/enable-writing-to-external-card.patch || git am --abort
else
	echo '[external writable] Init script already patched';
fi
else
	echo '[external writable] IGNORED';
fi
croot
