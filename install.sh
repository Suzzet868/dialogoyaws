#!/bin/bash
set -e

# --- CONFIGURACIÓN (Edita estos valores según tu proyecto) ---
REPO_URL="https://github.com/tu-usuario/tu-repositorio.git"
DB_NAME="nombre_bd"
DB_USER="usuario_bd"
DB_PASS="ContrasenaSegura123!"
SQL_FILE="database.sql"
# -------------------------------------------------------------

# 1. Instalar Apache, PHP 8, MariaDB y Git (en Amazon Linux 2023 se usa dnf)
dnf update -y
dnf install -y httpd php php-mysqli php-pdo php-mbstring php-xml php-json mariadb105-server git

# 2. Iniciar servicios web y de base de datos
systemctl enable --now httpd
systemctl enable --now mariadb

# 3. Crear base de datos, usuario e importar tablas
mysql -e "CREATE DATABASE IF NOT EXISTS \`${DB_NAME}\` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
mysql -e "CREATE USER IF NOT EXISTS '${DB_USER}'@'localhost' IDENTIFIED BY '${DB_PASS}';"
mysql -e "GRANT ALL PRIVILEGES ON \`${DB_NAME}\`.* TO '${DB_USER}'@'localhost';"
mysql -e "FLUSH PRIVILEGES;"

# 4. Clonar el repositorio y copiar los archivos web
rm -rf /tmp/proyecto
git clone "$REPO_URL" /tmp/proyecto

if [ -f "/tmp/proyecto/$SQL_FILE" ]; then
  mysql "${DB_NAME}" < "/tmp/proyecto/$SQL_FILE"
fi

rm -rf /var/www/html/*
cp -r /tmp/proyecto/* /var/www/html/
rm -rf /var/www/html/.git /var/www/html/*.sql /var/www/html/*.sh

# 5. Asignar permisos a Apache y reiniciar
chown -R apache:apache /var/www/html
chmod -R 755 /var/www/html
systemctl restart httpd
