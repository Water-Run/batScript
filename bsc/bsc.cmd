@echo off
setlocal EnableDelayedExpansion

set "BSC_DIR=%~dp0"

where /q pwsh 2>nul
if !errorlevel! == 0 (
    set "PS_EXE=pwsh"
) else (
    set "PS_EXE=powershell"
)

"%PS_EXE%" -NoLogo -NoProfile -ExecutionPolicy Bypass ^
    -File "%BSC_DIR%Main.ps1" %*

exit /b %errorlevel%