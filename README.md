Device configuration for the ZTE V5 RedBull (X9180)
===============================

Local manifest for CM12:

```
#!xml
<?xml version="1.0" encoding="UTF-8"?>
<manifest>
  <remote fetch="ssh://git@gitlab.com" name="gitlab" />

  <project name="CyanogenMod/android_device_qcom_common" path="device/qcom/common" remote="github" />
  <project name="CyanogenMod/android_hardware_qcom_fm" path="hardware/qcom/fm" remote="github" />

  <project name="X9180/android_kernel_zte_x9180.git" path="kernel/ZTE/X9180" remote="gitlab" revision="cm-12.0" />
  <project name="X9180/android_device_zte_x9180.git" path="device/ZTE/X9180" remote="gitlab" revision="cm-12.0" />
  <project name="X9180/android_device_zte_x9180_proprietary.git" path="vendor/ZTE/X9180" remote="gitlab" revision="cm-12.0" />

</manifest>
```

Local manifest for MoKee L:

```
#!xml
<?xml version="1.0" encoding="UTF-8"?>
<manifest>
  <remote fetch="ssh://git@gitlab.com" name="gitlab" />

  <project name="MoKee/android_device_qcom_common" path="device/qcom/common" />
  <project name="MoKee/android_hardware_qcom_fm" path="hardware/qcom/fm" />

  <project name="X9180/android_kernel_zte_x9180.git" path="kernel/ZTE/X9180" remote="gitlab" revision="cm-12.0" />
  <project name="X9180/android_device_zte_x9180.git" path="device/ZTE/X9180" remote="gitlab" revision="cm-12.0" />
  <project name="X9180/android_device_zte_x9180_proprietary.git" path="vendor/ZTE/X9180" remote="gitlab" revision="cm-12.0" />

</manifest>
```

Local manifest for PAC ROM:

```
#!xml
<?xml version="1.0" encoding="UTF-8"?>
<manifest>
  <remote fetch="ssh://git@gitlab.com" name="gitlab" />

  <project name="CyanogenMod/android_device_qcom_common" path="device/qcom/common" remote="github" revision="cm-12.0" />
  <project name="CyanogenMod/android_hardware_qcom_fm" path="hardware/qcom/fm" remote="github" revision="cm-12.0" />

  <project name="X9180/android_kernel_zte_x9180.git" path="kernel/ZTE/X9180" remote="gitlab" revision="cm-12.0" />
  <project name="X9180/android_device_zte_x9180.git" path="device/ZTE/X9180" remote="gitlab" revision="cm-12.0" />
  <project name="X9180/android_device_zte_x9180_proprietary.git" path="vendor/ZTE/X9180" remote="gitlab" revision="cm-12.0" />

</manifest>
```

Make rule for PAC ROM (vendor/pac/products/pac_X9180.mk):

```
# Check for target product
ifeq (pac_X9180,$(TARGET_PRODUCT))

# Bootanimation
PAC_BOOTANIMATION_NAME := 720

# include PAC common configuration
include vendor/pac/config/pac_common.mk

# Inherit CM device configuration
$(call inherit-product, device/ZTE/X9180/cm.mk)

PRODUCT_NAME := pac_X9180

endif
```
