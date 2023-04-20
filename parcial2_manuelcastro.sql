-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 20-04-2023 a las 08:53:54
-- Versión del servidor: 10.4.25-MariaDB
-- Versión de PHP: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `parcial2_manuelcastro`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `coordinador`
--

CREATE TABLE `coordinador` (
  `pre_proyecto` varchar(200) NOT NULL,
  `coordinacion_usuarios` varchar(200) NOT NULL,
  `agregar_director` varchar(200) DEFAULT NULL,
  `estudiante` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `coordinador`
--

INSERT INTO `coordinador` (`pre_proyecto`, `coordinacion_usuarios`, `agregar_director`, `estudiante`) VALUES
('encriptacion movil', 'coordinador', NULL, '1234567890');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `director`
--

CREATE TABLE `director` (
  `director_usuario` varchar(200) NOT NULL,
  `estado` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estado`
--

CREATE TABLE `estado` (
  `estado_alumno` varchar(200) NOT NULL,
  `estado_director` varchar(200) NOT NULL,
  `estado_evaluador` varchar(200) NOT NULL,
  `aprobado` varchar(200) NOT NULL,
  `estudiante` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estudiante`
--

CREATE TABLE `estudiante` (
  `pre_proyecto` varchar(200) NOT NULL,
  `proyecto` varchar(200) NOT NULL,
  `estudiante_usuario` varchar(200) NOT NULL,
  `calificacion` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `estudiante`
--

INSERT INTO `estudiante` (`pre_proyecto`, `proyecto`, `estudiante_usuario`, `calificacion`) VALUES
('encriptacion movil', 'encriptacion movil funcional', '1234567890', '');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `evaluador`
--

CREATE TABLE `evaluador` (
  `evaluador_usuario` varchar(200) NOT NULL,
  `estado` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `cedula` varchar(200) NOT NULL,
  `nombre` varchar(200) NOT NULL,
  `apellido` varchar(200) NOT NULL,
  `cargo` varchar(200) NOT NULL,
  `password` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`cedula`, `nombre`, `apellido`, `cargo`, `password`) VALUES
('1005259101', 'manuel ricardo', 'castro malaver', 'administrador', '123'),
('1111222233', 'abigail', 'asds', 'coordinador', '123'),
('22233344', 'rafael', 'sanchez', 'director', '123'),
('1234567890', 'diego ', 'rodirguez', 'estudiante', '123'),
('3333444455', 'michell ', 'sierra', 'evaluador', '123');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `coordinador`
--
ALTER TABLE `coordinador`
  ADD PRIMARY KEY (`coordinacion_usuarios`),
  ADD UNIQUE KEY `pre_proyecto` (`pre_proyecto`),
  ADD UNIQUE KEY `estudiante` (`estudiante`),
  ADD KEY `coordinador_director` (`agregar_director`);

--
-- Indices de la tabla `director`
--
ALTER TABLE `director`
  ADD UNIQUE KEY `director_usuario` (`director_usuario`),
  ADD KEY `foraneadirectorestado` (`estado`);

--
-- Indices de la tabla `estado`
--
ALTER TABLE `estado`
  ADD UNIQUE KEY `estado_alumno` (`estado_alumno`,`estado_director`,`estado_evaluador`),
  ADD KEY `foraneaestudiante` (`estudiante`);

--
-- Indices de la tabla `estudiante`
--
ALTER TABLE `estudiante`
  ADD PRIMARY KEY (`proyecto`),
  ADD UNIQUE KEY `estudiante_usuario` (`estudiante_usuario`),
  ADD UNIQUE KEY `pre_proyecto` (`pre_proyecto`),
  ADD UNIQUE KEY `estudiante_usuario_2` (`estudiante_usuario`);

--
-- Indices de la tabla `evaluador`
--
ALTER TABLE `evaluador`
  ADD KEY `foraneaevaluador` (`evaluador_usuario`),
  ADD KEY `estado_evaluador` (`estado`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`cargo`),
  ADD UNIQUE KEY `cedula` (`cedula`);

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `coordinador`
--
ALTER TABLE `coordinador`
  ADD CONSTRAINT `coordinador_director` FOREIGN KEY (`agregar_director`) REFERENCES `director` (`director_usuario`),
  ADD CONSTRAINT `estudiante` FOREIGN KEY (`estudiante`) REFERENCES `usuarios` (`cedula`),
  ADD CONSTRAINT `foraneacordinador` FOREIGN KEY (`coordinacion_usuarios`) REFERENCES `usuarios` (`cargo`);

--
-- Filtros para la tabla `director`
--
ALTER TABLE `director`
  ADD CONSTRAINT `foraneadirector` FOREIGN KEY (`director_usuario`) REFERENCES `usuarios` (`cargo`),
  ADD CONSTRAINT `foraneadirectorestado` FOREIGN KEY (`estado`) REFERENCES `estado` (`estado_alumno`);

--
-- Filtros para la tabla `estado`
--
ALTER TABLE `estado`
  ADD CONSTRAINT `foraneaestudiante` FOREIGN KEY (`estudiante`) REFERENCES `estudiante` (`proyecto`);

--
-- Filtros para la tabla `estudiante`
--
ALTER TABLE `estudiante`
  ADD CONSTRAINT `estu` FOREIGN KEY (`estudiante_usuario`) REFERENCES `usuarios` (`cedula`),
  ADD CONSTRAINT `pre` FOREIGN KEY (`pre_proyecto`) REFERENCES `coordinador` (`pre_proyecto`);

--
-- Filtros para la tabla `evaluador`
--
ALTER TABLE `evaluador`
  ADD CONSTRAINT `estado_evaluador` FOREIGN KEY (`estado`) REFERENCES `estado` (`estado_alumno`),
  ADD CONSTRAINT `foraneaevaluador` FOREIGN KEY (`evaluador_usuario`) REFERENCES `usuarios` (`cargo`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
