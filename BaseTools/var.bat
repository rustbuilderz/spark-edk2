@echo off
rem — compute the parent of %CD%
for %%A in ("%CD%\..") do (
  rem %%~fA  = fully-qualified path of “%CD%\..”
  rem add a trailing backslash if you need it
  set "PARENT=%%~fA\"
)

setx WORKSPACE "C:\Users\white\Documents\spark-edk2"
echo %WORKSPACE%
setx EDK_TOOLS_PATH %WORKSPACE%\BaseTools
echo %EDK_TOOLS_PATH%
setx EDK_TOOLS_BIN %WORKSPACE%\BaseTools\Bin\Win32
echo %EDK_TOOLS_BIN
setx CONF_PATH %WORKSPACE%\Conf
echo %CONF_PATH%

set "outfile=%WORKSPACE%\Conf\target.txt"

> "%outfile%" (
    echo ACTIVE_PLATFORM       = MdeModulePkg/MdeModulePkg.dsc
    echo TARGET                = RELEASE
    echo TARGET_ARCH           = X64
    echo TOOL_CHAIN_CONF       = Conf/tools_def.txt
    echo TOOL_CHAIN_TAG        = VS2022
    echo BUILD_RULE_CONF = Conf/build_rule.txt
)

echo Config written to %outfile%


echo ============================
echo      Done restart terminal
echo ============================
