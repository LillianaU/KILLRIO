@echo off
REM ---- Paso 1: Mostrar puertos ocupados que podrían interferir con MySQL/MariaDB ----
echo Verificando puertos ocupados que podrían interferir con MySQL/MariaDB...

netstat -ano | findstr ":3306" > puerto_3306.txt
netstat -ano | findstr ":3307" > puerto_3307.txt
netstat -ano | findstr ":3308" > puerto_3308.txt

echo -----------------------------------------
echo Los siguientes puertos podrían estar ocupados:
echo - Puerto 3306 (MySQL/MariaDB)
echo - Puerto 3307 (MariaDB alternativo)
echo - Otros puertos cercanos (3308)
echo -----------------------------------------

REM Mostrar el contenido de los archivos de puertos ocupados
type puerto_3306.txt
type puerto_3307.txt
type puerto_3308.txt

REM ---- Paso 2: Matar procesos que consumen los puertos 3306 y 3307 ----
echo -----------------------------------------
echo Matando procesos que consumen los puertos 3306 y 3307...
for /f "tokens=5" %%a in ('netstat -ano ^| findstr :3306') do (
    echo Matando proceso con PID %%a en el puerto 3306...
    taskkill /F /PID %%a
)

for /f "tokens=5" %%a in ('netstat -ano ^| findstr :3307') do (
    echo Matando proceso con PID %%a en el puerto 3307...
    taskkill /F /PID %%a
)

REM ---- Paso 3: Verificar si hay problemas con los servicios de MySQL/MariaDB ----
echo -----------------------------------------
echo Verificando estado de los servicios de MySQL/MariaDB...
sc query MySQL > nul
if %errorlevel% neq 0 (
    echo El servicio de MySQL no está corriendo, intentando iniciar...
    net start MySQL
)

sc query MariaDB > nul
if %errorlevel% neq 0 (
    echo El servicio de MariaDB no está corriendo, intentando iniciar...
    net start MariaDB
)

REM Finalización
echo -----------------------------------------
echo El script ha terminado. Los procesos han sido terminados y los servicios intentaron ser iniciados.
pause
