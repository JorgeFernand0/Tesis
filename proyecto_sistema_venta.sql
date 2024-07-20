-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1:3309
-- Tiempo de generación: 26-05-2024 a las 10:50:45
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.1.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `proyecto_sistema_venta`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientes`
--

CREATE TABLE `clientes` (
  `id` int(11) NOT NULL,
  `dni` varchar(8) NOT NULL,
  `nombre` varchar(180) NOT NULL,
  `telefono` varchar(15) NOT NULL,
  `direccion` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `clientes`
--

INSERT INTO `clientes` (`id`, `dni`, `nombre`, `telefono`, `direccion`) VALUES
(3, '3456', 'Elena Navarro Soto', '312 012 3456', 'Avenida Real Bugambilias #707, Colonia La Comarca, Villa de Álvarez, Colima.'),
(4, '2345', 'Roberto Flores Ramírez', '312 901 2345', 'Calle Manuel Álvarez #606, Colonia Villas del Bosque, Villa de Álvarez'),
(5, '1234', 'Lucía Torres Vargas', '312 890 1234', 'Avenida Benito Juárez #505, Colonia Real Bugambilias, Villa de Álvarez'),
(6, '9012', 'Laura Gómez Morales', '314 678 9012', 'Avenida Elías Zamora Verduzco #303, Colonia Santiago, Manzanillo'),
(7, '7890', 'Ana Martínez Fernández', '312 456 7890', 'Avenida Tecnológico #101, Colonia Villas San Sebastián, Colima'),
(18, '1212', 'fofo', '3121829182', 'coquimatlan'),
(22, '1111', 'ana', '3124491831', 'villa');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `config`
--

CREATE TABLE `config` (
  `id` int(11) NOT NULL,
  `rfc` int(15) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `telefono` int(11) NOT NULL,
  `direccion` text NOT NULL,
  `mensaje` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `config`
--

INSERT INTO `config` (`id`, `rfc`, `nombre`, `telefono`, `direccion`, `mensaje`) VALUES
(1, 71347267, 'Hogar y Tecnología', 925491523, 'Colima, Col', 'Gracias por su compra');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle`
--

CREATE TABLE `detalle` (
  `id` int(11) NOT NULL,
  `id_pro` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `precio` decimal(10,2) NOT NULL,
  `id_venta` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `detalle`
--

INSERT INTO `detalle` (`id`, `id_pro`, `cantidad`, `precio`, `id_venta`) VALUES
(9, 3, 3, 1300.00, 9),
(16, 43, 3, 125.00, 16);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE `productos` (
  `id` int(11) NOT NULL,
  `codigo` varchar(20) NOT NULL,
  `nombre` text NOT NULL,
  `proveedor` int(11) NOT NULL,
  `stock` int(11) NOT NULL,
  `precio` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`id`, `codigo`, `nombre`, `proveedor`, `stock`, `precio`) VALUES
(2, '1234', 'Mouse usb vorago sencillo ', 2, 0, 100.00),
(3, '2', 'Monitor 19 pulgadas Stylos. STPMOT3B', 3, 7, 1300.00),
(4, '3', 'Monitor ACTECK Captive Vivid SP215, 21.5 pulgadas', 3, 10, 1800.00),
(5, '4', 'Memoria Ram ADATA AD4U26664G19-SGN, 4 GB, DDR4', 3, 11, 350.00),
(6, '5', 'Memoria RAM ADATA AD4S26664G19-SGN, 4 GB, DDR4', 3, 5, 350.00),
(7, '6', 'Memoria RAM ADATA PC3L 12800, 4 GB, DDR3L', 3, 37, 400.00),
(8, '7', 'Memoria ADATA ADDX1600W4G11-SPU, 4 GB, DDR3L', 2, 2, 400.00),
(9, '8', 'Memoria RAM ADATA PREMIER, 8 GB, DDR3L, 1600 MHz, 240-pin DIMM, PC de Escritorio', 3, 9, 650.00),
(10, '9', 'Memoria RAM ADATA PC12800, 8 GB, DDR3L, 1600 MHz, Portátil, 204-pin SO-DIMM', 3, 12, 650.00),
(11, '10', 'Memoria RAM ADATA PREMIER, 8 GB, DDR4, 2666 MHz, UDIMM, PC de Escritorio', 3, 3, 600.00),
(12, '11', 'Memoria ADATA AD4S26668G19-SGN, 8 GB, DDR4, 2666 MHz, SO-DIMM', 3, 5, 600.00),
(13, '12', 'Memoria RAM ADATA AD5S48008G-S, 8 GB, DDR5, 4800MHz, SO-DIMM', 3, 12, 700.00),
(15, '13', 'Memoria RAM ADATA AD5U480016G-S , 16 GB, DDR5, 4800MHz, UDIMM', 3, 2, 1000.00),
(16, '18', 'ADAPTADOR OTG COMPACTO TIPO C A USB ', 4, 12, 0.00),
(17, '19', 'ADAPTADOR OTG FLEXIBLE TIPO C A USB', 4, 1, 0.00),
(18, '20', 'MEMORIA USB 2,0 STYLOS DE 8GB', 4, 3, 60.00),
(19, '21', 'MEMORIA USB 2,0 SANDISK DE 16GB', 4, 44, 90.00),
(20, '22', 'MEMORIA USB 3,0 KINGSTON DE 32 GB', 4, 34, 120.00),
(21, '23', 'MEMORIA  MICRO SD ADATA DE 32GB', 4, 12, 140.00),
(22, '24', 'ADAPTADOR MICRO SD A USB SENCILLO ', 4, 1, 0.00),
(23, '25', 'CARGADOR DE BATERIA DE CELULAR UNIVERSAL DE PARED', 4, 1, 0.00),
(24, '26', 'CABLE USB BLANCO DE IPHONE REFORZADO DE 1,5M, 1 HORA', 4, 3, 32.00),
(25, '27', 'CABLE USB NEGRO REFORZADO TIPO C DE 1,5M, 1 HORA', 4, 12, 32.00),
(26, '28', 'CABLE USB C A USB C DE 1M, 1 HORA, NEGRO', 4, 21, 30.00),
(27, '29', 'CABLE REFORZADO METALICO USB V8, 1M, BLACKPCS', 4, 12, 120.00),
(28, '30', 'CLAVIJA SENCILLA 5V, 1A, 1 HORA, NEGRO ', 4, 12, 30.00),
(29, '31', 'CARGADOR PARA CELULAR COMPLETO ECONOMICO, MOREKA', 4, 27, 35.00),
(30, '32', 'CARGADOR DE BATERIA VOLTECK CON 2 BATERIAS AA ', 4, 3, 0.00),
(31, '33', 'SOPORTE TIPO CONTROL PARA CELULAR CON VENTILADOR, ELEGATE', 4, 20, 250.00),
(32, '34', 'SOPORTE SENCILLO PARA CELULAR TIPO SILLITA', 4, 29, 32.00),
(33, '35', 'HUB USB DE 4 PUERTOS TECHZONE', 4, 1, 0.00),
(34, '36', 'CABLE HDMI ECONOMICO DE 1,5M', 4, 1, 0.00),
(35, '37', 'CABLE MINI USB 1,8M, MANHATTAN', 4, 28, 0.00),
(36, '38', 'LUCES LED USB ECONOMICAS DE 5 M', 4, 14, 125.00),
(37, '39', 'AUDIFONOS MANOS LIBRES, NACEB, ROJOS', 4, 10, 0.00),
(38, '40', 'MOUSEPAD GAMING NACEB MODELO DRAGOX NA-0945', 4, 11, 150.00),
(39, '41', 'AUDIFONOS TIPO DIADEMA PARA PC NACEB NA-0316', 4, 13, 150.00),
(40, '42', 'BOCINAS USB NACEB NA-082', 4, 3, 150.00),
(41, '43', 'BOCINA BLUETOOTH BROBOTIX CHICA ', 4, 1, 0.00),
(42, '44', 'MOUSE USB ALAMBRICO VORAGO', 4, 7, 75.00),
(43, '45', 'MINI MOUSE INALAMBRICO NACEB NA-273', 4, 13, 125.00),
(44, '46', 'CARGADOR PARA AUTO SENCILLO DOBLE SALIDA USB ', 4, 12, 18.00),
(45, '47', 'SOPORTE PARA CELULAR TIPO GARRA PARA CONTROLO DE XBOX', 4, 12, 0.00),
(46, '48', 'SOPORTE PARA CELULAR TIPO CONTROL CON ACCESORIOS, ELEGATE', 4, 1, 0.00),
(47, '49', 'MOUSEPAD TEXTIL ACTECK VIBE FLOW MT430', 4, 9, 80.00),
(48, '50', 'BASCULA PARA COCINA PRETUL, HASTA 3 KILOGRAMOS', 4, 1, 0.00),
(49, '51', 'PARILLA ELECTRICA VOLTECK BASIC PALL-1CP', 4, 4, 0.00),
(50, '52', 'POWERBANK DE 20MAH XB5538 MARCA XINMI', 4, 45, 175.00),
(51, '53', 'CONTROL BLUETOOTH CON SOPORTE PARA CELULAR, ELEGATE', 4, 3, 0.00),
(52, '54', 'VELITA LED CHICA ', 4, 4, 25.00),
(53, '55', 'CABLE MINI USB 1,8M, MANHATTAN', 4, 7, 0.00),
(54, '56', 'CABLE HDMI ECONOMICO 1M', 4, 6, 40.00),
(55, '57', 'CABLE HDMI ECONOMICO DE 1,5M', 4, 1, 0.00),
(56, '58', 'CABLE VGA ECONOMICO DE 1,5M, ELEGATE', 4, 4, 85.00),
(57, '59', 'ADAPTADOR \"Y\" VGA (SPLITTER O DIVISOR), ELEGATE', 4, 22, 170.00),
(58, '60', 'CABLE RCA DE AUDIO DE 3.5M', 4, 9, 0.00),
(59, '61', 'CABLE RCA DE AUDIO DE 1,5M', 4, 19, 0.00),
(60, '62', 'CABLE DE AUDIO 3.5MM A RCA DE 1,5M', 4, 12, 0.00),
(61, '63', 'CABLE DE AUDIO AUXILIAR A RCA DE 5M', 4, 12, 0.00),
(62, '64', 'CABLE USB ECONOMICO DE 1M ', 4, 8, 0.00),
(63, '65', 'CABLE AUXILIAR ECONOMICO 3,5MM DE 1M', 4, 29, 0.00),
(64, '66', 'CABLE AUXILIAR ECONOMICO 3,5MM DE 2M', 4, 18, 0.00),
(65, '67', 'CARGADOR COMPLETO ECONOMICO PARA CELULAR KINGBOARD, V8', 4, 38, 35.00),
(66, '68', 'CARGADOR PARA CELULAR COMPLETO ECONOMICO, MOREKA', 4, 40, 35.00),
(67, '69', 'CABLE USB V8 ECONOMICO, 1M', 4, 5, 0.00),
(68, '70', 'CABLE USB C DE 1M, COLOR NEGRO, 1HORA', 4, 45, 30.00),
(69, '71', 'CLAVIJA SENCILLA TIPO CUBO, 5V, 1A, BLANCA', 4, 6, 0.00),
(70, '72', 'CLAVIJA SENCILLA 5V, 1A, 1 HORA, BLANCA ', 4, 19, 30.00),
(71, '73', 'CARGADOR DE BATERIA DE CELULAR UNIVERSAL DE PARED', 4, 12, 0.00),
(72, '74', 'CABLE USB C A USB C DE 1M, 1 HORA, NEGRO', 4, 1, 30.00),
(73, '75', 'CABLE USB IMITACION ADATA DE 1M', 4, 42, 50.00),
(74, '76', 'CABLE USB V8 ADATA DE 1M', 4, 32, 90.00),
(75, '77', 'CABLE USB NEGRO REFORZADO TIPO C DE 1,5M, 1 HORA', 4, 33, 32.00),
(76, '78', 'CABLE USB BLANCO DE IPHONE REFORZADO DE 1,5M, 1 HORA', 4, 32, 32.00),
(77, '79', 'AUDIFONOS MANOS LIBRES SENCILLO TIPO SAMSUNG J5, BLANCOS', 4, 5, 14.00),
(78, '80', 'AUDIFONOS MANOS LIBRES FX EAR-B015, VARIOS COLORES ', 4, 11, 20.00),
(79, '81', 'MOUSEPAD TEXTIL ACTECK VIBE FLOW MT430', 4, 3, 80.00),
(80, '82', 'MOUSEPAD CON SOPORTE DE GEL NACEB LA-549AZDE, AZUL', 4, 10, 100.00),
(81, '83', 'MOUSEPAD ECONOMICO MODELO 423526, NEGRO ', 4, 22, 40.00),
(82, '84', 'TABLETA MAGICA LCDDE 8.5PULGADAS', 4, 1, 0.00),
(83, '85', 'MOUSE USB ALAMBRICO VORAGO', 4, 19, 75.00),
(84, '86', 'MOUSE INALAMBRICO ACTECK', 4, 24, 125.00),
(85, '87', 'RECEPTOR BLUETOOTH CON CONECTOR DE 3.5MM', 4, 9, 0.00),
(86, '89', 'MINI SELFIE STICK', 4, 8, 85.00),
(87, '90', 'MEMORIA USB 3.0 ADATA, 32GB', 4, 3, 120.00),
(88, '91', 'BATERIA CR2032 DE LITIO A 3V, PAQUETE CON 2', 4, 9, 0.00),
(89, '92', 'BATERIA ALCALINA DE 12V, 27A, MODELOS A 27, A27BP, G27A, GP27A, L828, MN27, MARCA TOSHIBA', 2, 19, 0.00),
(90, '93', 'BATERIA AA VOLTECK', 4, 9, 0.00),
(91, '94', 'AUDIFONOS TIPO DIADEMA PARA PC NACEB NA-0316', 4, 12, 150.00),
(92, '95', 'VELITA LED CHICA ', 4, 2, 25.00),
(93, '96', 'SOPORTE PARA CELULAR TIPO CONTROL SIN ACCESORIOS, INCOMPLETO', 4, 8, 0.00),
(94, '97', 'SOPORTE PARA CELULAR TIPO CONTROL CON ACCESORIOS, ELEGATE', 4, 9, 0.00),
(95, '98', 'SERIES DE LUCES NAVIDEÑAS LED CON 300 LUCES ', 4, 17, 215.00),
(96, '99', 'GUIRNALDA NAVIDEÑA FORMA DE ESTRELLA CON FIGURAS Y LUCES LED', 4, 32, 250.00),
(97, '100', 'BASE ENFRIADORA PARA LAPTOP COOLERPAD', 4, 10, 0.00),
(98, '101', 'ESPUMA LIMPIADORA PARA SUPERFICIES DE EQUIPOS ELECTRONICOS SILIMPO DE 454ML', 4, 12, 130.00),
(99, '102', 'ALCOHOL ISOPROPILICO SILIMEX EN AEROSOL DE 250ML', 4, 50, 150.00),
(100, '103', 'KIT DE LIMPIEZA PARA PANTALLAS LCD NACEB NA-068 DE 200ML', 4, 6, 75.00),
(101, '105', 'SWITCH DAHUA PFS3005-5ET-L ', 4, 2, 170.00),
(102, '106', 'MOUSE GAMER NACEB RGB NA-0937', 4, 19, 190.00),
(103, '107', 'REGULADOR VORAGO AVR-100 1000VA', 2, 30, 340.00),
(104, '108', 'TECLADO ACTECK AUREAN X TA220 LED NEG ', 4, 20, 220.00),
(105, '109', 'ROUTER 300MBPS MERCUSYS MW306R', 4, 33, 330.00),
(106, '110', 'GABINETE /CASE/CARCASA EXTERNO P/SSD-HDD ADATA AEX500', 3, 27, 270.00),
(107, '111', 'SSD ADATA 240GB ASU630SS-240GQ-R', 4, 4, 560.00),
(108, '112', 'SWITCH MERCUSYS MS108 DE 8 PUERTOS', 5, 20, 185.00),
(109, '113', 'Solicitud de empleo IMPRESA', 4, 50, 3.00),
(110, '114', 'Solicitud de empleo papeleria', 6, 40, 5.00),
(111, '115', 'LAPIZ ADHESIVO JUMBO DE 42g', 4, 34, 32.00),
(112, '116', 'SOBRE BLANCO CORRESPONDENCIA FORTEC TAMAÑO OFICIO', 4, 34, 3.00),
(113, '117', 'CINTA ADHESIVA TRANSPARENTE 18 X 33 mm', 4, 21, 28.00),
(114, '118', 'HOJA CARTA BLANCA POR PIEZA', 2, 9, 0.50),
(115, '119', 'HOJA OFICIO BLANCA EN PAQ DE 2 HOJAS', 4, 19, 1.50),
(116, '120', 'HOJA OPALINA BLANCA 125g', 4, 100, 2.00),
(117, '121', 'HOJA OPALINA MARFIL 125g', 3, 100, 2.00),
(118, '122', 'HOJA OPALINA BLANCA 225g', 4, 100, 3.00),
(119, '123', 'SOBRE BOLSA T/CARTA FORTEC MANILA CON SOLAPA', 4, 40, 6.50),
(120, '124', 'SOBRE BOLSA T/OFICIO FORTEC MANILA CON SOLAPA', 2, 70, 8.00),
(121, '125', 'PLIEGO PAPEL BOND BLANCO', 4, 69, 8.00),
(122, '126', 'PLIEGO DE PAPEL BOND CUADRICULADO', 4, 21, 7.00),
(123, '127', 'CARPETA TAMAÑO OFICIO', 4, 100, 7.00);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proveedor`
--

CREATE TABLE `proveedor` (
  `id` int(11) NOT NULL,
  `rfc` varchar(15) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `telefono` varchar(15) NOT NULL,
  `direccion` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `proveedor`
--

INSERT INTO `proveedor` (`id`, `rfc`, `nombre`, `telefono`, `direccion`) VALUES
(2, 'PSNN040808VWX', 'Productos y Servicios del Noreste S.A. de C.V.', '81 890 1234 ', 'venida Universidad #505, Colonia Del Valle, San Nicolás de los Garza, Nuevo León'),
(3, 'TSCQ000404JKL', 'Tecnología y Soluciones del Centro de Colima', '312 345 6789', 'Calle Constitución #123, Colonia Centro, Colima'),
(4, 'IDN980202DEF', 'Tech Solutions de México ', '81 234 5678', 'Colima, Col Avenida Universidad #456, Colonia San Pedro, Monterrey, Nuevo León.'),
(5, ' HEG020606PQR', 'Hogar y Estilo', '55 1234 5678', 'Calle Madero #303, Colonia Chapultepec, Puebla'),
(6, 'CHS061010BCD', 'Confort Hogar ', ' 229 012 3456', ' Avenida Ruiz Cortines #707, Colonia Centro, Veracruz'),
(9, '1212', 'fer', '31213121491', 'coqui');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `nombre` varchar(200) NOT NULL,
  `correo` varchar(200) NOT NULL,
  `pass` varchar(50) NOT NULL,
  `rol` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `nombre`, `correo`, `pass`, `rol`) VALUES
(3, 'Fernando', 'jjimenez31@ucol.mx', 'Admin', 'Administrador'),
(5, 'Lazaro Alejandro', 'lramirez35@ucol.mx ', 'Admin6858', 'Administrador'),
(6, 'Prueba', 'prueba@gmail.com', 'admin123', 'Asistente');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ventas`
--

CREATE TABLE `ventas` (
  `id` int(11) NOT NULL,
  `cliente` int(11) NOT NULL,
  `vendedor` varchar(60) NOT NULL,
  `total` decimal(10,2) NOT NULL,
  `fecha` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `ventas`
--

INSERT INTO `ventas` (`id`, `cliente`, `vendedor`, `total`, `fecha`) VALUES
(9, 3, 'Fernando', 3900.00, '11/05/2024'),
(16, 7, 'Fernando', 375.00, '16/05/2024');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `config`
--
ALTER TABLE `config`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `detalle`
--
ALTER TABLE `detalle`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_venta` (`id_venta`),
  ADD KEY `id_pro` (`id_pro`);

--
-- Indices de la tabla `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `proveedor` (`proveedor`);

--
-- Indices de la tabla `proveedor`
--
ALTER TABLE `proveedor`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `ventas`
--
ALTER TABLE `ventas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cliente` (`cliente`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `clientes`
--
ALTER TABLE `clientes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT de la tabla `config`
--
ALTER TABLE `config`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `detalle`
--
ALTER TABLE `detalle`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=125;

--
-- AUTO_INCREMENT de la tabla `proveedor`
--
ALTER TABLE `proveedor`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `ventas`
--
ALTER TABLE `ventas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `detalle`
--
ALTER TABLE `detalle`
  ADD CONSTRAINT `detalle_ibfk_1` FOREIGN KEY (`id_pro`) REFERENCES `productos` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `detalle_ibfk_2` FOREIGN KEY (`id_venta`) REFERENCES `ventas` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `productos`
--
ALTER TABLE `productos`
  ADD CONSTRAINT `productos_ibfk_1` FOREIGN KEY (`proveedor`) REFERENCES `proveedor` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `ventas`
--
ALTER TABLE `ventas`
  ADD CONSTRAINT `ventas_ibfk_1` FOREIGN KEY (`cliente`) REFERENCES `clientes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
