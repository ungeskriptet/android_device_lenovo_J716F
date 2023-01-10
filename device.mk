#
# Copyright (C) 2023 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Installs gsi keys into ramdisk, to boot a developer GSI with verified boot.
$(call inherit-product, $(SRC_TARGET_DIR)/product/developer_gsi_keys.mk)

# A/B
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota.mk)

PRODUCT_PACKAGES += \
    android.hardware.boot@1.2-impl \
    android.hardware.boot@1.2-impl.recovery \
    android.hardware.boot@1.2-service

PRODUCT_PACKAGES += \
    update_engine \
    update_engine_sideload \
    update_verifier

PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/prebuilts/dtb.img:dtb.img

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    FILESYSTEM_TYPE_system=ext4 \
    POSTINSTALL_OPTIONAL_system=true

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_vendor=true \
    POSTINSTALL_PATH_vendor=bin/checkpoint_gc \
    FILESYSTEM_TYPE_vendor=ext4 \
    POSTINSTALL_OPTIONAL_vendor=true

PRODUCT_PACKAGES += \
    checkpoint_gc \
    otapreopt_script

# fastbootd
PRODUCT_PACKAGES += \
    android.hardware.fastboot@1.1-impl-mock \
    fastbootd

# Health
PRODUCT_PACKAGES += \
    android.hardware.health@2.1-impl \
    android.hardware.health@2.1-service

# Overlays
PRODUCT_ENFORCE_RRO_TARGETS := *

# Partitions
PRODUCT_BUILD_SUPER_PARTITION := false
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# Product characteristics
PRODUCT_CHARACTERISTICS := nosdcard

# Rootdir
PRODUCT_PACKAGES += \
    copy_aplog.sh \
    init.mdm.sh \
    init.qcom.sh \
    auto_save_stop_aplog.sh \
    catch_aplog.sh \
    init.crda.sh \
    init.qcom.coex.sh \
    init.qti.display_boot.sh \
    init.qcom.early_boot.sh \
    init.qcom.post_boot.sh \
    init.qcom.class_core.sh \
    batterylog.sh \
    kernellog.sh \
    modemlog_setup.sh \
    qca6234-service.sh \
    init.qti.qcv.sh \
    init.qti.media.sh \
    modemlog.sh \
    performancelog.sh \
    aplog.sh \
    init.qcom.usb.sh \
    init.qcom.efs.sync.sh \
    init.qcom.sdio.sh \
    batterylogcontrol.sh \
    init.qti.dcvs.sh \
    init.class_main.sh \
    init.qti.chg_policy.sh \
    qseelog.sh \
    stop_aplog.sh \
    init.qcom.sensors.sh \
    clean_aplog.sh \

PRODUCT_PACKAGES += \
    fstab.qcom \
    init.qcom.factory.rc \
    init.target.wigig.rc \
    init.qcom.usb.rc \
    init.target.rc \
    init.qcom.rc \
    init.qti.ufs.rc \
    init.recovery.qcom.rc \

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/etc/fstab.qcom:$(TARGET_VENDOR_RAMDISK_OUT)/first_stage_ramdisk/fstab.qcom

# Shipping API level
PRODUCT_SHIPPING_API_LEVEL := 30

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH)

# Inherit the proprietary files
$(call inherit-product, vendor/lenovo/J716F/J716F-vendor.mk)
