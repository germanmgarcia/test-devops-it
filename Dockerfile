# Utiliza una imagen base de Python
FROM python:3.10.12

# Establece el directorio de trabajo en el contenedor
WORKDIR /app

# Copia los archivos de requisitos y el código fuente al contenedor
COPY app/requirements.txt requirements.txt
COPY app/ .

# Instala las dependencias de Python
RUN pip install --no-cache-dir -r requirements.txt

# Expone el puerto en el que la aplicación escuchará
EXPOSE 5000

# Define el comando para ejecutar la aplicación
CMD ["python", "app.py"]
