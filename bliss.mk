$(call inherit-product, device/ZTE/X9180/full_X9180.mk)

PRODUCT_PROPERTY_OVERRIDES += \
    ro.ota.romname=BlissPop-X9180 \
    ro.ota.manifest=https://romhut.com/roms/blisspop-x9180/ota.xml

BLISS_DEVICE_URL := https://romhut.com/roms/blisspop-x9180

# Inherit some common CM stuff.
$(call inherit-product, vendor/bliss/config/common_full_phone.mk)

PRODUCT_RELEASE_NAME := ZTE V5 RedBull
PRODUCT_NAME := bliss_X9180
