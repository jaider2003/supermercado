-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 12-03-2025 a las 21:58:58
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `supermercado`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`` PROCEDURE `ActualizarPrecioProducto` (IN `p_id` INT, IN `p_nuevo_precio` DECIMAL(10,2))   BEGIN
    UPDATE Productos SET precio = p_nuevo_precio WHERE id = p_id;
END$$

CREATE DEFINER=`` PROCEDURE `ActualizarStock` (IN `p_id` INT, IN `p_nuevo_stock` INT)   BEGIN
    UPDATE Productos SET stock = p_nuevo_stock WHERE id = p_id;
END$$

CREATE DEFINER=`` PROCEDURE `AgregarCliente` (IN `p_nombre` VARCHAR(100), IN `p_apellido` VARCHAR(100), IN `p_direccion` VARCHAR(255))   BEGIN
    INSERT INTO Clientes (nombre, apellido, direccion) VALUES (p_nombre, p_apellido, p_direccion);
END$$

CREATE DEFINER=`` PROCEDURE `AgregarProducto` (IN `p_nombre` VARCHAR(100), IN `p_categoria` VARCHAR(100), IN `p_precio` DECIMAL(10,2), IN `p_stock` INT)   BEGIN
    INSERT INTO Productos (nombre, categoria, precio, stock)
    VALUES (p_nombre, p_categoria, p_precio, p_stock);
END$$

CREATE DEFINER=`` PROCEDURE `ClientesFrecuentes` ()   BEGIN
    SELECT id_cliente, COUNT(*) AS compras_realizadas 
    FROM Ventas 
    GROUP BY id_cliente 
    ORDER BY compras_realizadas DESC 
    LIMIT 10;
END$$

CREATE DEFINER=`` PROCEDURE `EliminarProducto` (IN `p_id` INT)   BEGIN
    DELETE FROM Productos WHERE id = p_id;
END$$

CREATE DEFINER=`` PROCEDURE `ObtenerDetalleVenta` (IN `p_id_venta` INT)   BEGIN
    SELECT * FROM Ventas WHERE id_venta = p_id_venta;
END$$

CREATE DEFINER=`` PROCEDURE `ProductosMasVendidos` ()   BEGIN
    SELECT P.nombre, SUM(V.cantidad) AS total_vendido
    FROM Ventas V
    INNER JOIN Productos P ON V.id_producto = P.id  -- Usamos 'id' en lugar de 'id_producto'
    GROUP BY P.nombre
    ORDER BY total_vendido DESC
    LIMIT 10;
END$$

CREATE DEFINER=`` PROCEDURE `ProductosPorCategoria` (IN `p_categoria` VARCHAR(100))   BEGIN
    SELECT * FROM Productos WHERE categoria = p_categoria;
END$$

CREATE DEFINER=`` PROCEDURE `RegistrarVenta` (IN `p_id_cliente` INT, IN `p_id_producto` INT, IN `p_cantidad` INT, IN `p_total` DECIMAL(10,2))   BEGIN
    INSERT INTO Ventas (id_cliente, id_producto, cantidad, total, fecha_venta)
    VALUES (p_id_cliente, p_id_producto, p_cantidad, p_total, NOW());
END$$

CREATE DEFINER=`` PROCEDURE `ReporteIngresosMensuales` (IN `p_mes` INT, IN `p_anio` INT)   BEGIN
    SELECT SUM(total) AS ingresos_totales
    FROM Ventas
    WHERE MONTH(fecha_venta) = p_mes AND YEAR(fecha_venta) = p_anio;
END$$

CREATE DEFINER=`` PROCEDURE `ReporteVentasPorFecha` (IN `p_fecha_inicio` DATE, IN `p_fecha_fin` DATE)   BEGIN
    SELECT * FROM Ventas 
    WHERE fecha_venta BETWEEN p_fecha_inicio AND p_fecha_fin;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `carrito`
--

CREATE TABLE `carrito` (
  `id` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `id_producto` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `carrito`
--

INSERT INTO `carrito` (`id`, `id_usuario`, `id_producto`, `cantidad`) VALUES
(1, 1, 1, 2),
(2, 2, 3, 1),
(3, 1, 4, 3),
(4, 2, 2, 1),
(5, 1, 5, 5);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categorias`
--

CREATE TABLE `categorias` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `descripcion` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `categorias`
--

INSERT INTO `categorias` (`id`, `nombre`, `descripcion`) VALUES
(1, 'Lácteos', 'Productos derivados de la leche'),
(2, 'Carnes', 'Carnes rojas y blancas'),
(3, 'Bebidas', 'Refrescos y jugos naturales'),
(4, 'Abarrotes', 'Productos básicos para el hogar'),
(5, 'Panadería', 'Pan y productos horneados');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientes`
--

CREATE TABLE `clientes` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `apellido` varchar(100) NOT NULL,
  `direccion` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `clientes`
--

INSERT INTO `clientes` (`id`, `nombre`, `apellido`, `direccion`) VALUES
(1, 'Carlos', 'Gómez', 'Calle 123, Ciudad');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `compras`
--

CREATE TABLE `compras` (
  `id` int(11) NOT NULL,
  `id_usuario` int(11) DEFAULT NULL,
  `total` decimal(10,2) NOT NULL,
  `fecha` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `compras`
--

INSERT INTO `compras` (`id`, `id_usuario`, `total`, `fecha`) VALUES
(1, 1, 15500.00, '2025-02-28 17:09:10'),
(2, 2, 25000.00, '2025-02-28 17:09:10'),
(3, 1, 8000.00, '2025-02-28 17:09:10'),
(4, 2, 3000.00, '2025-02-28 17:09:10'),
(5, 1, 12500.00, '2025-02-28 17:09:10');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_compra`
--

CREATE TABLE `detalle_compra` (
  `id` int(11) NOT NULL,
  `id_compra` int(11) DEFAULT NULL,
  `id_producto` int(11) DEFAULT NULL,
  `cantidad` int(11) DEFAULT NULL,
  `precio_unitario` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `detalle_compra`
--

INSERT INTO `detalle_compra` (`id`, `id_compra`, `id_producto`, `cantidad`, `precio_unitario`) VALUES
(1, 1, 1, 2, 13650.00),
(2, 2, 2, 1, 39000.00),
(3, 3, 3, 1, 19500.00),
(4, 4, 4, 3, 7800.00),
(5, 5, 5, 5, 5850.00);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `facturas`
--

CREATE TABLE `facturas` (
  `id` int(11) NOT NULL,
  `id_compra` int(11) NOT NULL,
  `fecha_emision` timestamp NOT NULL DEFAULT current_timestamp(),
  `total` decimal(10,2) NOT NULL,
  `metodo_pago` enum('Efectivo','Tarjeta','Transferencia') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `facturas`
--

INSERT INTO `facturas` (`id`, `id_compra`, `fecha_emision`, `total`, `metodo_pago`) VALUES
(1, 1, '2025-02-28 17:14:01', 15500.00, 'Efectivo'),
(2, 2, '2025-02-28 17:14:01', 25000.00, 'Tarjeta'),
(3, 3, '2025-02-28 17:14:01', 8000.00, 'Transferencia'),
(4, 4, '2025-02-28 17:14:01', 3000.00, 'Efectivo'),
(5, 5, '2025-02-28 17:14:01', 12500.00, 'Tarjeta');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE `productos` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `precio` decimal(10,2) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `id_categoria` int(11) DEFAULT NULL,
  `id_proveedor` int(11) DEFAULT NULL,
  `fecha_agregado` timestamp NOT NULL DEFAULT current_timestamp(),
  `categoria` varchar(100) DEFAULT NULL,
  `stock` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`id`, `nombre`, `descripcion`, `precio`, `cantidad`, `id_categoria`, `id_proveedor`, `fecha_agregado`, `categoria`, `stock`) VALUES
(1, 'Leche Entera', '1L de leche entera', 3500.00, 50, 1, 1, '2025-02-28 17:12:34', NULL, 50),
(2, 'Carne de Res', '500g de carne de res', 19.99, 30, 2, 2, '2025-02-28 17:12:34', NULL, NULL),
(3, 'Jugo de Naranja', '1L de jugo natural', 5000.00, 40, 3, 3, '2025-02-28 17:12:34', NULL, NULL),
(4, 'Arroz 1kg', 'Bolsa de arroz de 1kg', 2000.00, 100, 4, 4, '2025-02-28 17:12:34', NULL, NULL),
(5, 'Pan Integral', 'Pan de trigo integral', 1500.00, 60, 5, 5, '2025-02-28 17:12:34', NULL, NULL),
(6, 'Arroz', NULL, 2.50, 0, NULL, NULL, '2025-03-12 03:42:23', 'Alimentos', 100);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proveedores`
--

CREATE TABLE `proveedores` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `contacto` varchar(100) DEFAULT NULL,
  `telefono` varchar(15) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `proveedores`
--

INSERT INTO `proveedores` (`id`, `nombre`, `contacto`, `telefono`) VALUES
(1, 'Lácteos Del Valle', 'Juan Pérez', '3123456789'),
(2, 'Carnes Premium', 'María Gómez', '3145678901'),
(3, 'Bebidas Tropicales', 'Carlos López', '3156789012'),
(4, 'Distribuidora Abarrotes', 'Ana Ramírez', '3167890123'),
(5, 'Panadería El Trigo', 'Pedro Sánchez', '3178901234');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `correo` varchar(100) NOT NULL,
  `contrasena` varchar(255) NOT NULL,
  `rol` enum('cliente','administrador') DEFAULT 'cliente',
  `fecha_registro` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `nombre`, `correo`, `contrasena`, `rol`, `fecha_registro`) VALUES
(1, 'Jaider Rovira Martinez', 'jaider@gmail.com', '$2y$10$iipWsv2Rq24He8e/IBnUhOdVS5FsD38NddZYkEuPbUj7Va85DCuK.', 'cliente', '2025-02-26 01:16:44'),
(2, 'Camilo Perez Serna', 'Camilop@gmail.com', '$2y$10$zAnmAhJjOGmUCXrI7y0d1uRVPcnz.3xDKCvLLSAu3g9.EVoB2CZwK', 'cliente', '2025-02-26 01:31:41'),
(3, 'Dayana Chaverra', 'dayana@gmail.com', '$2y$10$EkFZNYKlIoheRRoE.GR.XOYWNs9wPOagg4da5gsPxq1Mlp4231BUy', 'cliente', '2025-02-28 17:19:56'),
(4, 'Jhon Berrio Berrio', 'JB@gmail.com', '$2y$10$5FVhzXbEAHo0ZG7eU7JzSuat7ArLW0alSFsOMiV.QtpuM6GKqInM2', 'cliente', '2025-02-28 17:24:58'),
(5, 'Carlos Perea', 'Carlos@gmail.com', '$2y$10$ot2ZPDKj/FTXLkBU2jW7U.LEHByKFgp9wPSUh2xM50fhqlKGuIw4G', 'cliente', '2025-02-28 17:25:33');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ventas`
--

CREATE TABLE `ventas` (
  `id_venta` int(11) NOT NULL,
  `id_cliente` int(11) DEFAULT NULL,
  `id_producto` int(11) DEFAULT NULL,
  `cantidad` int(11) DEFAULT NULL,
  `total` decimal(10,2) DEFAULT NULL,
  `fecha_venta` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `ventas`
--

INSERT INTO `ventas` (`id_venta`, `id_cliente`, `id_producto`, `cantidad`, `total`, `fecha_venta`) VALUES
(1, 1, 3, 2, 5.00, '2025-03-11 22:50:41'),
(2, 1, 1, 2, 0.04, '2025-03-11 23:29:54');

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vista_carrito_usuarios`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vista_carrito_usuarios` (
`id` int(11)
,`usuario` varchar(100)
,`producto` varchar(100)
,`cantidad` int(11)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vista_clientes_compras`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vista_clientes_compras` (
`id` int(11)
,`nombre` varchar(100)
,`total_compras` bigint(21)
,`monto_total` decimal(32,2)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vista_compras_metodo_pago`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vista_compras_metodo_pago` (
`metodo_pago` enum('Efectivo','Tarjeta','Transferencia')
,`cantidad_compras` bigint(21)
,`total_recaudado` decimal(32,2)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vista_compras_usuarios`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vista_compras_usuarios` (
`id` int(11)
,`usuario` varchar(100)
,`total` decimal(10,2)
,`fecha` timestamp
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vista_detalle_compras`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vista_detalle_compras` (
`id` int(11)
,`compra` int(11)
,`producto` varchar(100)
,`cantidad` int(11)
,`precio_unitario` decimal(10,2)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vista_facturas`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vista_facturas` (
`id` int(11)
,`compra` int(11)
,`fecha_emision` timestamp
,`total` decimal(10,2)
,`metodo_pago` enum('Efectivo','Tarjeta','Transferencia')
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vista_productos_categorias`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vista_productos_categorias` (
`id` int(11)
,`producto` varchar(100)
,`descripcion` text
,`precio` decimal(10,2)
,`categoria` varchar(100)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vista_productos_mas_vendidos`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vista_productos_mas_vendidos` (
`id` int(11)
,`nombre` varchar(100)
,`total_vendido` decimal(32,0)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vista_proveedores_productos`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vista_proveedores_productos` (
`id` int(11)
,`proveedor` varchar(100)
,`producto` varchar(100)
,`precio` decimal(10,2)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vista_stock_productos`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vista_stock_productos` (
`id` int(11)
,`nombre` varchar(100)
,`stock_disponible` int(11)
);

-- --------------------------------------------------------

--
-- Estructura para la vista `vista_carrito_usuarios`
--
DROP TABLE IF EXISTS `vista_carrito_usuarios`;

CREATE ALGORITHM=UNDEFINED DEFINER=`` SQL SECURITY DEFINER VIEW `vista_carrito_usuarios`  AS SELECT `c`.`id` AS `id`, `u`.`nombre` AS `usuario`, `p`.`nombre` AS `producto`, `c`.`cantidad` AS `cantidad` FROM ((`carrito` `c` join `usuarios` `u` on(`c`.`id_usuario` = `u`.`id`)) join `productos` `p` on(`c`.`id_producto` = `p`.`id`)) ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vista_clientes_compras`
--
DROP TABLE IF EXISTS `vista_clientes_compras`;

CREATE ALGORITHM=UNDEFINED DEFINER=`` SQL SECURITY DEFINER VIEW `vista_clientes_compras`  AS SELECT `u`.`id` AS `id`, `u`.`nombre` AS `nombre`, count(`co`.`id`) AS `total_compras`, sum(`co`.`total`) AS `monto_total` FROM (`usuarios` `u` left join `compras` `co` on(`u`.`id` = `co`.`id_usuario`)) GROUP BY `u`.`id`, `u`.`nombre` ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vista_compras_metodo_pago`
--
DROP TABLE IF EXISTS `vista_compras_metodo_pago`;

CREATE ALGORITHM=UNDEFINED DEFINER=`` SQL SECURITY DEFINER VIEW `vista_compras_metodo_pago`  AS SELECT `f`.`metodo_pago` AS `metodo_pago`, count(`f`.`id`) AS `cantidad_compras`, sum(`f`.`total`) AS `total_recaudado` FROM `facturas` AS `f` GROUP BY `f`.`metodo_pago` ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vista_compras_usuarios`
--
DROP TABLE IF EXISTS `vista_compras_usuarios`;

CREATE ALGORITHM=UNDEFINED DEFINER=`` SQL SECURITY DEFINER VIEW `vista_compras_usuarios`  AS SELECT `co`.`id` AS `id`, `u`.`nombre` AS `usuario`, `co`.`total` AS `total`, `co`.`fecha` AS `fecha` FROM (`compras` `co` join `usuarios` `u` on(`co`.`id_usuario` = `u`.`id`)) ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vista_detalle_compras`
--
DROP TABLE IF EXISTS `vista_detalle_compras`;

CREATE ALGORITHM=UNDEFINED DEFINER=`` SQL SECURITY DEFINER VIEW `vista_detalle_compras`  AS SELECT `dc`.`id` AS `id`, `co`.`id` AS `compra`, `p`.`nombre` AS `producto`, `dc`.`cantidad` AS `cantidad`, `dc`.`precio_unitario` AS `precio_unitario` FROM ((`detalle_compra` `dc` join `compras` `co` on(`dc`.`id_compra` = `co`.`id`)) join `productos` `p` on(`dc`.`id_producto` = `p`.`id`)) ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vista_facturas`
--
DROP TABLE IF EXISTS `vista_facturas`;

CREATE ALGORITHM=UNDEFINED DEFINER=`` SQL SECURITY DEFINER VIEW `vista_facturas`  AS SELECT `f`.`id` AS `id`, `co`.`id` AS `compra`, `f`.`fecha_emision` AS `fecha_emision`, `f`.`total` AS `total`, `f`.`metodo_pago` AS `metodo_pago` FROM (`facturas` `f` join `compras` `co` on(`f`.`id_compra` = `co`.`id`)) ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vista_productos_categorias`
--
DROP TABLE IF EXISTS `vista_productos_categorias`;

CREATE ALGORITHM=UNDEFINED DEFINER=`` SQL SECURITY DEFINER VIEW `vista_productos_categorias`  AS SELECT `p`.`id` AS `id`, `p`.`nombre` AS `producto`, `p`.`descripcion` AS `descripcion`, `p`.`precio` AS `precio`, `c`.`nombre` AS `categoria` FROM (`productos` `p` join `categorias` `c` on(`p`.`id_categoria` = `c`.`id`)) ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vista_productos_mas_vendidos`
--
DROP TABLE IF EXISTS `vista_productos_mas_vendidos`;

CREATE ALGORITHM=UNDEFINED DEFINER=`` SQL SECURITY DEFINER VIEW `vista_productos_mas_vendidos`  AS SELECT `p`.`id` AS `id`, `p`.`nombre` AS `nombre`, sum(`dc`.`cantidad`) AS `total_vendido` FROM (`detalle_compra` `dc` join `productos` `p` on(`dc`.`id_producto` = `p`.`id`)) GROUP BY `p`.`id`, `p`.`nombre` ORDER BY sum(`dc`.`cantidad`) DESC ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vista_proveedores_productos`
--
DROP TABLE IF EXISTS `vista_proveedores_productos`;

CREATE ALGORITHM=UNDEFINED DEFINER=`` SQL SECURITY DEFINER VIEW `vista_proveedores_productos`  AS SELECT `pr`.`id` AS `id`, `pr`.`nombre` AS `proveedor`, `p`.`nombre` AS `producto`, `p`.`precio` AS `precio` FROM (`proveedores` `pr` join `productos` `p` on(`pr`.`id` = `p`.`id_proveedor`)) ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vista_stock_productos`
--
DROP TABLE IF EXISTS `vista_stock_productos`;

CREATE ALGORITHM=UNDEFINED DEFINER=`` SQL SECURITY DEFINER VIEW `vista_stock_productos`  AS SELECT `p`.`id` AS `id`, `p`.`nombre` AS `nombre`, `p`.`cantidad` AS `stock_disponible` FROM `productos` AS `p` ;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `carrito`
--
ALTER TABLE `carrito`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_usuario` (`id_usuario`),
  ADD KEY `id_producto` (`id_producto`);

--
-- Indices de la tabla `categorias`
--
ALTER TABLE `categorias`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `compras`
--
ALTER TABLE `compras`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_usuario` (`id_usuario`);

--
-- Indices de la tabla `detalle_compra`
--
ALTER TABLE `detalle_compra`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_compra` (`id_compra`),
  ADD KEY `id_producto` (`id_producto`);

--
-- Indices de la tabla `facturas`
--
ALTER TABLE `facturas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_compra` (`id_compra`);

--
-- Indices de la tabla `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_categoria` (`id_categoria`),
  ADD KEY `id_proveedor` (`id_proveedor`);

--
-- Indices de la tabla `proveedores`
--
ALTER TABLE `proveedores`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `correo` (`correo`);

--
-- Indices de la tabla `ventas`
--
ALTER TABLE `ventas`
  ADD PRIMARY KEY (`id_venta`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `carrito`
--
ALTER TABLE `carrito`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `categorias`
--
ALTER TABLE `categorias`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `clientes`
--
ALTER TABLE `clientes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `compras`
--
ALTER TABLE `compras`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `detalle_compra`
--
ALTER TABLE `detalle_compra`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `facturas`
--
ALTER TABLE `facturas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `proveedores`
--
ALTER TABLE `proveedores`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `ventas`
--
ALTER TABLE `ventas`
  MODIFY `id_venta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `carrito`
--
ALTER TABLE `carrito`
  ADD CONSTRAINT `carrito_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`),
  ADD CONSTRAINT `carrito_ibfk_2` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id`);

--
-- Filtros para la tabla `compras`
--
ALTER TABLE `compras`
  ADD CONSTRAINT `compras_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`);

--
-- Filtros para la tabla `detalle_compra`
--
ALTER TABLE `detalle_compra`
  ADD CONSTRAINT `detalle_compra_ibfk_1` FOREIGN KEY (`id_compra`) REFERENCES `compras` (`id`),
  ADD CONSTRAINT `detalle_compra_ibfk_2` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id`);

--
-- Filtros para la tabla `facturas`
--
ALTER TABLE `facturas`
  ADD CONSTRAINT `facturas_ibfk_1` FOREIGN KEY (`id_compra`) REFERENCES `compras` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `productos`
--
ALTER TABLE `productos`
  ADD CONSTRAINT `productos_ibfk_1` FOREIGN KEY (`id_categoria`) REFERENCES `categorias` (`id`),
  ADD CONSTRAINT `productos_ibfk_2` FOREIGN KEY (`id_proveedor`) REFERENCES `proveedores` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
