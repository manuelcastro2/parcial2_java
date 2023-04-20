-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 20-04-2023 a las 20:13:58
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
-- Estructura de tabla para la tabla `general`
--

CREATE TABLE `general` (
  `pre_proyecto` varchar(200) NOT NULL,
  `proyecto` varchar(200) DEFAULT NULL,
  `estudiante` varchar(200) NOT NULL,
  `agregar_director` varchar(200) DEFAULT NULL,
  `estado_coordinador` varchar(200) DEFAULT NULL,
  `estado_director` varchar(200) DEFAULT NULL,
  `estado_alumno` varchar(200) DEFAULT NULL,
  `estado_evaluador` varchar(200) DEFAULT NULL,
  `calificacion` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `general`
--

INSERT INTO `general` (`pre_proyecto`, `proyecto`, `estudiante`, `agregar_director`, `estado_coordinador`, `estado_director`, `estado_alumno`, `estado_evaluador`, `calificacion`) VALUES
('encriptacion', '', '1234567890', '22233344', '', '', '', '', '');

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
-- Indices de la tabla `general`
--
ALTER TABLE `general`
  ADD PRIMARY KEY (`pre_proyecto`),
  ADD UNIQUE KEY `estudiante` (`estudiante`),
  ADD UNIQUE KEY `proyecto` (`proyecto`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`cargo`),
  ADD UNIQUE KEY `cedula` (`cedula`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
