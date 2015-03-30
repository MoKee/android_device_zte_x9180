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
    git am ../../device/ZTE/X9180/patches/frameworks-base-1.patch;
    git am ../../device/ZTE/X9180/patches/frameworks-base-2.patch;
fi
if grep -q "SHOW_SU_INDICATOR" core/java/android/provider/Settings.java
then
    echo '[su icon] Frameworks/base already patched';
else
    git am ../../device/ZTE/X9180/patches/su-icon-frameworks-base.patch;
fi
croot

cd packages/apps/Settings
if grep -q "show_su_indicator" res/xml/status_bar_settings.xml
then
    echo '[su icon] Settings already patched';
else
    git am ../../../device/ZTE/X9180/patches/su-icon-settings.patch;
fi
croot

cd hardware/qcom/media-caf/msm8974
if grep -q "QCOM_MEDIA_DISABLE_BUFFER_CHECK" mm-video-v4l2/vidc/vdec/src/omx_vdec_msm8974.cpp
then
    echo '[buffer check] Media-caf mm-video-v4l2 already patched';
else
    git am ../../../../device/ZTE/X9180/patches/media-disable-buffer-check.patch;
fi
if grep -q "# LOCAL_MODULE_TAGS := eng" dashplayer/Android.mk
then
    echo '[dashplayer] Media-caf dashplayer already patched';
else
    git am ../../../../device/ZTE/X9180/patches/media-enable-dashplayer.patch;
fi
croot
