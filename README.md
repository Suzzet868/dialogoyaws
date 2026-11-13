# DDP Noticias

Sitio PHP y administrador con MySQL/MariaDB. El mismo contenedor Docker se puede ejecutar en AWS y Azure.

## Requisitos

- PHP 8.2 con `mysqli`, o Docker.
- MySQL compatible con la estructura actual de la base `revista_digital`.
- Las variables `DDP_DB_HOST`, `DDP_DB_PORT`, `DDP_DB_NAME`, `DDP_DB_USER` y `DDP_DB_PASSWORD`.
- Para una base que exija TLS, proporciona su certificado CA en `DDP_DB_SSL_CA`.

No guardes contraseñas, archivos `.env`, copias de la base ni credenciales de nube en GitHub. Configura los secretos en el servicio de cada nube.

## Probar el contenedor localmente

1. Copia `.env.example` a `.env` y configura la conexión local a MySQL.
2. Construye y ejecuta el contenedor:

   ```sh
   docker build -t ddp-noticias .
   docker run --rm --env-file .env -p 8080:80 ddp-noticias
   ```

3. Abre `http://localhost:8080`.

## Despliegue en nube

Usa una base MySQL administrada distinta por entorno y configura sus credenciales en las variables de entorno de la aplicación:

- **Azure:** Azure Database for MySQL Flexible Server y App Service para contenedores.
- **AWS:** Amazon RDS for MySQL y AWS App Runner (o ECS Fargate).

Publica la imagen en Azure Container Registry o Amazon ECR y configura el servicio para escuchar en el puerto `80`. Limita el acceso a la base de datos a la aplicación y habilita TLS. Mantén las contraseñas en Azure Key Vault o AWS Secrets Manager; no en el repositorio ni en la imagen.

GitHub almacena el código, pero no aloja por sí mismo la aplicación PHP o MySQL. Para despliegues automáticos, configura GitHub Actions con OIDC y permisos mínimos para cada nube.

## Base de datos y contenido

El repositorio no incluye una exportación completa de la base. Antes del primer despliegue, migra la estructura y los registros necesarios desde el MySQL actual a la base administrada de cada entorno. Exporta e importa la base de forma segura; no subas copias con datos reales ni contraseñas a GitHub.

Si ejecutas AWS y Azure simultáneamente, sus bases no se sincronizan automáticamente. Elige una como producción principal o configura y prueba una estrategia de replicación antes de aceptar cambios en ambas.
