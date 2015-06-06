#
# Copyright (C) 2014 The CyanogenMod Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

$(call inherit-product, $(SRC_TARGET_DIR)/product/languages_full.mk)

$(call inherit-product-if-exists, vendor/ZTE/X9180/X9180-vendor.mk)

# Overlay
DEVICE_PACKAGE_OVERLAYS += $(LOCAL_PATH)/overlay

# Permissions
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.audio.low_latency.xml:system/etc/permissions/android.hardware.audio.low_latency.xml \
    frameworks/native/data/etc/android.hardware.bluetooth_le.xml:system/etc/permissions/android.hardware.bluetooth_le.xml \
    frameworks/native/data/etc/android.hardware.camera.autofocus.xml:system/etc/permissions/android.hardware.camera.autofocus.xml \
    frameworks/native/data/etc/android.hardware.camera.xml:system/etc/permissions/android.hardware.camera.xml \
    frameworks/native/data/etc/android.hardware.camera.flash-autofocus.xml:system/etc/permissions/android.hardware.camera.flash-autofocus.xml \
    frameworks/native/data/etc/android.hardware.camera.front.xml:system/etc/permissions/android.hardware.camera.front.xml \
    frameworks/native/data/etc/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml \
    frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:system/etc/permissions/android.hardware.sensor.accelerometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:system/etc/permissions/android.hardware.sensor.gyroscope.xml \
    frameworks/native/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/native/data/etc/android.hardware.sensor.proximity.xml:system/etc/permissions/android.hardware.sensor.proximity.xml \
    frameworks/native/data/etc/android.hardware.telephony.cdma.xml:system/etc/permissions/android.hardware.telephony.cdma.xml \
    frameworks/native/data/etc/android.hardware.telephony.gsm.xml:system/etc/permissions/android.hardware.telephony.gsm.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml \
    frameworks/native/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml \
    frameworks/native/data/etc/android.hardware.usb.host.xml:system/etc/permissions/android.hardware.usb.host.xml \
    frameworks/native/data/etc/android.hardware.wifi.direct.xml:system/etc/permissions/android.hardware.wifi.direct.xml \
    frameworks/native/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml \
    frameworks/native/data/etc/handheld_core_hardware.xml:system/etc/permissions/handheld_core_hardware.xml \
    frameworks/native/data/etc/android.hardware.sensor.stepcounter.xml:system/etc/permissions/android.hardware.sensor.stepcounter.xml \
    frameworks/native/data/etc/android.hardware.sensor.stepdetector.xml:system/etc/permissions/android.hardware.sensor.stepdetector.xml \
    frameworks/native/data/etc/android.hardware.ethernet.xml:system/etc/permissions/android.hardware.ethernet.xml \
    external/ant-wireless/antradio-library/com.dsi.ant.antradio_library.xml:system/etc/permissions/com.dsi.ant.antradio_library.xml

# System Properties
-include $(LOCAL_PATH)/system_prop.mk

# Screen density
PRODUCT_AAPT_CONFIG := normal
PRODUCT_AAPT_PREF_CONFIG := xhdpi

# Boot animation
TARGET_SCREEN_HEIGHT := 1280
TARGET_SCREEN_WIDTH := 720

# call dalvik heap config
$(call inherit-product, frameworks/native/build/phone-xhdpi-2048-dalvik-heap.mk)

# call hwui memory config
# $(call inherit-product-if-exists, frameworks/native/build/phone-xxhdpi-2048-hwui-memory.mk)

# Audio
PRODUCT_PACKAGES += \
    audiod \
    audio.a2dp.default \
    audio.primary.msm8226 \
    audio.r_submix.default \
    audio.usb.default \
    audio_policy.msm8226

PRODUCT_PACKAGES += \
    libaudio-resampler \
    libqcompostprocbundle \
    libqcomvisualizer \
    libqcomvoiceprocessing \
    tinymix

# Audio configuration
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/etc/audio_effects.conf:system/vendor/etc/audio_effects.conf \
    $(LOCAL_PATH)/etc/audio_platform_info.xml:system/etc/audio_platform_info.xml \
    $(LOCAL_PATH)/etc/audio_policy.conf:system/etc/audio_policy.conf \
    $(LOCAL_PATH)/etc/mixer_paths.xml:system/etc/mixer_paths.xml

# Camera
PRODUCT_PACKAGES += \
    libxml2 \
    camera.msm8226 \
    Camera2

# Connectivity Engine support
PRODUCT_PACKAGES += \
    libcnefeatureconfig \
    services-ext

# Charger
PRODUCT_PACKAGES += \
    charger \
    charger_res_images

# CRDA
PRODUCT_PACKAGES += \
    crda \
    linville.key.pub.pem \
    regdbdump \
    regulatory.bin

# Wfd
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/etc/capability.xml:system/etc/capability.xml \
    $(LOCAL_PATH)/etc/wfdconfig.xml:system/etc/wfdconfig.xml \
    $(LOCAL_PATH)/etc/wfdconfig1280_720.xml:system/etc/wfdconfig1280_720.xml \
    $(LOCAL_PATH)/etc/wfdconfig640_480.xml:system/etc/wfdconfig640_480.xml \
    $(LOCAL_PATH)/etc/wfdconfig800_480.xml:system/etc/wfdconfig800_480.xml \
    $(LOCAL_PATH)/etc/wfdconfig960_540.xml:system/etc/wfdconfig960_540.xml \
    $(LOCAL_PATH)/etc/wfdconfigsink.xml:system/etc/wfdconfigsink.xml

# Display
PRODUCT_PACKAGES += \
    copybit.msm8226 \
    gralloc.msm8226 \
    hwcomposer.msm8226 \
    memtrack.msm8226 \
    liboverlay \
    libgenlock
    
# Ebtables
PRODUCT_PACKAGES += \
    ebtables \
    ethertypes \
    libebtc

# Filesystem
PRODUCT_PACKAGES += \
    e2fsck \
    fibmap.f2fs \
    fsck.f2fs \
    mkfs.f2fs \
    make_ext4fs \
    resize2fs \
    setup_fs

# FM
PRODUCT_PACKAGES += \
    FM2 \
    FMRecord \
    libqcomfm_jni \
    qcom.fmradio \
    qcom.fmradio.xml

# GPS
PRODUCT_PACKAGES += \
    libgps.utils \
    gps.msm8226 \
    libloc_core \
    libloc_eng

# LOWI
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/etc/lowi.conf:system/etc/lowi.conf

# IRSC
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/etc/sec_config:system/etc/sec_config

# Keystore
PRODUCT_PACKAGES += \
    keystore.msm8226

# Lights
PRODUCT_PACKAGES += \
    lights.msm8226

# Media
PRODUCT_COPY_FILES += \
    frameworks/av/media/libstagefright/data/media_codecs_ffmpeg.xml:system/etc/media_codecs_ffmpeg.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_audio.xml:system/etc/media_codecs_google_audio.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_telephony.xml:system/etc/media_codecs_google_telephony.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_video.xml:system/etc/media_codecs_google_video.xml \
    $(LOCAL_PATH)/etc/media_codecs.xml:system/etc/media_codecs.xml \
    $(LOCAL_PATH)/etc/media_profiles.xml:system/etc/media_profiles.xml

# frandom
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/etc/init.d/01frandom:system/etc/init.d/01frandom

# palm2sleep
PRODUCT_PACKAGES += \
    com.cyanogenmod.keyhandler

# OMX
PRODUCT_PACKAGES += \
    libc2dcolorconvert \
    libdashplayer \
    libdivxdrmdecrypt \
    libOmxAacEnc \
    libOmxAmrEnc \
    libOmxCore \
    libOmxMux \
    libOmxEvrcEnc \
    libOmxQcelp13Enc \
    libOmxVdec \
    libOmxVdecHevc \
    libOmxVenc \
    libHevcSwDecoder \
    libstagefrighthw \
    qcmediaplayer

PRODUCT_PACKAGES += \
    X9180Settings

PRODUCT_BOOT_JARS += \
    qcmediaplayer

PRODUCT_BOOT_JARS += \
    qcom.fmradio

PRODUCT_PACKAGES += \
    com.android.vcard

# Power
PRODUCT_PACKAGES += \
    power.msm8226

# Ramdisk
PRODUCT_PACKAGES += \
    init.rc \
    fstab.X9180 \
    fstab.sd \
    fstab.int \
    fstab.zram_64 \
    fstab.zram_128 \
    fstab.zram_256 \
    fstab.zram_512 \
    init.class_main.sh \
    init.mdm.sh \
    init.nubia.sh \
    init.nubia.usb.rc \
    init.qcom.class_core.sh \
    init.qcom.early_boot.sh \
    init.qcom.factory.sh \
    init.qcom.rc \
    init.qcom.sdcard.rc \
    init.recovery.qcom.rc \
    init.qcom.sh \
    init.qcom.ssr.sh \
    init.qcom.syspart_fixup.sh \
    init.qcom.usb.sh \
    init.target.rc \
    init.trace.rc \
    init.usb.rc \
    ueventd.qcom.rc \
    ueventd.rc

# USB
PRODUCT_PACKAGES += \
    com.android.future.usb.accessory

# Wifi
PRODUCT_PACKAGES += \
    dhcpcd.conf \
    hostapd.accept \
    hostapd.deny \
    hostapd \
    wpa_supplicant \
    wpa_supplicant.conf

PRODUCT_PACKAGES += \
    p2p_supplicant_overlay.conf \
    wpa_supplicant_overlay.conf \
    wpa_supplicant_ath6kl.conf

PRODUCT_PACKAGES += \
    libantradio \
    AntHalService \
    com.dsi.ant.antradio_library \
    antradio_app

PRODUCT_PACKAGES += \
    giflib

PRODUCT_PACKAGES += \
    WCNSS_qcom_wlan_factory_nv.bin \
    WCNSS_cfg.dat \
    WCNSS_qcom_cfg.ini \
    pronto_wlan.ko \
    libnetcmdiface \
    libwcnss_qmi

PRODUCT_PACKAGES += \
    libcurl \
    libqsap_sdk \
    libQWiFiSoftApCfg \
    wcnss_service

PRODUCT_PACKAGES += \
    libion

PRODUCT_PACKAGES += \
    ntfs-3g \
    ntfsfix \
    mkntfs

PRODUCT_PACKAGES += \
    LatinIME \
    libjni_latinime

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/etc/bluetooth/main.conf:system/etc/bluetooth/main.conf \
    $(LOCAL_PATH)/etc/bluetooth/input.conf:system/etc/bluetooth/input.conf \
    $(LOCAL_PATH)/etc/bluetooth/audio.conf:system/etc/bluetooth/audio.conf \
    $(LOCAL_PATH)/etc/bluetooth/auto_pairing.conf:system/etc/bluetooth/auto_pairing.conf \
    $(LOCAL_PATH)/etc/bluetooth/blacklist.conf:system/etc/bluetooth/blacklist.conf \
    $(LOCAL_PATH)/etc/bluetooth/network.conf:system/etc/bluetooth/network.conf \
    $(LOCAL_PATH)/etc/cne/andsfCne.xml:system/etc/cne/andsfCne.xml \
    $(LOCAL_PATH)/etc/cne/NsrmConfiguration.xml:system/etc/cne/NsrmConfiguration.xml \
    $(LOCAL_PATH)/etc/cne/SwimConfig.xml:system/etc/cne/SwimConfig.xml \
    $(LOCAL_PATH)/etc/flp.conf:system/etc/flp.conf \
    $(LOCAL_PATH)/etc/gps.conf:system/etc/gps.conf \
    $(LOCAL_PATH)/etc/hcidump.sh:system/etc/hcidump.sh \
    $(LOCAL_PATH)/etc/hsic.control.bt.sh:system/etc/hsic.control.bt.sh \
    $(LOCAL_PATH)/etc/init.ath3k.bt.sh:system/etc/init.ath3k.bt.sh \
    $(LOCAL_PATH)/etc/init.crda.sh:system/etc/init.crda.sh \
    $(LOCAL_PATH)/etc/init.qcom.audio.sh:system/etc/init.qcom.audio.sh \
    $(LOCAL_PATH)/etc/init.qcom.bt.sh:system/etc/init.qcom.bt.sh \
    $(LOCAL_PATH)/etc/init.qcom.coex.sh:system/etc/init.qcom.coex.sh \
    $(LOCAL_PATH)/etc/init.qcom.efs.sync.sh:system/etc/init.qcom.efs.sync.sh \
    $(LOCAL_PATH)/etc/init.qcom.fm.sh:system/etc/init.qcom.fm.sh \
    $(LOCAL_PATH)/etc/init.qcom.post_boot.sh:system/etc/init.qcom.post_boot.sh \
    $(LOCAL_PATH)/etc/init.qcom.sdio.sh:system/etc/init.qcom.sdio.sh \
    $(LOCAL_PATH)/etc/init.qcom.wifi.sh:system/etc/init.qcom.wifi.sh \
    $(LOCAL_PATH)/etc/izat.conf:system/etc/izat.conf \
    $(LOCAL_PATH)/etc/permissions/com.qualcomm.location.xml:system/etc/permissions/com.qualcomm.location.xml \
    $(LOCAL_PATH)/etc/qca6234-service.sh:system/etc/qca6234-service.sh \
    $(LOCAL_PATH)/etc/quipc.conf:system/etc/quipc.conf \
    $(LOCAL_PATH)/etc/sap.conf:system/etc/sap.conf \
    $(LOCAL_PATH)/etc/sensor_def_qcomdev.conf:system/etc/sensor_def_qcomdev.conf \
    $(LOCAL_PATH)/etc/thermal-engine-8226.conf:system/etc/thermal-engine-8226.conf \
    $(LOCAL_PATH)/etc/xtra_root_cert.pem:system/etc/xtra_root_cert.pem \
    $(LOCAL_PATH)/etc/xtwifi.conf:system/etc/xtwifi.conf \
    $(LOCAL_PATH)/etc/hostapd/hostapd_default.conf:system/etc/hostapd/hostapd_default.conf

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/usr/keylayout/gpio-keys.kl:system/usr/keylayout/gpio-keys.kl \
    $(LOCAL_PATH)/usr/keylayout/Generic.kl:system/usr/keylayout/Generic.kl

# Changelog
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/etc/CHANGELOG-X9180.txt:system/etc/CHANGELOG-X9180.txt

