# Exclude GoogleIME
# TARGET_EXCLUDE_GOOGLE_IME := true

$(call inherit-product, device/ZTE/X9180/full_X9180.mk)

# Inherit some common CM stuff.
$(call inherit-product, vendor/mk/config/common_full_phone.mk)

PRODUCT_RELEASE_NAME := ZTE V5 RedBull
PRODUCT_NAME := mk_X9180
