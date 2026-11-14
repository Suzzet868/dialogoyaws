#!/bin/bash
set -e

# --- CONFIGURACIÓN (Edita estos valores si es necesario) ---
DB_NAME="mi_base_datos"
DB_USER="usuario_php"
DB_PASS="ContrasenaSegura123!"
SQL_FILE="database.sql" # Ruta relativa a tu archivo .sql en el repo
# ----------------------------------------------------------

echo "1. Actualizando sistema e instalando Apache, PHP y MariaDB..."
sudo apt update -y
sudo apt install -y apache2 php libapache2-mod-php php-mysql php-curl php-mbstring php-xml php-zip mariadb-server unzip

echo "2. Iniciando servicios..."
sudo systemctl enable --now apache2
sudo systemctl enable --now mariadb

echo "3. Creando base de datos y usuario en MySQL/MariaDB..."
sudo mysql -e "CREATE DATABASE IF NOT EXISTS \`${DB_NAME}\` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
sudo mysql -e "CREATE USER IF NOT EXISTS '${DB_USER}'@'localhost' IDENTIFIED BY '${DB_PASS}';"
sudo mysql -e "GRANT ALL PRIVILEGES ON \`${DB_NAME}\`.* TO '${DB_USER}'@'localhost';"
sudo mysql -e "FLUSH PRIVILEGES;"

if [ -f "$SQL_FILE" ]; then
  echo "4. Importando estructura y datos desde $SQL_FILE..."
  sudo mysql "${DB_NAME}" < "$SQL_FILE"
else
  echo "AVISO: No se encontró $SQL_FILE, se omitió la importación."
fi

echo "5. Copiando archivos del proyecto a /var/www/html..."
sudo rm -rf /var/www/html/*
sudo cp -r ./* /var/www/html/
sudo rm -f /var/www/html/install.sh /var/www/html/*.sql

echo "6. Configurando permisos de Apache..."
sudo chown -R www-data:www-data /var/www/html
sudo chmod -R 755 /var/www/html
sudo systemctl restart apache2

echo "¡Instalación completada! Tu web ya debería cargar en la IP pública de EC2."
