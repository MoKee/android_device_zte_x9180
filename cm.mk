$(call inherit-product, device/ZTE/X9180/full_X9180.mk)

# Inherit some common CM stuff.
$(call inherit-product, vendor/cm/config/common_full_phone.mk)

PRODUCT_RELEASE_NAME := ZTE V5 RedBull

ifneq ($(PAC_BUILD_VERSION),)
    PRODUCT_PROPERTY_OVERRIDES += \
        ro.ota.romname=PAC-X9180 \
        ro.ota.manifest=https://romhut.com/roms/pac-x9180/ota.xml \
        ro.ota.version=$(shell date +%Y%m%d)
    PRODUCT_NAME := pac_X9180
else
    PRODUCT_PROPERTY_OVERRIDES += \
        ro.ota.romname=CyanogenMod-X9180 \
        ro.ota.manifest=https://romhut.com/roms/cyanogenmod-x9180/ota.xml \
        ro.ota.version=$(shell date +%Y%m%d)
    PRODUCT_NAME := cm_X9180
    PRODUCT_COPY_FILES += \
        $(LOCAL_PATH)/prebuilt/bootanimation.zip:system/media/bootanimation.zip
endif

PRODUCT_PACKAGES += OTAUpdates
