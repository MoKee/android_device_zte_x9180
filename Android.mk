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

# WARNING: Everything listed here will be built on ALL platforms,
# including x86, the emulator, and the SDK.  Modules must be uniquely
# named (liblights.tuna), and must build everywhere, or limit themselves
# to only building on ARM if they include assembly. Individual makefiles
# are responsible for having their own logic, for fine-grained control.

LOCAL_PATH := $(call my-dir)

ifeq ($(TARGET_DEVICE),X9180)
include $(call all-makefiles-under,$(LOCAL_PATH))

include $(CLEAR_VARS)

FIRMWARE_ADSP_IMAGES := \
    adsp.b00 adsp.b01 adsp.b02 adsp.b03 adsp.b04 \
    adsp.b05 adsp.b06 adsp.b07 adsp.b08 adsp.b09 \
    adsp.b10 adsp.b11 adsp.b12 adsp.mdt

FIRMWARE_ADSP_SYMLINKS := $(addprefix $(TARGET_OUT_ETC)/firmware/,$(notdir $(FIRMWARE_ADSP_IMAGES)))
$(FIRMWARE_ADSP_SYMLINKS): $(LOCAL_INSTALLED_MODULE)
	@echo "ADSP Firmware link: $@"
	@mkdir -p $(dir $@)
	@rm -rf $@
	$(hide) ln -sf /firmware/image/$(notdir $@) $@

ALL_DEFAULT_INSTALLED_MODULES += $(FIRMWARE_ADSP_SYMLINKS)

FIRMWARE_KEYMASTER_IMAGES := \
    keymaste.b00 keymaste.b01 keymaste.b02 keymaste.b03 keymaste.mdt

FIRMWARE_KEYMASTER_SYMLINKS := $(addprefix $(TARGET_OUT_ETC)/firmware/,$(notdir $(FIRMWARE_KEYMASTER_IMAGES)))
$(FIRMWARE_KEYMASTER_SYMLINKS): $(LOCAL_INSTALLED_MODULE)
	@echo "Keymaste Firmware link: $@"
	@mkdir -p $(dir $@)
	@rm -rf $@
	$(hide) ln -sf /firmware/image/$(notdir $@) $@

ALL_DEFAULT_INSTALLED_MODULES += $(FIRMWARE_KEYMASTER_SYMLINKS)

FIRMWARE_MBA_IMAGES := \
    mba.b00 mba.mdt

FIRMWARE_MBA_SYMLINKS := $(addprefix $(TARGET_OUT_ETC)/firmware/,$(notdir $(FIRMWARE_MBA_IMAGES)))
$(FIRMWARE_MBA_SYMLINKS): $(LOCAL_INSTALLED_MODULE)
	@echo "MBA Firmware link: $@"
	@mkdir -p $(dir $@)
	@rm -rf $@
	$(hide) ln -sf /firmware/image/$(notdir $@) $@

ALL_DEFAULT_INSTALLED_MODULES += $(FIRMWARE_MBA_SYMLINKS)

FIRMWARE_MODEM_IMAGES := \
    modem.b00 modem.b01 modem.b02 modem.b03 modem.b05 modem.b08 \
    modem.b11 modem.b13 modem.b15 modem.b16 modem.b17 modem.b18 \
    modem.b19 modem.b20 modem.b21 modem.b22 modem.b25 modem.mdt

FIRMWARE_MODEM_SYMLINKS := $(addprefix $(TARGET_OUT_ETC)/firmware/,$(notdir $(FIRMWARE_MODEM_IMAGES)))
$(FIRMWARE_MODEM_SYMLINKS): $(LOCAL_INSTALLED_MODULE)
	@echo "Modem Firmware link: $@"
	@mkdir -p $(dir $@)
	@rm -rf $@
	$(hide) ln -sf /firmware/image/$(notdir $@) $@

ALL_DEFAULT_INSTALLED_MODULES += $(FIRMWARE_MODEM_SYMLINKS)

FIRMWARE_WCNSS_IMAGES := \
    wcnss.b00 wcnss.b01 wcnss.b02 wcnss.b04 \
    wcnss.b06 wcnss.b07 wcnss.b08 wcnss.b09 \
    wcnss.mdt

FIRMWARE_WCNSS_SYMLINKS := $(addprefix $(TARGET_OUT_ETC)/firmware/,$(notdir $(FIRMWARE_WCNSS_IMAGES)))
$(FIRMWARE_WCNSS_SYMLINKS): $(LOCAL_INSTALLED_MODULE)
	@echo "WCNSS Firmware link: $@"
	@mkdir -p $(dir $@)
	@rm -rf $@
	$(hide) ln -sf /firmware/image/$(notdir $@) $@

ALL_DEFAULT_INSTALLED_MODULES += $(FIRMWARE_WCNSS_SYMLINKS)

FIRMWARE_WIDEVINE_IMAGES := \
    widevine.b00 widevine.b01 widevine.b02 widevine.b03 widevine.mdt

FIRMWARE_WIDEVINE_SYMLINKS := $(addprefix $(TARGET_OUT_ETC)/firmware/,$(notdir $(FIRMWARE_WIDEVINE_IMAGES)))
$(FIRMWARE_WIDEVINE_SYMLINKS): $(LOCAL_INSTALLED_MODULE)
	@echo "Widevine Firmware link: $@"
	@mkdir -p $(dir $@)
	@rm -rf $@
	$(hide) ln -sf /firmware/image/$(notdir $@) $@

ALL_DEFAULT_INSTALLED_MODULES += $(FIRMWARE_WIDEVINE_SYMLINKS)

FIRMWARE_CMNLIB_IMAGES := \
    cmnlib.b00 cmnlib.b01 cmnlib.b02 cmnlib.b03 cmnlib.mdt

FIRMWARE_CMNLIB_SYMLINKS := $(addprefix $(TARGET_OUT_ETC)/firmware/,$(notdir $(FIRMWARE_CMNLIB_IMAGES)))
$(FIRMWARE_CMNLIB_SYMLINKS): $(LOCAL_INSTALLED_MODULE)
	@echo "Cmnlib Firmware link: $@"
	@mkdir -p $(dir $@)
	@rm -rf $@
	$(hide) ln -sf /firmware/image/$(notdir $@) $@

ALL_DEFAULT_INSTALLED_MODULES += $(FIRMWARE_CMNLIB_SYMLINKS)

FIRMWARE_ISDBTMM_IMAGES := \
    isdbtmm.b00 isdbtmm.b01 isdbtmm.b02 isdbtmm.b03 isdbtmm.mdt

FIRMWARE_ISDBTMM_SYMLINKS := $(addprefix $(TARGET_OUT_ETC)/firmware/,$(notdir $(FIRMWARE_ISDBTMM_IMAGES)))
$(FIRMWARE_ISDBTMM_SYMLINKS): $(LOCAL_INSTALLED_MODULE)
	@echo "Isdbtmm Firmware link: $@"
	@mkdir -p $(dir $@)
	@rm -rf $@
	$(hide) ln -sf /firmware/image/$(notdir $@) $@

ALL_DEFAULT_INSTALLED_MODULES += $(FIRMWARE_ISDBTMM_SYMLINKS)

FIRMWARE_MCV2_IMAGES := \
    mc_v2.b00 mc_v2.b01 mc_v2.b02 mc_v2.b03 mc_v2.mdt

FIRMWARE_MCV2_SYMLINKS := $(addprefix $(TARGET_OUT_ETC)/firmware/,$(notdir $(FIRMWARE_MCV2_IMAGES)))
$(FIRMWARE_MCV2_SYMLINKS): $(LOCAL_INSTALLED_MODULE)
	@echo "Mc_v2 Firmware link: $@"
	@mkdir -p $(dir $@)
	@rm -rf $@
	$(hide) ln -sf /firmware/image/$(notdir $@) $@

ALL_DEFAULT_INSTALLED_MODULES += $(FIRMWARE_MCV2_SYMLINKS)

FIRMWARE_PLAYREAD_IMAGES := \
    playread.b00 playread.b01 playread.b02 playread.b03 playread.mdt

FIRMWARE_PLAYREAD_SYMLINKS := $(addprefix $(TARGET_OUT_ETC)/firmware/,$(notdir $(FIRMWARE_PLAYREAD_IMAGES)))
$(FIRMWARE_PLAYREAD_SYMLINKS): $(LOCAL_INSTALLED_MODULE)
	@echo "Playread Firmware link: $@"
	@mkdir -p $(dir $@)
	@rm -rf $@
	$(hide) ln -sf /firmware/image/$(notdir $@) $@

ALL_DEFAULT_INSTALLED_MODULES += $(FIRMWARE_PLAYREAD_SYMLINKS)

FIRMWARE_VENUS_IMAGES := \
    venus.b00 venus.b01 venus.b02 venus.b03 venus.b04 venus.mdt

FIRMWARE_VENUS_SYMLINKS := $(addprefix $(TARGET_OUT_ETC)/firmware/,$(notdir $(FIRMWARE_VENUS_IMAGES)))
$(FIRMWARE_VENUS_SYMLINKS): $(LOCAL_INSTALLED_MODULE)
	@echo "Venus Firmware link: $@"
	@mkdir -p $(dir $@)
	@rm -rf $@
	$(hide) ln -sf /firmware/image/$(notdir $@) $@

ALL_DEFAULT_INSTALLED_MODULES += $(FIRMWARE_VENUS_SYMLINKS)

FIRMWARE_WCD9306_IMAGES := \
    mbhc.bin wcd9320_anc.bin

FIRMWARE_WCD9306_SYMLINKS := $(addprefix $(TARGET_OUT_ETC)/firmware/wcd9306/,$(notdir $(FIRMWARE_WCD9306_IMAGES)))
$(FIRMWARE_WCD9306_SYMLINKS): $(LOCAL_INSTALLED_MODULE)
	@echo "WCD9306 Firmware link: $@"
	@mkdir -p $(dir $@)
	@rm -rf $@
	$(hide) ln -sf /data/misc/audio/$(notdir $@) $@

ALL_DEFAULT_INSTALLED_MODULES += $(FIRMWARE_WCD9306_SYMLINKS)

endif
