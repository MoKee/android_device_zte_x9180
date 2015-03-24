$(call inherit-product, device/ZTE/X9180/full_X9180.mk)

# Inherit some common CM stuff.
$(call inherit-product, vendor/cm/config/common_full_phone.mk)

PRODUCT_RELEASE_NAME := ZTE V5 RedBull
PRODUCT_NAME := cm_X9180

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/prebuilt/bootanimation.zip:system/media/bootanimation.zip

