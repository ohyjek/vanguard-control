@echo off

set SERVICE_NAME=vgc

echo Command-line argument: %1

REM Check command-line argument
if /I "%1"=="start" (
    echo Start argument detected.
    goto start_service
) else if /I "%1"=="stop" (
    echo Stop argument detected.
    goto stop_service
) else if /I "%1"=="disable" (
    echo Disable argument detected.
    goto disable_service
) else if /I "%1"=="enable" (
    echo Enable argument detected.
    goto enable_service
) else (
    echo Invalid argument: %1
    echo Usage: %0 ^<start^|stop^>
    exit /b 1
)

REM Start the service
:start_service
echo Attempting to start %SERVICE_NAME%...
net start %SERVICE_NAME%
echo net start returned error level: %errorlevel%
if %errorlevel%==0 (
    echo %SERVICE_NAME% started successfully.
) else (
    echo Failed to start %SERVICE_NAME% or it is already running.
)
goto :eof

REM Stop the service
:stop_service
echo Attempting to stop %SERVICE_NAME%...
net stop %SERVICE_NAME%
echo net stop returned error level: %errorlevel%
if %errorlevel%==0 (
    echo %SERVICE_NAME% stopped successfully.
) else (
    echo Failed to stop %SERVICE_NAME% or it is not running.
)
goto :eof

REM Disable the service
:disable_service
echo Attempting to disable %SERVICE_NAME%...
sc config %SERVICE_NAME% start= disabled
echo sc config start= disabled returned error level: %errorlevel%
if %errorlevel%==0 (
    echo %SERVICE_NAME% disabled successfully.
) else (
    echo Failed to disable %SERVICE_NAME%.
)
goto :eof

REM Function to set the service to manual
:enable_service
echo Attempting to set %SERVICE_NAME% to manual...
sc config %SERVICE_NAME% start= demand
echo sc config returned error level: %errorlevel%
if %errorlevel%==0 (
    echo %SERVICE_NAME% set to manual successfully.
) else (
    echo Failed to set %SERVICE_NAME% to manual.
)
goto :eof
