# KILLRIO
# 🛠️ Script de Gestión de Puertos para MariaDB/MySQL

## 📋 Descripción

Este script Batch para **Windows** automatiza la gestión de conflictos de puertos usados por los servicios **MariaDB** o **MySQL**. Verifica los puertos predeterminados (`3306` y `3307`), finaliza procesos en conflicto, ajusta la configuración para usar el puerto `3308` si es necesario, asegura que los servicios estén activos y genera un informe detallado (`mariadb_mysql_report.txt`).

---

## 🚀 Funcionalidades

### 🔍 Detección y resolución de conflictos de puertos
- Verifica si los puertos `3306` y `3307` están ocupados.
- Finaliza procesos que los estén utilizando para liberarlos.

### ⚙️ Ajuste de configuración
- Localiza el archivo `my.ini` en `C:\Program Files\MariaDB 10.3\my.ini`.
- Cambia el puerto de MariaDB a `3308` si el `3306` está ocupado.

### 🛠️ Gestión de servicios
- Comprueba el estado de los servicios `MariaDB` y `MySQL`.
- Inicia los servicios si no están activos.

### 🔄 Re-verificación final
- Revisa que el puerto `3306` esté libre después de los cambios.
- Elimina cualquier proceso restante en conflicto.

### 📝 Registro de actividades
- Genera un archivo `mariadb_mysql_report.txt` con:
  - Verificación de puertos
  - Finalización de procesos
  - Cambios de configuración
  - Estado de los servicios

---

## 📌 Requisitos

- **Sistema operativo:** Windows  
- **Software:** MariaDB o MySQL instalado  
- **Permisos:** Ejecutar el script como administrador  
- **Archivo de configuración:** `my.ini` debe estar en:
(o edita el script si la ruta es diferente)

---

## 🛠️ Uso

1. Guarda el contenido como un archivo `.bat`, por ejemplo:

2. Ejecuta como administrador:
- Clic derecho → _Ejecutar como administrador_

3. El script:
- Detecta y resuelve conflictos de puertos
- Ajusta la configuración si es necesario
- Verifica y arranca servicios
- Crea un informe detallado en `mariadb_mysql_report.txt`

4. Consulta el archivo `mariadb_mysql_report.txt` para ver el resultado de las acciones realizadas.

---

## 📄 Salida Esperada

El archivo `mariadb_mysql_report.txt` incluirá:

- Estado de los puertos (`3306`, `3307`)
- Procesos terminados
- Cambios aplicados al archivo `my.ini`
- Estado final de los servicios
- Resultados de las verificaciones finales

### 📊 Ejemplo de Registro


---

## ⚠️ Notas

- **Advertencia:** El script **forzará la finalización** de procesos que usen los puertos `3306` o `3307`. Verifica que no haya aplicaciones críticas antes de ejecutarlo.
- Si `my.ini` está en otra ruta, edita la variable `MYSQL_CONFIG_FILE` en el script.
- Verifica que los nombres de servicio sean `"MariaDB"` y `"MySQL"`, o ajústalos según tu instalación.
- Se recomienda **hacer respaldo** del archivo `my.ini` antes de ejecutar el script.

---

## 📜 Licencia

Este script se proporciona "tal cual", sin garantías. Úsalo bajo tu propia responsabilidad.

---

## 🌟 Contribuciones

¡Contribuciones bienvenidas! Puedes:

- Reportar errores o sugerencias creando un [issue](https://github.com/tu_usuario/tu_repo/issues)
- Enviar mejoras mediante un pull request

