# Usar una imagen base más ligera con Apache
FROM ubuntu:22.04

# Configurar variables de entorno para evitar prompts
ENV DEBIAN_FRONTEND=noninteractive

# Instalar dependencias necesarias
RUN apt-get update && apt-get install -y \
    apache2 \
    git \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Limpiar el directorio html primero
RUN rm -rf /var/www/html/*

# Clonar el repositorio de GitHub
RUN git clone https://github.com/KuromisEnjoyer/Solemne1.git /var/www/html

# Configurar Apache
RUN chown -R www-data:www-data /var/www/html \
    && a2enmod rewrite

# Exponer el puerto 80 (puerto estándar para HTTP)
EXPOSE 80

# Comando para iniciar Apache
CMD ["apache2ctl", "-D", "FOREGROUND"]
