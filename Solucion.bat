@echo off
setlocal enabledelayedexpansion

REM --------------------------------------
REM Verificar si hay procesos usando el puerto 3306 (MySQL/MariaDB)
echo Verificando puertos ocupados que podrían interferir con MySQL/MariaDB...

REM Verificar si el puerto 3306 está ocupado
for /f "tokens=5" %%a in ('netstat -ano ^| findstr ":3306"') do (
    echo El puerto 3306 está ocupado por el proceso con PID %%a.
    echo Matando proceso con PID %%a... >> mysql_mariadb_report.txt
    taskkill /F /PID %%a
)

REM Verificar si el puerto 3307 está ocupado
for /f "tokens=5" %%a in ('netstat -ano ^| findstr ":3307"') do (
    echo El puerto 3307 está ocupado por el proceso con PID %%a.
    echo Matando proceso con PID %%a... >> mysql_mariadb_report.txt
    taskkill /F /PID %%a
)

REM Verificar si el puerto 3308 está ocupado (puerto alternativo)
for /f "tokens=5" %%a in ('netstat -ano ^| findstr ":3308"') do (
    echo El puerto 3308 está ocupado por el proceso con PID %%a.
    echo Matando proceso con PID %%a... >> mysql_mariadb_report.txt
    taskkill /F /PID %%a
)

REM --------------------------------------
REM Guardar información del proceso en el archivo
echo -------------------------------------- >> mysql_mariadb_report.txt
echo Los puertos 3306, 3307 y 3308 han sido verificados y se han matado los procesos que los ocupaban. >> mysql_mariadb_report.txt

REM --------------------------------------
echo El script ha terminado. La información ha sido guardada en mysql_mariadb_report.txt.
pause
