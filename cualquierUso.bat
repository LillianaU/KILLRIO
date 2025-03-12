@echo off
setlocal enabledelayedexpansion

REM --------------------------------------
REM Verificar si MariaDB/MySQL está utilizando los puertos predeterminados (3306 y 3307)
echo Verificando puertos 3306 y 3307 para MariaDB/MySQL...

REM Verificar si el puerto 3306 está ocupado por otro proceso
for /f "tokens=5" %%a in ('netstat -ano ^| findstr ":3306"') do (
    echo El puerto 3306 está ocupado por el proceso con PID %%a. >> mariadb_mysql_report.txt
    echo Matando proceso con PID %%a en el puerto 3306... >> mariadb_mysql_report.txt
    taskkill /F /PID %%a
)

REM Verificar si el puerto 3307 está ocupado por otro proceso
for /f "tokens=5" %%a in ('netstat -ano ^| findstr ":3307"') do (
    echo El puerto 3307 está ocupado por el proceso con PID %%a. >> mariadb_mysql_report.txt
    echo Matando proceso con PID %%a en el puerto 3307... >> mariadb_mysql_report.txt
    taskkill /F /PID %%a
)

REM --------------------------------------
REM Verificar si MariaDB/MySQL está configurado para usar el puerto 3306 (o 3307) y cambiarlo si es necesario
echo Verificando la configuración de puertos en el archivo de configuración de MariaDB/MySQL... >> mariadb_mysql_report.txt

REM Configurar MariaDB/MySQL para usar el puerto 3308 en caso de conflicto
set MYSQL_CONFIG_FILE="C:\Program Files\MariaDB 10.3\my.ini"
if exist %MYSQL_CONFIG_FILE% (
    echo Modificando puerto en el archivo de configuracion de MariaDB... >> mariadb_mysql_report.txt
    echo Cambiando puerto de MariaDB/MySQL de 3306 a 3308... >> mariadb_mysql_report.txt
    echo [mysqld] >> %MYSQL_CONFIG_FILE%
    echo port=3308 >> %MYSQL_CONFIG_FILE%
    echo La configuración ha sido cambiada para usar el puerto 3308. >> mariadb_mysql_report.txt
) else (
    echo No se encontró el archivo de configuración de MariaDB/MySQL. >> mariadb_mysql_report.txt
)

REM --------------------------------------
REM Asegurarse de que los servicios de MariaDB/MySQL estén en ejecución
echo Verificando el estado de los servicios de MariaDB/MySQL... >> mariadb_mysql_report.txt
sc query "MariaDB" > nul
if %errorlevel% neq 0 (
    echo El servicio MariaDB no está en ejecución. Intentando iniciar... >> mariadb_mysql_report.txt
    net start "MariaDB"
) else (
    echo El servicio MariaDB ya está en ejecución. >> mariadb_mysql_report.txt
)

sc query "MySQL" > nul
if %errorlevel% neq 0 (
    echo El servicio MySQL no está en ejecución. Intentando iniciar... >> mariadb_mysql_report.txt
    net start "MySQL"
) else (
    echo El servicio MySQL ya está en ejecución. >> mariadb_mysql_report.txt
)

REM --------------------------------------
REM Asegurarse de que no haya conflictos con otros servicios de bases de datos
echo Verificando si otros servicios de bases de datos están utilizando el puerto 3306... >> mariadb_mysql_report.txt

for /f "tokens=5" %%a in ('netstat -ano ^| findstr ":3306"') do (
    echo El puerto 3306 sigue ocupado por el proceso con PID %%a. >> mariadb_mysql_report.txt
    echo Matando el proceso en conflicto... >> mariadb_mysql_report.txt
    taskkill /F /PID %%a
)

REM --------------------------------------
echo El script ha terminado. La información ha sido guardada en mariadb_mysql_report.txt.
pause
