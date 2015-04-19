$(call inherit-product, device/ZTE/X9180/full_X9180.mk)

# Inherit APNs list
$(call inherit-product, vendor/nameless/config/apns.mk)

# Inherit from our custom product configuration
$(call inherit-product, vendor/nameless/config/common.mk)

PRODUCT_RELEASE_NAME := ZTE V5 RedBull
PRODUCT_NAME := nameless_X9180

