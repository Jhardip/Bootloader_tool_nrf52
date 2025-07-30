@echo off
title nRF52 DFU-Bootloader Flash Tool
cls

:: Get the directory where the script is located
set SCRIPT_DIR=%~dp0

:: Path to adafruit-nrfutil.exe in the same folder as script
set NRFUTIL_PATH="%SCRIPT_DIR%adafruit-nrfutil.exe"

:: Bootloader ZIPs (or replace with your custom .zip build)
set ZIP1="Seeed_XIAO_nRF52840_Sense_bootloader-0.6.1.ZIP"
set ZIP2="xiao_nrf52840_ble_sense_bootloader-0.9.2_s140_7.3.0.ZIP"
set ZIP3="wiscore_rak4631_board_bootloader-0.4.3_s140_6.1.1.ZIP"
set ZIP4="wiscore_rak4631_board_bootloader_old.ZIP"

:MENU
echo ==========================================
echo Select Device:
echo [1] Seeed XIAO nRF52840 Sense (v0.6.1)
echo [2] XIAO BLE Sense (v0.9.2)
echo [3] WisCore RAK4631 (v0.4.3)
echo [4] WisCore RAK4631 (OLD)
echo [5] Custom Firmware (provide path)
echo ==========================================
set /p choice="Enter choice [1-5]: "

if "%choice%"=="1" set DEVICE=%ZIP1%
if "%choice%"=="2" set DEVICE=%ZIP2%
if "%choice%"=="3" set DEVICE=%ZIP3%
if "%choice%"=="4" set DEVICE=%ZIP4%
if "%choice%"=="5" goto CUSTOM

if not defined DEVICE (
    echo Invalid choice! Try again.
    goto MENU
)

goto COMPORT

:CUSTOM
set /p DEVICE="Enter full path to firmware ZIP: "

:COMPORT
set /p COMNUM="Enter COM port number only (e.g., 23): "
set COMPORT=COM%COMNUM%

echo.
echo Running DFU update...
echo %NRFUTIL_PATH% --verbose dfu serial --package %DEVICE% --port %COMPORT% -b 115200 --singlebank --touch 1200
pause
%NRFUTIL_PATH% --verbose dfu serial --package %DEVICE% --port %COMPORT% -b 115200 --singlebank --touch 1200
echo.
echo Done!
pause
goto MENU
