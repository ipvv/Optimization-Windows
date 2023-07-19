@echo off
REM Check if running with administrator privileges
NET SESSION >nul 2>&1
if %errorLevel% neq 0 (
    echo This script needs to be run as an administrator.
    echo Please right-click on the file and select "Run as administrator".
    pause
    exit /b
)

REM Display logo and information
echo.
echo                   ( (
echo                  ) )
echo                   ____  
echo                 ^|    ^|_ 
echo                 ^|    ^|_)
echo                 \____/
echo.
echo                Optimization
echo ========================================================
echo     Name: Riyadh
echo     Bio: Expert in operating systems and cybersecurity.
echo     Social Media:
echo    - Twitter:  https://twitter.com/ip_v0
echo    - Github: https://github.com/ipvv
echo.
echo --------------------------------------------------------
echo.

:start
echo 1. System Optimization
echo 2. Network Optimization
echo 3. Reset All Settings as Default
echo 4. Exit

set /p choice=Enter your choice: 

if "%choice%"=="1" (
    echo Running System Optimization commands...
    echo.
    
    REM System Optimization commands
    setlocal enabledelayedexpansion
    
    for /f "tokens=2 delims==" %%a in ('wmic os get TotalVisibleMemorySize /format:value') do set mem=%%a
    set /a ram=mem + 1024000
    REG ADD "HKLM\SYSTEM\CurrentControlSet\Control" /v "SvcHostSplitThresholdInKB" /t REG_DWORD /d "!ram!" /f
    
    REM Check if power scheme already exists
    powercfg -list | findstr "8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c"
    if %errorlevel% equ 0 (
        echo Power scheme already exists.
    ) else (
        REM Create a new power scheme
        powercfg -duplicatescheme 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c
        echo New power scheme created.
    )
    
    powercfg -setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c
    REG ADD "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\MicrosoftEdgeUpdate.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 00000001 /f
    REG ADD "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\MicrosoftEdgeUpdate.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 00000000 /f
    
    echo System Optimization completed.
    echo.
    pause
    goto start
) else if "%choice%"=="2" (
    echo Running Network Optimization commands...
    echo.
    
    REM Network Optimization commands
    netsh int tcp set global autotuninglevel=highlyrestricted
    netsh int tcp set global chimney=disabled
    netsh int tcp set global rss=disabled
    netsh interface tcp set global congestionprovider=ctcp
    netsh interface tcp set global ecncapability=disabled
    netsh interface tcp set global timestamps=disabled
    netsh interface tcp set global netdma=enabled
    
    echo Network Optimization completed.
    echo.
    pause
    goto start
) else if "%choice%"=="3" (
    echo Resetting All Settings as Default...
    echo.
    
    REM Reset All Settings commands
    REM Reset network settings
    netsh int ip reset
    netsh winsock reset
    
    REM Reset firewall settings
    netsh advfirewall reset
    
    REM Reset power settings
    powercfg -restoredefaultschemes
    
    REM Reset Windows Explorer settings
    reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "ShellState" /f
    reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Streams" /f
    
    
    echo All Settings reset to default.
    echo.
    pause
    goto start
) else if "%choice%"=="4" (
    exit
) else (
    echo Invalid choice. Please try again.
    echo.
    pause
    goto start
)
