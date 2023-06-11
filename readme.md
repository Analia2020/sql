Este proyecto demuestra cómo realizar el escrapeo de tablas desde Wikipedia, el preprocesamiento de los DataFrames y la creación de tablas en una base de datos PostgreSQL utilizando Python.
Se obtienen dos tablas finales que contienen: 
1. Tabla paises: country_name, official_state_name, sovereignty, alpha-2_code, alpha-3_code, numeric_code, subdivision_code_links, internet_cctld. PK: alpha-3_code  
2. Tabla america: country_name, total_area_(km2), population, pop._density_(per_km2), common_languages, capital, alpha-3_code. PK: alpha-3_code


## Instalación

Para utilizar este proyecto, sigue los siguientes pasos:

1. Clonar el repositorio: `git clone <URL-del-repositorio>`
2. Instalar las dependencias requeridas: `pip install -r requirements.txt`

## Uso

Al ejecutar el script en Jupyter Notebook, se escrapean las tablas desde Wikipedia y guardar los datos en un DataFrame. Posteriormente se realiza el preprocesamiento del DataFrame y realizar cualquier limpieza o transformación necesaria en los datos.
Configura los detalles de conexión de tu base de datos PostgreSQL y crear las tablas necesarias.

## Conexión con pgAdmin

Para conectarse a una base de datos PostgreSQL utilizando pgAdmin:

1. Iniciar pgAdmin y crear una nueva conexión de servidor.
2. Ingresar los detalles del servidor, incluyendo el host, puerto, nombre de la base de datos, nombre de usuario y contraseña.
3. Probar la conexión.