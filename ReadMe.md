# spark-edk2

**spark-edk2** is a custom bootloader built on top of [EDK II (TianoCore)](https://github.com/tianocore/edk2), offering a modular and extensible platform for modern UEFI development. Designed to be simple to build and extend.

---

## 🚀 Features

- UEFI-compatible bootloader based on EDK II
- Support for x86_64 (X64) architecture
- Uses Visual Studio 2022 toolchain
- Includes custom variable configuration script (`var.bat`)
- Simplified build process for Windows development environments

---

## 📦 Prerequisites

- Windows with `Visual Studio 2022` and `nmake`
- Git
- A terminal (e.g., Command Prompt or PowerShell)

---

## ⚙️ Build Instructions (Windows)

```bat
:: Clone the repository
git clone https://github.com/rustbuilderz/spark-edk2
cd spark-edk2

:: Initialize the EDK II environment
edksetup.bat

:: Build the BaseTools (errors may occur—safe to ignore)
cd BaseTools
nmake all

:: Set custom environment variables
cd ..
var.bat

:: IMPORTANT: Close and reopen the terminal to apply variable changes

:: Re-initialize EDK II setup
cd spark-edk2
edksetup.bat

:: Build the bootloader
build
