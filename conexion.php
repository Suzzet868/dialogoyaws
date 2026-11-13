<?php
$host = getenv('DDP_DB_HOST') ?: '127.0.0.1';
$user = getenv('DDP_DB_USER') ?: 'root';
$password = getenv('DDP_DB_PASSWORD') ?: '';
$database = getenv('DDP_DB_NAME') ?: 'revista_digital';
$port = (int) (getenv('DDP_DB_PORT') ?: 3306);
$sslCa = getenv('DDP_DB_SSL_CA') ?: '';

mysqli_report(MYSQLI_REPORT_ERROR | MYSQLI_REPORT_STRICT);

try {
    $conexion = mysqli_init();

    if ($sslCa !== '') {
        if (!is_file($sslCa)) {
            throw new RuntimeException('The configured database CA file does not exist.');
        }

        mysqli_ssl_set($conexion, null, null, $sslCa, null, null);
    }

    mysqli_real_connect(
        $conexion,
        $host,
        $user,
        $password,
        $database,
        $port,
        null,
        $sslCa !== '' ? MYSQLI_CLIENT_SSL : 0
    );
    mysqli_set_charset($conexion, 'utf8mb4');
} catch (Throwable $exception) {
    error_log('Database connection failed: ' . $exception->getMessage());
    http_response_code(503);
    die('No se pudo conectar a la base de datos. Revisa la configuración y disponibilidad del servicio.');
}
