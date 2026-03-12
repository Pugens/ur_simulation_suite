@echo off
setlocal

set "ROOT_DIR=%~dp0.."
for %%I in ("%ROOT_DIR%") do set "ROOT_DIR=%%~fI"

set "URCAPS_DIR=%ROOT_DIR%\urcaps"
set "PROGRAMS_DIR=%ROOT_DIR%\programs"
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

docker network inspect ursim_net >nul 2>&1 || docker network create --subnet=192.168.56.0/24 ursim_net

docker run --rm -it --net ursim_net --ip 192.168.56.101 -e ROBOT_MODEL=UR16e -p 6080:6080 -p 29999:29999 -p 30001:30001 -p 30004:30004 -p 30002:30002 -p 50002:50002 -v "%URCAPS_DIR%:/urcaps" -v "%PROGRAMS_DIR%:/ursim/programs" universalrobots/ursim_e-series