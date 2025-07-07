## @file
# EFI/PI Reference Module Package for All Architectures
#
# (C) Copyright 2014 Hewlett-Packard Development Company, L.P.<BR>
# Copyright (c) 2007 - 2024, Intel Corporation. All rights reserved.<BR>
# Copyright (c) Microsoft Corporation.
# Copyright (C) 2024 Advanced Micro Devices, Inc. All rights reserved.<BR>
#
#    SPDX-License-Identifier: BSD-2-Clause-Patent
#
##

[Defines]
  PLATFORM_NAME                  = spark
  PLATFORM_GUID                  = 587CE499-6CBE-43cd-94E2-186218569478
  PLATFORM_VERSION               = 0.98
  DSC_SPECIFICATION              = 0x00010005
  OUTPUT_DIRECTORY               = Build/spark
  SUPPORTED_ARCHITECTURES        = X64
  BUILD_TARGETS                  = RELEASE
  SKUID_IDENTIFIER               = DEFAULT

!include MdePkg/MdeLibs.dsc.inc

[LibraryClasses]
  #
  # Entry point
  #
  PeiCoreEntryPoint|MdePkg/Library/PeiCoreEntryPoint/PeiCoreEntryPoint.inf
  PeimEntryPoint|MdePkg/Library/PeimEntryPoint/PeimEntryPoint.inf
  DxeCoreEntryPoint|MdePkg/Library/DxeCoreEntryPoint/DxeCoreEntryPoint.inf
  UefiDriverEntryPoint|MdePkg/Library/UefiDriverEntryPoint/UefiDriverEntryPoint.inf
  UefiApplicationEntryPoint|MdePkg/Library/UefiApplicationEntryPoint/UefiApplicationEntryPoint.inf
  #
  # Basic
  #
  BaseLib|MdePkg/Library/BaseLib/BaseLib.inf
  BaseMemoryLib|MdePkg/Library/BaseMemoryLib/BaseMemoryLib.inf
  SynchronizationLib|MdePkg/Library/BaseSynchronizationLib/BaseSynchronizationLib.inf
  PrintLib|MdePkg/Library/BasePrintLib/BasePrintLib.inf
  IoLib|MdePkg/Library/BaseIoLibIntrinsic/BaseIoLibIntrinsic.inf
  PciLib|MdePkg/Library/BasePciLibCf8/BasePciLibCf8.inf
  PciCf8Lib|MdePkg/Library/BasePciCf8Lib/BasePciCf8Lib.inf
  PciSegmentLib|MdePkg/Library/BasePciSegmentLibPci/BasePciSegmentLibPci.inf
  CacheMaintenanceLib|MdePkg/Library/BaseCacheMaintenanceLib/BaseCacheMaintenanceLib.inf
  PeCoffLib|MdePkg/Library/BasePeCoffLib/BasePeCoffLib.inf
  PeCoffGetEntryPointLib|MdePkg/Library/BasePeCoffGetEntryPointLib/BasePeCoffGetEntryPointLib.inf
  SortLib|MdeModulePkg/Library/BaseSortLib/BaseSortLib.inf
  #
  # UEFI & PI
  #
  UefiBootServicesTableLib|MdePkg/Library/UefiBootServicesTableLib/UefiBootServicesTableLib.inf
  UefiRuntimeServicesTableLib|MdePkg/Library/UefiRuntimeServicesTableLib/UefiRuntimeServicesTableLib.inf
  UefiLib|MdePkg/Library/UefiLib/UefiLib.inf
  UefiHiiServicesLib|MdeModulePkg/Library/UefiHiiServicesLib/UefiHiiServicesLib.inf
  HiiLib|MdeModulePkg/Library/UefiHiiLib/UefiHiiLib.inf
  DevicePathLib|MdePkg/Library/UefiDevicePathLib/UefiDevicePathLib.inf
  UefiDecompressLib|MdePkg/Library/BaseUefiDecompressLib/BaseUefiDecompressLib.inf
  PeiServicesTablePointerLib|MdePkg/Library/PeiServicesTablePointerLib/PeiServicesTablePointerLib.inf
  PeiServicesLib|MdePkg/Library/PeiServicesLib/PeiServicesLib.inf
  DxeServicesLib|MdePkg/Library/DxeServicesLib/DxeServicesLib.inf
  DxeServicesTableLib|MdePkg/Library/DxeServicesTableLib/DxeServicesTableLib.inf
  VariablePolicyLib|MdeModulePkg/Library/VariablePolicyLib/VariablePolicyLib.inf
  #
  # Generic Modules
  #

  UefiScsiLib|MdePkg/Library/UefiScsiLib/UefiScsiLib.inf
  SecurityManagementLib|MdeModulePkg/Library/DxeSecurityManagementLib/DxeSecurityManagementLib.inf
  TimerLib|MdePkg/Library/BaseTimerLibNullTemplate/BaseTimerLibNullTemplate.inf
  SerialPortLib|MdePkg/Library/BaseSerialPortLibNull/BaseSerialPortLibNull.inf
  CapsuleLib|MdeModulePkg/Library/DxeCapsuleLibNull/DxeCapsuleLibNull.inf
  PcdLib|MdePkg/Library/BasePcdLibNull/BasePcdLibNull.inf
  CustomizedDisplayLib|MdeModulePkg/Library/CustomizedDisplayLib/CustomizedDisplayLib.inf
  FrameBufferBltLib|MdeModulePkg/Library/FrameBufferBltLib/FrameBufferBltLib.inf
  #
  # Misc
  #
  DebugLib|MdePkg/Library/BaseDebugLibNull/BaseDebugLibNull.inf
  DebugPrintErrorLevelLib|MdePkg/Library/BaseDebugPrintErrorLevelLib/BaseDebugPrintErrorLevelLib.inf
  ReportStatusCodeLib|MdePkg/Library/BaseReportStatusCodeLibNull/BaseReportStatusCodeLibNull.inf
  PeCoffExtraActionLib|MdePkg/Library/BasePeCoffExtraActionLibNull/BasePeCoffExtraActionLibNull.inf
  PerformanceLib|MdePkg/Library/BasePerformanceLibNull/BasePerformanceLibNull.inf
  DebugAgentLib|MdeModulePkg/Library/DebugAgentLibNull/DebugAgentLibNull.inf
  PlatformHookLib|MdeModulePkg/Library/BasePlatformHookLibNull/BasePlatformHookLibNull.inf
  ResetSystemLib|MdeModulePkg/Library/BaseResetSystemLibNull/BaseResetSystemLibNull.inf
  SmbusLib|MdePkg/Library/DxeSmbusLib/DxeSmbusLib.inf
  CpuExceptionHandlerLib|MdeModulePkg/Library/CpuExceptionHandlerLibNull/CpuExceptionHandlerLibNull.inf
  PciHostBridgeLib|MdeModulePkg/Library/PciHostBridgeLibNull/PciHostBridgeLibNull.inf
  TpmMeasurementLib|MdeModulePkg/Library/TpmMeasurementLibNull/TpmMeasurementLibNull.inf
  TdxMeasurementLib|MdeModulePkg/Library/TdxMeasurementLibNull/TdxMeasurementLibNull.inf
  AuthVariableLib|MdeModulePkg/Library/AuthVariableLibNull/AuthVariableLibNull.inf
  VarCheckLib|MdeModulePkg/Library/VarCheckLib/VarCheckLib.inf
  FileExplorerLib|MdeModulePkg/Library/FileExplorerLib/FileExplorerLib.inf
  NonDiscoverableDeviceRegistrationLib|MdeModulePkg/Library/NonDiscoverableDeviceRegistrationLib/NonDiscoverableDeviceRegistrationLib.inf
  ImagePropertiesRecordLib|MdeModulePkg/Library/ImagePropertiesRecordLib/ImagePropertiesRecordLib.inf

  FmpAuthenticationLib|MdeModulePkg/Library/FmpAuthenticationLibNull/FmpAuthenticationLibNull.inf
  CapsuleLib|MdeModulePkg/Library/DxeCapsuleLibNull/DxeCapsuleLibNull.inf
  BmpSupportLib|MdeModulePkg/Library/BaseBmpSupportLib/BaseBmpSupportLib.inf
  SafeIntLib|MdePkg/Library/BaseSafeIntLib/BaseSafeIntLib.inf
  DisplayUpdateProgressLib|MdeModulePkg/Library/DisplayUpdateProgressLibGraphics/DisplayUpdateProgressLibGraphics.inf
  VariablePolicyHelperLib|MdeModulePkg/Library/VariablePolicyHelperLib/VariablePolicyHelperLib.inf
  MmUnblockMemoryLib|MdePkg/Library/MmUnblockMemoryLib/MmUnblockMemoryLibNull.inf
  VariableFlashInfoLib|MdeModulePkg/Library/BaseVariableFlashInfoLib/BaseVariableFlashInfoLib.inf
  IpmiCommandLib|MdeModulePkg/Library/BaseIpmiCommandLibNull/BaseIpmiCommandLibNull.inf
  SpiHcPlatformLib|MdeModulePkg/Library/BaseSpiHcPlatformLibNull/BaseSpiHcPlatformLibNull.inf

[LibraryClasses.EBC.PEIM]
  IoLib|MdePkg/Library/PeiIoLibCpuIo/PeiIoLibCpuIo.inf

[LibraryClasses.common.PEI_CORE]
  HobLib|MdePkg/Library/PeiHobLib/PeiHobLib.inf
  MemoryAllocationLib|MdePkg/Library/PeiMemoryAllocationLib/PeiMemoryAllocationLib.inf

[LibraryClasses.common.PEIM]
  HobLib|MdePkg/Library/PeiHobLib/PeiHobLib.inf
  MemoryAllocationLib|MdePkg/Library/PeiMemoryAllocationLib/PeiMemoryAllocationLib.inf
  ExtractGuidedSectionLib|MdePkg/Library/PeiExtractGuidedSectionLib/PeiExtractGuidedSectionLib.inf
  LockBoxLib|MdeModulePkg/Library/SmmLockBoxLib/SmmLockBoxPeiLib.inf
  DevicePathLib|MdePkg/Library/UefiDevicePathLib/UefiDevicePathLibBase.inf

[LibraryClasses.common.DXE_CORE]
  HobLib|MdePkg/Library/DxeCoreHobLib/DxeCoreHobLib.inf
  MemoryAllocationLib|MdeModulePkg/Library/DxeCoreMemoryAllocationLib/DxeCoreMemoryAllocationLib.inf
  ExtractGuidedSectionLib|MdePkg/Library/DxeExtractGuidedSectionLib/DxeExtractGuidedSectionLib.inf

[LibraryClasses.common.DXE_DRIVER]
  HobLib|MdePkg/Library/DxeHobLib/DxeHobLib.inf
  LockBoxLib|MdeModulePkg/Library/SmmLockBoxLib/SmmLockBoxDxeLib.inf
  MemoryAllocationLib|MdePkg/Library/UefiMemoryAllocationLib/UefiMemoryAllocationLib.inf
  ExtractGuidedSectionLib|MdePkg/Library/DxeExtractGuidedSectionLib/DxeExtractGuidedSectionLib.inf
  CapsuleLib|MdeModulePkg/Library/DxeCapsuleLibFmp/DxeCapsuleLib.inf

[LibraryClasses.common.DXE_RUNTIME_DRIVER]
  HobLib|MdePkg/Library/DxeHobLib/DxeHobLib.inf
  MemoryAllocationLib|MdePkg/Library/UefiMemoryAllocationLib/UefiMemoryAllocationLib.inf
  DebugLib|MdePkg/Library/UefiDebugLibConOut/UefiDebugLibConOut.inf
  LockBoxLib|MdeModulePkg/Library/SmmLockBoxLib/SmmLockBoxDxeLib.inf
  CapsuleLib|MdeModulePkg/Library/DxeCapsuleLibFmp/DxeRuntimeCapsuleLib.inf
  VariablePolicyLib|MdeModulePkg/Library/VariablePolicyLib/VariablePolicyLibRuntimeDxe.inf

[LibraryClasses.common.SMM_CORE]
  HobLib|MdePkg/Library/DxeHobLib/DxeHobLib.inf
  MemoryAllocationLib|MdeModulePkg/Library/PiSmmCoreMemoryAllocationLib/PiSmmCoreMemoryAllocationLib.inf
  SmmServicesTableLib|MdeModulePkg/Library/PiSmmCoreSmmServicesTableLib/PiSmmCoreSmmServicesTableLib.inf
  SmmCorePlatformHookLib|MdeModulePkg/Library/SmmCorePlatformHookLibNull/SmmCorePlatformHookLibNull.inf
  SmmMemLib|MdePkg/Library/SmmMemLib/SmmMemLib.inf

[LibraryClasses.common.DXE_SMM_DRIVER]
  HobLib|MdePkg/Library/DxeHobLib/DxeHobLib.inf
  DebugLib|MdePkg/Library/BaseDebugLibNull/BaseDebugLibNull.inf
  MemoryAllocationLib|MdePkg/Library/SmmMemoryAllocationLib/SmmMemoryAllocationLib.inf
  MmServicesTableLib|MdePkg/Library/MmServicesTableLib/MmServicesTableLib.inf
  SmmServicesTableLib|MdePkg/Library/SmmServicesTableLib/SmmServicesTableLib.inf
  LockBoxLib|MdeModulePkg/Library/SmmLockBoxLib/SmmLockBoxSmmLib.inf
  SmmMemLib|MdePkg/Library/SmmMemLib/SmmMemLib.inf

[LibraryClasses.common.UEFI_DRIVER]
  HobLib|MdePkg/Library/DxeHobLib/DxeHobLib.inf
  MemoryAllocationLib|MdePkg/Library/UefiMemoryAllocationLib/UefiMemoryAllocationLib.inf
  DebugLib|MdePkg/Library/UefiDebugLibConOut/UefiDebugLibConOut.inf
  LockBoxLib|MdeModulePkg/Library/SmmLockBoxLib/SmmLockBoxDxeLib.inf

[LibraryClasses.common.UEFI_APPLICATION]
  HobLib|MdePkg/Library/DxeHobLib/DxeHobLib.inf
  MemoryAllocationLib|MdePkg/Library/UefiMemoryAllocationLib/UefiMemoryAllocationLib.inf
  DebugLib|MdePkg/Library/UefiDebugLibStdErr/UefiDebugLibStdErr.inf
  FileHandleLib|MdePkg/Library/UefiFileHandleLib/UefiFileHandleLib.inf

[LibraryClasses.common.MM_STANDALONE]
  HobLib|MdeModulePkg/Library/BaseHobLibNull/BaseHobLibNull.inf
  MemoryAllocationLib|MdeModulePkg/Library/BaseMemoryAllocationLibNull/BaseMemoryAllocationLibNull.inf
  StandaloneMmDriverEntryPoint|MdePkg/Library/StandaloneMmDriverEntryPoint/StandaloneMmDriverEntryPoint.inf
  MmServicesTableLib|MdePkg/Library/StandaloneMmServicesTableLib/StandaloneMmServicesTableLib.inf
  LockBoxLib|MdeModulePkg/Library/SmmLockBoxLib/SmmLockBoxStandaloneMmLib.inf
  MemLib|StandaloneMmPkg/Library/StandaloneMmMemLib/StandaloneMmMemLib.inf
  VarCheckHiiLibMmDependency|MdeModulePkg/Library/VarCheckHiiLib/VarCheckHiiLibMmDependency.inf
  VarCheckHiiLib|MdeModulePkg/Library/VarCheckHiiLib/VarCheckHiiLibStandaloneMm.inf

[LibraryClasses.ARM, LibraryClasses.AARCH64]
  LockBoxLib|MdeModulePkg/Library/LockBoxNullLib/LockBoxNullLib.inf
  ArmSmcLib|MdePkg/Library/ArmSmcLib/ArmSmcLib.inf
  ArmSvcLib|MdePkg/Library/ArmSvcLib/ArmSvcLib.inf

[LibraryClasses.EBC, LibraryClasses.RISCV64, LibraryClasses.LOONGARCH64]
  LockBoxLib|MdeModulePkg/Library/LockBoxNullLib/LockBoxNullLib.inf

[PcdsFeatureFlag]
  gEfiMdePkgTokenSpaceGuid.PcdDriverDiagnostics2Disable|TRUE
  gEfiMdePkgTokenSpaceGuid.PcdComponentName2Disable|TRUE
  gEfiMdeModulePkgTokenSpaceGuid.PcdInstallAcpiSdtProtocol|TRUE
  gEfiMdeModulePkgTokenSpaceGuid.PcdDevicePathSupportDevicePathFromText|FALSE
  gEfiMdeModulePkgTokenSpaceGuid.PcdDevicePathSupportDevicePathToText|FALSE

[PcdsFixedAtBuild]
  gEfiMdePkgTokenSpaceGuid.PcdDebugPropertyMask|0x0f
  gEfiMdePkgTokenSpaceGuid.PcdReportStatusCodePropertyMask|0x06
  gEfiMdeModulePkgTokenSpaceGuid.PcdMaxSizeNonPopulateCapsule|0x0
  gEfiMdeModulePkgTokenSpaceGuid.PcdMaxSizePopulateCapsule|0x0
  gEfiMdeModulePkgTokenSpaceGuid.PcdMaxPeiPerformanceLogEntries|28

[PcdsDynamicExDefault]
  gEfiMdeModulePkgTokenSpaceGuid.PcdRecoveryFileName|L"FVMAIN.FV"

[Components]
  .spark\spark.inf
  MdeModulePkg/Library/UefiSortLib/UefiSortLib.inf
  MdeModulePkg/Library/BaseSortLib/BaseSortLib.inf
  MdeModulePkg/Library/CustomizedDisplayLib/CustomizedDisplayLib.inf
  MdeModulePkg/Library/DebugAgentLibNull/DebugAgentLibNull.inf
  MdeModulePkg/Library/LockBoxNullLib/LockBoxNullLib.inf
  MdeModulePkg/Library/PciHostBridgeLibNull/PciHostBridgeLibNull.inf
  MdeModulePkg/Library/PiSmmCoreSmmServicesTableLib/PiSmmCoreSmmServicesTableLib.inf
  MdeModulePkg/Library/UefiHiiServicesLib/UefiHiiServicesLib.inf
  MdeModulePkg/Library/BaseHobLibNull/BaseHobLibNull.inf
  MdeModulePkg/Library/BaseMemoryAllocationLibNull/BaseMemoryAllocationLibNull.inf
  MdeModulePkg/Library/VariablePolicyHelperLib/VariablePolicyHelperLib.inf
  MdeModulePkg/Library/ImagePropertiesRecordLib/ImagePropertiesRecordLib.inf

  MdeModulePkg/Library/DxeCapsuleLibNull/DxeCapsuleLibNull.inf
  MdeModulePkg/Library/UefiMemoryAllocationProfileLib/UefiMemoryAllocationProfileLib.inf
  MdeModulePkg/Library/DxeCoreMemoryAllocationLib/DxeCoreMemoryAllocationLib.inf
  MdeModulePkg/Library/DxeCoreMemoryAllocationLib/DxeCoreMemoryAllocationProfileLib.inf
  MdeModulePkg/Library/DxeCorePerformanceLib/DxeCorePerformanceLib.inf
  MdeModulePkg/Library/DxePerformanceLib/DxePerformanceLib.inf
  MdeModulePkg/Library/DxeResetSystemLib/DxeResetSystemLib.inf
  MdeModulePkg/Library/DxePrintLibPrint2Protocol/DxePrintLibPrint2Protocol.inf
  MdeModulePkg/Library/PeiPerformanceLib/PeiPerformanceLib.inf
  MdeModulePkg/Library/PeiResetSystemLib/PeiResetSystemLib.inf
  MdeModulePkg/Library/UefiHiiLib/UefiHiiLib.inf
  MdeModulePkg/Library/ResetUtilityLib/ResetUtilityLib.inf
  MdeModulePkg/Library/BaseResetSystemLibNull/BaseResetSystemLibNull.inf
  MdeModulePkg/Library/DxeSecurityManagementLib/DxeSecurityManagementLib.inf
  MdeModulePkg/Library/OemHookStatusCodeLibNull/OemHookStatusCodeLibNull.inf

  MdeModulePkg/Library/PeiDebugLibDebugPpi/PeiDebugLibDebugPpi.inf
  MdeModulePkg/Library/BootLogoLib/BootLogoLib.inf
  MdeModulePkg/Library/TpmMeasurementLibNull/TpmMeasurementLibNull.inf
  MdeModulePkg/Library/TdxMeasurementLibNull/TdxMeasurementLibNull.inf
  MdeModulePkg/Library/AuthVariableLibNull/AuthVariableLibNull.inf
  MdeModulePkg/Library/VariablePolicyLib/VariablePolicyLib.inf
  MdeModulePkg/Library/VariablePolicyLib/VariablePolicyLibRuntimeDxe.inf
  MdeModulePkg/Library/VarCheckPolicyLib/VarCheckPolicyLib.inf
  MdeModulePkg/Library/VarCheckPolicyLib/VarCheckPolicyLibStandaloneMm.inf
  MdeModulePkg/Library/VarCheckLib/VarCheckLib.inf
  MdeModulePkg/Library/VarCheckHiiLib/VarCheckHiiLib.inf
  MdeModulePkg/Library/VarCheckPcdLib/VarCheckPcdLib.inf
  MdeModulePkg/Library/VarCheckHiiLib/VarCheckHiiLibMmDependency.inf
  MdeModulePkg/Library/VarCheckHiiLib/VarCheckHiiLibStandaloneMm.inf
  MdeModulePkg/Library/BaseIpmiLibNull/BaseIpmiLibNull.inf
  MdeModulePkg/Library/PeiIpmiLibIpmiPpi/PeiIpmiLibIpmiPpi.inf
  MdeModulePkg/Library/SmmIpmiLibSmmIpmiProtocol/SmmIpmiLibSmmIpmiProtocol.inf
  MdeModulePkg/Library/BaseIpmiCommandLibNull/BaseIpmiCommandLibNull.inf
  MdeModulePkg/Library/FrameBufferBltLib/FrameBufferBltLib.inf
  MdeModulePkg/Library/NonDiscoverableDeviceRegistrationLib/NonDiscoverableDeviceRegistrationLib.inf
  MdeModulePkg/Library/BaseBmpSupportLib/BaseBmpSupportLib.inf
  MdeModulePkg/Library/DisplayUpdateProgressLibGraphics/DisplayUpdateProgressLibGraphics.inf
  MdeModulePkg/Library/DisplayUpdateProgressLibText/DisplayUpdateProgressLibText.inf
  MdeModulePkg/Library/BaseRngLibTimerLib/BaseRngLibTimerLib.inf
  MdeModulePkg/Library/HobPrintLib/HobPrintLib.inf


[Components.IA32, Components.X64, Components.ARM, Components.AARCH64]
  MdeModulePkg/Library/LzmaCustomDecompressLib/LzmaCustomDecompressLib.inf
  MdeModulePkg/Library/VarCheckUefiLib/VarCheckUefiLib.inf
  MdeModulePkg/Library/SmmCorePlatformHookLibNull/SmmCorePlatformHookLibNull.inf
  MdeModulePkg/Library/SmmSmiHandlerProfileLib/SmmSmiHandlerProfileLib.inf
  MdeModulePkg/Library/SmmSmiHandlerProfileLib/StandaloneMmSmiHandlerProfileLib.inf
  MdeModulePkg/Library/LzmaCustomDecompressLib/LzmaArchCustomDecompressLib.inf
  MdeModulePkg/Library/BaseSpiHcPlatformLibNull/BaseSpiHcPlatformLibNull.inf
[Components.X64]


[Components.ARM, Components.AARCH64]
  MdeModulePkg/Library/ArmFfaLib/ArmFfaPeiLib.inf
  MdeModulePkg/Library/ArmFfaLib/ArmFfaDxeLib.inf
  MdeModulePkg/Library/ArmFfaLib/ArmFfaStandaloneMmCoreLib.inf
  MdeModulePkg/Library/ArmFfaLib/ArmFfaStandaloneMmLib.inf

[BuildOptions]

