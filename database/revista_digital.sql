-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 13-11-2026 a las 20:41:20
-- Versión del servidor: 10.11.16-MariaDB
-- Versión de PHP: 8.4.27

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `revista_digital`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `autores`
--

CREATE TABLE `autores` (
  `id` int(10) UNSIGNED NOT NULL,
  `nombres` varchar(120) NOT NULL,
  `ap_paterno` varchar(60) DEFAULT '',
  `ap_materno` varchar(60) DEFAULT '',
  `nickname` varchar(100) DEFAULT '',
  `es_nickname` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `autores`
--

INSERT INTO `autores` (`id`, `nombres`, `ap_paterno`, `ap_materno`, `nickname`, `es_nickname`) VALUES
(1, 'Carlos', 'Mendoza', 'Ríos', 'Carlos Mendoza', 0),
(2, 'María', 'Torres', 'Vargas', 'María Torres', 0),
(3, 'Juan', 'Paredes', 'Soto', '', 0),
(4, 'Ana', 'Quispe', 'Mamani', 'Ana Q.', 1),
(5, 'Redacción', 'DDP', '', 'Redacción DDP', 1),
(6, 'Redacción', '', NULL, NULL, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `boletines`
--

CREATE TABLE `boletines` (
  `id` int(10) UNSIGNED NOT NULL,
  `numero_boletin` varchar(50) NOT NULL,
  `resumen` text DEFAULT NULL,
  `foto_portada` varchar(255) DEFAULT '',
  `archivo_pdf` varchar(255) DEFAULT '',
  `fecha_publicacion` date DEFAULT NULL,
  `usuario_id` int(10) UNSIGNED DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `boletines`
--

INSERT INTO `boletines` (`id`, `numero_boletin`, `resumen`, `foto_portada`, `archivo_pdf`, `fecha_publicacion`, `usuario_id`, `created_at`) VALUES
(1, 'NTEP-2026-09', 'Edición septiembre 2026 del boletín de noticias sociales y territoriales. Incluye análisis sobre minería artesanal, educación intercultural y desarrollo sostenible en las regiones del sur del país.', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQvM9qZXkMfe8QNDb8iqR0T757oQlIISm8Z8gx_pUcwWLINBNErkQIqKuA&s=10', 'https://www.dialogoydesarrollo.com.pe/boletines/boletin-NTEP-edicion-N45-2808.pdf', '2026-11-13', NULL, '2026-11-12 12:40:33'),
(2, 'NTEP-2026-08', 'Edición agosto 2026 con reportajes sobre comercio justo en los Andes, mujeres emprendedoras y turismo comunitario.', 'https://www.dialogoydesarrollo.com.pe/assets/images/boletin-ntep-45.png', 'https://www.dialogoydesarrollo.com.pe/boletines/boletin-NTEP-edicion-N45-2808.pdf', '2026-08-01', NULL, '2026-11-12 12:40:33'),
(3, '46', 'todo listo', 'https://imgcap.capturetheatlas.com/wp-content/uploads/2020/04/long-exposure-and-water.jpg', 'https://www.dialogoydesarrollo.com.pe/boletines/boletin-NTEP-edicion-N45-2808.pdf', '2026-11-13', 4, '2026-11-13 09:50:39');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `noticias`
--

CREATE TABLE `noticias` (
  `id` int(10) UNSIGNED NOT NULL,
  `titulo` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `foto` varchar(255) DEFAULT '',
  `link_externo` varchar(500) DEFAULT '',
  `fecha_publicacion` date DEFAULT NULL,
  `usuario_id` int(10) UNSIGNED DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `noticias`
--

INSERT INTO `noticias` (`id`, `titulo`, `slug`, `foto`, `link_externo`, `fecha_publicacion`, `usuario_id`, `created_at`) VALUES
(1, 'Cusco: Catedral, iglesias y parroquias tocarán sus campanas por la llegada del papa León XIV al Perú', 'congreso-ley-fortalecimiento-agro', 'https://f.rpp-noticias.io/2026/11/11/365136_1928100.jpg?width=1020&quality=80', 'https://rpp.pe/peru/cusco/papa-leon-xiv-catedral-iglesias-y-parroquias-tocaran-sus-campanas-por-la-llegada-del-pontifice-al-peru-noticia-1717307', '2026-11-13', NULL, '2026-11-12 12:40:33'),
(5, 'Así le hemos contado el segundo día de la visita de León XIV a Perú', 'exportaciones-agroindustria-record-historico', 'https://cloudfront-eu-central-1.images.arcpublishing.com/prisa/5GTPOE2TL5LUVAZ6BHSSQWFOVY.jpg', 'https://elpais.com/america/2026-11-12/la-visita-de-leon-xiv-a-peru-en-vivo-el-papa-se-reun-con-los-obispos.html', '2026-11-13', NULL, '2026-11-12 12:40:33');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `podcasts`
--

CREATE TABLE `podcasts` (
  `id` int(10) UNSIGNED NOT NULL,
  `titulo` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `tipo` enum('embed','archivo') DEFAULT 'embed',
  `url_embed` varchar(500) DEFAULT NULL,
  `archivo_audio` varchar(255) DEFAULT NULL,
  `portada` varchar(255) DEFAULT '',
  `duracion_segundos` int(10) UNSIGNED DEFAULT NULL,
  `tamano_bytes` int(10) UNSIGNED DEFAULT NULL,
  `fecha_publicacion` date DEFAULT NULL,
  `estado` enum('borrador','publicado') DEFAULT 'borrador',
  `usuario_id` int(10) UNSIGNED DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `podcasts`
--

INSERT INTO `podcasts` (`id`, `titulo`, `slug`, `tipo`, `url_embed`, `archivo_audio`, `portada`, `duracion_segundos`, `tamano_bytes`, `fecha_publicacion`, `estado`, `usuario_id`, `created_at`) VALUES
(1, '¿hablar o no hablar nuestras cosas?', 'mineria-artesanal-voces-rio', 'embed', 'https://www.youtube.com/watch?v=uKRK8_-B000', NULL, 'assets/img/podcast.png', 2340, NULL, '2026-09-05', 'publicado', NULL, '2026-11-12 12:40:33'),
(2, '4 Principios para Enfocarte', 'educacion-bilingue-preservar-modernizar', 'embed', 'https://www.youtube.com/watch?v=2uh--LUMVuU', NULL, 'assets/img/podcast.png', 1860, NULL, '2026-08-28', 'publicado', NULL, '2026-11-12 12:40:33'),
(4, 'EL AUTOCONCEPTO : lo que piensas de ti mismo cambia todo', 'comercio-justo-voces-andes', 'embed', 'https://www.youtube.com/watch?v=dSGUKvEmSPA', NULL, 'assets/img/podcast.png', 1980, NULL, '2026-09-01', 'publicado', NULL, '2026-11-12 12:40:33'),
(5, 'Nueva canción de estreno', '', 'embed', 'https://music.youtube.com/watch?v=dQlihE2-HLM&list=OLAK5uy_kIzfMHa8DxDMpHV83VJbG3-NJvFwqPuiU', NULL, '', NULL, NULL, '2026-11-12', 'borrador', 4, '2026-11-12 16:27:37');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reportajes`
--

CREATE TABLE `reportajes` (
  `id` int(10) UNSIGNED NOT NULL,
  `titulo` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `resumen_corto` varchar(500) DEFAULT '',
  `desarrollo` longtext DEFAULT NULL,
  `foto_principal` varchar(255) DEFAULT '',
  `alt_foto_principal` varchar(255) DEFAULT '',
  `pdf_adjunto` varchar(255) DEFAULT '',
  `fecha_publicacion` date DEFAULT NULL,
  `estado` enum('borrador','publicado','archivado') DEFAULT 'borrador',
  `es_destacado` tinyint(1) DEFAULT 0,
  `meta_titulo` varchar(255) DEFAULT '',
  `meta_descripcion` varchar(320) DEFAULT '',
  `autor_id` int(10) UNSIGNED DEFAULT NULL,
  `usuario_id` int(10) UNSIGNED DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `reportajes`
--

INSERT INTO `reportajes` (`id`, `titulo`, `slug`, `resumen_corto`, `desarrollo`, `foto_principal`, `alt_foto_principal`, `pdf_adjunto`, `fecha_publicacion`, `estado`, `es_destacado`, `meta_titulo`, `meta_descripcion`, `autor_id`, `usuario_id`, `created_at`, `updated_at`) VALUES
(7, 'El turismo comunitario como herramienta de desarrollo sostenible', 'turismo-comunitario-desarrollo-sostenible', 'Entérate cómo participar en el Primer Encuentro Internacional de Turismo Comunitario y Sostenible, del 24 al 25 de agosto del 2023.', 'La Universidad del Magdalena, el Programa Juntanza Étnica de USAID-ACDI/VOCA, WWF Colombia y el Proyecto de Paisajes sostenibles – Herencia Colombia presentan el ‘Primer Encuentro Internacional de Turismo Comunitario y Sostenible. Hacia una participación equitativa de las comunidades’.\r\n\r\nEl turismo es una herramienta poderosa para el desarrollo económico que genera bienestar en las comunidades locales, siempre y cuando se lleve a cabo de manera sostenible y equitativa. Sin embargo, en varios destinos turísticos del país aún hay comunidades locales que son excluidas del proceso de toma de decisiones y distribución de los beneficios económicos procedentes la naturaleza.\r\n\r\nCon el fin de fomentar un turismo sostenible, regenerativo, justo y participativo, hemos unido nuestros esfuerzos para llevar a cabo el Primer Encuentro Internacional de Turismo Comunitario y Sostenible, bajo el lema \'Hacia una participación equitativa de las comunidades\'. Con este encuentro buscamos identificar los principales desafíos y compartir lecciones aprendidas que promuevan alianzas y estrategias encaminadas a fortalecer los procesos comunitarios que subyacen al turismo en las zonas rurales, cascos urbanos y ecosistemas estratégicos en Colombia.', 'https://wwflac.awsassets.panda.org/img/turismo_comunitarios_encuentro2_780942.jpg', 'Visitantes en una comunidad campesina de Ancash durante una caminata cultural', '', '2026-09-10', 'publicado', 0, 'El turismo comunitario como desarrollo sostenible | DDP Noticias', 'Cómo el turismo comunitario se convierte en herramienta de desarrollo sostenible en las comunidades campesinas del Perú.', 2, NULL, '2026-11-12 12:40:33', '2026-11-13 10:13:52'),
(11, 'Papa León XIV en Perú', 'reportaje-economia-circular-borrador', 'Medios de Argentina, España, Francia, Alemania y Estados Unidos destacaron los vínculos del pontífice con el Perú, donde desarrolló gran parte de su labor pastoral.', 'Uno de los medios que informó sobre su arribo fue Vatican News, que resaltó la relación del sumo pontífice con el Perú y su trayectoria religiosa en territorio nacional. \"El Papa Prevost llegó a Perú, su segunda patria\", tituló el medio oficial del Vaticano.\r\n\r\nEn su publicación, recordó que el entonces misionero agustino y pastor, Robert Francis Prevost, llegó a la nación peruana como un \"orgulloso hijo adoptivo\", y destacó que esta visita representa la tercera etapa de su viaje apostólico por América Latina.\r\n\r\nPor su parte, la Agencia de Noticias Argentinas también informó sobre la llegada del pontífice con el titular: \"El papa León XIV arribó a Perú, última etapa de su gira sudamericana\". El medio destacó que el religioso permanecerá en el país hasta el lunes 16 de noviembre y cumplirá actividades en Lima, Callao, Chiclayo, Santa Cruz de Succhabamba, Cusco y Pucallpa.', 'https://peru21.pe/sites/default/efsfiles/styles/wide/public/2026-11/papa-leon-medios-internacionales.png?itok=SAJwczsZ', 'Economía circular industrial', '', '2026-09-15', 'borrador', 0, 'Economía circular en el Perú | DDP Noticias', 'Iniciativas de economía circular en el sector industrial peruano.', 3, NULL, '2026-11-12 12:40:33', '2026-11-13 10:14:34'),
(14, '¡Hasta 12 horas sin agua!', 'hasta-12-horas-sin-agua', 'Sedapal anunció la suspensión temporal del servicio de agua potable en sectores de Carabayllo y Villa María del Triunfo. Conoce las zonas afectadas y los horarios del viernes 13 de noviembre.', '¡Atención, vecinos de Lima! El Servicio de Agua Potable y Alcantarillado de Lima (Sedapal) anunció una nueva jornada de cortes de agua para este viernes 13 de noviembre de 2026, que dejará sin suministro hasta por 12 horas a numerosas viviendas de la capital. La medida afectará a sectores específicos de dos distritos, por lo que se recomienda tomar precauciones para evitar inconvenientes.\r\n\r\nDe acuerdo con la programación preliminar difundida por la empresa, la interrupción responde a trabajos de mantenimiento y mejora de las redes de distribución, entre ellos la limpieza de reservorios.\r\n\r\nSin embargo, es importante precisar que la suspensión no afectará a todos los vecinos de los distritos mencionados, sino únicamente a las urbanizaciones, asociaciones y asentamientos humanos incluidos en el cronograma.', 'https://imgmedia.larepublica.pe/850x501/larepublica/original/2026/11/13/6af686e596c1e97c3500e5dc.webp', '', '', '2026-11-13', 'borrador', 0, '', '', 6, 4, '2026-11-13 10:17:17', '2026-11-13 10:17:17');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reportajes_fotos`
--

CREATE TABLE `reportajes_fotos` (
  `id` int(10) UNSIGNED NOT NULL,
  `reportaje_id` int(10) UNSIGNED NOT NULL,
  `url_foto` varchar(255) DEFAULT '',
  `url_foto_thumb` varchar(255) DEFAULT '',
  `url_foto_webp` varchar(255) DEFAULT '',
  `orden` smallint(6) DEFAULT 0,
  `descripcion` varchar(255) DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(10) UNSIGNED NOT NULL,
  `nombres` varchar(100) NOT NULL,
  `ap_paterno` varchar(60) NOT NULL,
  `ap_materno` varchar(60) DEFAULT '',
  `email` varchar(150) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `rol` enum('admin','editor','redactor') DEFAULT 'redactor',
  `activo` tinyint(1) DEFAULT 1,
  `intentos_fallidos` int(10) UNSIGNED DEFAULT 0,
  `bloqueado_hasta` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `nombres`, `ap_paterno`, `ap_materno`, `email`, `password_hash`, `rol`, `activo`, `intentos_fallidos`, `bloqueado_hasta`, `created_at`) VALUES
(4, 'Shar', 'Huillca', 'Riquelme', 'shar@gmail.com', '$2y$12$FXA1KQxxYb1LAWIq8XUtE.xfMXUmY8IST28/7GaSzluJRGZER68Eq', 'admin', 1, 5, '2026-11-12 19:01:23', '2026-11-12 12:45:19');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `videos`
--

CREATE TABLE `videos` (
  `id` int(10) UNSIGNED NOT NULL,
  `titulo` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `tipo` enum('embed','archivo') DEFAULT 'embed',
  `url_embed` varchar(500) DEFAULT NULL,
  `archivo_video` varchar(255) DEFAULT NULL,
  `poster` varchar(255) DEFAULT NULL,
  `duracion_segundos` int(10) UNSIGNED DEFAULT NULL,
  `tamano_bytes` int(10) UNSIGNED DEFAULT NULL,
  `fecha_publicacion` date DEFAULT NULL,
  `estado` enum('borrador','publicado') DEFAULT 'borrador',
  `usuario_id` int(10) UNSIGNED DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `videos`
--

INSERT INTO `videos` (`id`, `titulo`, `slug`, `tipo`, `url_embed`, `archivo_video`, `poster`, `duracion_segundos`, `tamano_bytes`, `fecha_publicacion`, `estado`, `usuario_id`, `created_at`) VALUES
(1, 'Documental: Minería en Madre de Dios', 'documental-mineria-madre-de-dios', 'embed', 'https://www.youtube.com/embed/dQw4w9WgXcQ', NULL, 'assets/img/podcast.png', 1800, NULL, '2026-09-05', 'publicado', NULL, '2026-11-12 12:40:33'),
(2, 'Entrevista: Educación intercultural bilingüe', 'entrevista-educacion-eib', 'embed', 'https://www.youtube.com/watch?v=SrsshQ5Jegs', NULL, 'assets/img/podcast.png', 1200, NULL, '2026-08-28', 'publicado', NULL, '2026-11-12 12:40:33'),
(3, 'Video informativo: Agua para todos', 'video-informativo-agua-todos', 'embed', 'https://www.youtube.com/watch?v=TNghY-PEDTE', NULL, 'assets/img/podcast.png', 900, NULL, '2026-09-01', 'publicado', NULL, '2026-11-12 12:40:33'),
(4, 'T1', '', 'embed', 'https://www.youtube.com/watch?v=zgYeYNGenDA', NULL, NULL, NULL, NULL, '2026-11-13', 'borrador', 4, '2026-11-13 08:16:15');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `autores`
--
ALTER TABLE `autores`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `boletines`
--
ALTER TABLE `boletines`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_boletin_numero` (`numero_boletin`),
  ADD KEY `idx_boletin_fecha` (`fecha_publicacion`),
  ADD KEY `fk_boletin_usuario` (`usuario_id`);

--
-- Indices de la tabla `noticias`
--
ALTER TABLE `noticias`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_noticia_slug` (`slug`),
  ADD KEY `idx_noticia_fecha` (`fecha_publicacion`),
  ADD KEY `fk_noticia_usuario` (`usuario_id`);

--
-- Indices de la tabla `podcasts`
--
ALTER TABLE `podcasts`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_podcast_slug` (`slug`),
  ADD KEY `idx_podcast_estado` (`estado`),
  ADD KEY `idx_podcast_fecha` (`fecha_publicacion`),
  ADD KEY `fk_podcast_usuario` (`usuario_id`);

--
-- Indices de la tabla `reportajes`
--
ALTER TABLE `reportajes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_reportaje_slug` (`slug`),
  ADD KEY `idx_reportaje_fecha` (`fecha_publicacion`),
  ADD KEY `idx_reportaje_estado` (`estado`),
  ADD KEY `idx_reportaje_destacado` (`es_destacado`),
  ADD KEY `idx_reportaje_autor` (`autor_id`),
  ADD KEY `idx_reportaje_usuario` (`usuario_id`);

--
-- Indices de la tabla `reportajes_fotos`
--
ALTER TABLE `reportajes_fotos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_rf_reportaje` (`reportaje_id`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_usuario_email` (`email`);

--
-- Indices de la tabla `videos`
--
ALTER TABLE `videos`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_video_slug` (`slug`),
  ADD KEY `idx_video_estado` (`estado`),
  ADD KEY `idx_video_fecha` (`fecha_publicacion`),
  ADD KEY `fk_video_usuario` (`usuario_id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `autores`
--
ALTER TABLE `autores`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `boletines`
--
ALTER TABLE `boletines`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `noticias`
--
ALTER TABLE `noticias`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `podcasts`
--
ALTER TABLE `podcasts`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `reportajes`
--
ALTER TABLE `reportajes`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT de la tabla `reportajes_fotos`
--
ALTER TABLE `reportajes_fotos`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `videos`
--
ALTER TABLE `videos`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `boletines`
--
ALTER TABLE `boletines`
  ADD CONSTRAINT `fk_boletin_usuario` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE SET NULL;

--
-- Filtros para la tabla `noticias`
--
ALTER TABLE `noticias`
  ADD CONSTRAINT `fk_noticia_usuario` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE SET NULL;

--
-- Filtros para la tabla `podcasts`
--
ALTER TABLE `podcasts`
  ADD CONSTRAINT `fk_podcast_usuario` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE SET NULL;

--
-- Filtros para la tabla `reportajes`
--
ALTER TABLE `reportajes`
  ADD CONSTRAINT `fk_reportaje_autor` FOREIGN KEY (`autor_id`) REFERENCES `autores` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_reportaje_usuario` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE SET NULL;

--
-- Filtros para la tabla `reportajes_fotos`
--
ALTER TABLE `reportajes_fotos`
  ADD CONSTRAINT `fk_rf_reportaje` FOREIGN KEY (`reportaje_id`) REFERENCES `reportajes` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `videos`
--
ALTER TABLE `videos`
  ADD CONSTRAINT `fk_video_usuario` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
