@echo off
setlocal enabledelayedexpansion

REM --------------------------------------
REM Verificar si Riot Games está instalado
echo Verificando si Riot Games está instalado...
set RIOT_DIR="C:\Riot Games"
if exist !RIOT_DIR! (
    echo Riot Games está instalado en !RIOT_DIR! >> riot_report.txt
) else (
    echo Riot Games no está instalado. >> riot_report.txt
    echo No se puede continuar sin Riot Games instalado.
    pause
    exit /b
)

REM --------------------------------------
REM Listar juegos instalados en Riot Games
echo Listando juegos instalados en Riot Games... >> riot_report.txt
if exist "!RIOT_DIR!\League of Legends" (
    echo League of Legends está instalado. >> riot_report.txt
)

if exist "!RIOT_DIR!\VALORANT" (
    echo Valorant está instalado. >> riot_report.txt
)

if exist "!RIOT_DIR!\Riot Client" (
    echo Riot Client está instalado. >> riot_report.txt
)

echo -------------------------------------- >> riot_report.txt
echo Juegos instalados: >> riot_report.txt
echo - League of Legends (Si está instalado) >> riot_report.txt
echo - Valorant (Si está instalado) >> riot_report.txt
echo - Riot Client (Si está instalado) >> riot_report.txt

REM --------------------------------------
REM Buscar y matar los procesos asociados a los puertos utilizados por Riot Games (por defecto 4500-4550, etc.)
echo Matar procesos que utilizan puertos de Riot Games... >> riot_report.txt
for /f "tokens=5" %%a in ('netstat -ano ^| findstr ":4500"') do (
    echo Matando proceso con PID %%a en el puerto 4500... >> riot_report.txt
    taskkill /F /PID %%a
)

for /f "tokens=5" %%a in ('netstat -ano ^| findstr ":4501"') do (
    echo Matando proceso con PID %%a en el puerto 4501... >> riot_report.txt
    taskkill /F /PID %%a
)

for /f "tokens=5" %%a in ('netstat -ano ^| findstr ":4502"') do (
    echo Matando proceso con PID %%a en el puerto 4502... >> riot_report.txt
    taskkill /F /PID %%a
)

REM --------------------------------------
REM Desinstalar los juegos de Riot Games
echo Desinstalando juegos de Riot Games... >> riot_report.txt

REM Desinstalar League of Legends
echo Desinstalando League of Legends... >> riot_report.txt
if exist "!RIOT_DIR!\League of Legends\uninstall.exe" (
    "!RIOT_DIR!\League of Legends\uninstall.exe" /S
    echo League of Legends desinstalado. >> riot_report.txt
)

REM Desinstalar Valorant
echo Desinstalando Valorant... >> riot_report.txt
if exist "!RIOT_DIR!\VALORANT\uninstall.exe" (
    "!RIOT_DIR!\VALORANT\uninstall.exe" /S
    echo Valorant desinstalado. >> riot_report.txt
)

REM Desinstalar Riot Client
echo Desinstalando Riot Client... >> riot_report.txt
if exist "!RIOT_DIR!\Riot Client\uninstall.exe" (
    "!RIOT_DIR!\Riot Client\uninstall.exe" /S
    echo Riot Client desinstalado. >> riot_report.txt
)

REM --------------------------------------
echo Proceso completo. La información ha sido guardada en riot_report.txt.
pause
