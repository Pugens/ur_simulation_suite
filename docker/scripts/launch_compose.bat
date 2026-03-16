@echo off
setlocal

set "ROOT_DIR=%~dp0..\.."
for %%I in ("%ROOT_DIR%") do set "ROOT_DIR=%%~fI"
set "DOCKER_DIR=%~dp0.."
for %%I in ("%DOCKER_DIR%") do set "DOCKER_DIR=%%~fI"

set "URCAPS_DIR=%ROOT_DIR%\urcaps"
set "URCAP_URL=https://github.com/UniversalRobots/Universal_Robots_ExternalControl_URCap/releases/download/v1.0.5/externalcontrol-1.0.5.urcap"
set "URCAP_FILE=%URCAPS_DIR%\externalcontrol-1.0.5.urcap"
set "URCAP_JAR=%URCAPS_DIR%\externalcontrol-1.0.5.jar"

if not exist "%URCAPS_DIR%" mkdir "%URCAPS_DIR%"

if not exist "%URCAP_FILE%" (
    echo Downloading externalcontrol-1.0.5.urcap...
    powershell -NoProfile -ExecutionPolicy Bypass -Command "Invoke-WebRequest -Uri '%URCAP_URL%' -OutFile '%URCAP_FILE%'"
    if errorlevel 1 (
        echo Failed to download URCap from GitHub.
        exit /b 1
    )
)

copy /Y "%URCAP_FILE%" "%URCAP_JAR%" >nul
if errorlevel 1 (
    echo Failed to prepare externalcontrol-1.0.5.jar.
    exit /b 1
)

docker compose -f "%DOCKER_DIR%\docker-compose.yml" up --build -d
