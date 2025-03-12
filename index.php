<?php
session_start(); // Iniciar sesión para verificar si el usuario ya está autenticado

// Si el usuario ya está logueado, redirigimos al perfil
if (isset($_SESSION['usuario_id'])) {
    header("Location: perfil.php");
    exit();
}

// Lógica para mostrar productos destacados (esto es solo un ejemplo)
include 'db.php';  // Asegúrate de tener la conexión a la base de datos
$stmt = $conexion->query("SELECT * FROM productos LIMIT 5"); // Muestra 5 productos como ejemplo
$productos_destacados = $stmt->fetchAll();
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Supermercado</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="estilos.css">
</head>


<body>
    <div class="container">
        <!-- Encabezado -->
        <header>
            <h1>Bienvenido a nuestro Supermercado Online</h1>
            <nav>
                <ul>
                    <li><a href="login.php">Iniciar sesión</a></li>
                    <li><a href="registro.php">Regístrate</a></li>
                    <li><a href="productos.php">Ver productos</a></li>
                </ul>
            </nav>
        </header>

        <!-- Barra de búsqueda -->
        <section id="busqueda">
            <form action="productos.php" method="GET">
                <input type="text" name="buscar" placeholder="Busca productos..." required>
                <button type="submit">Buscar</button>
            </form>
        </section>

        <!-- Productos destacados -->
        <section id="productos-destacados">
            <h2>Productos destacados</h2>
            <div class="productos">
                <?php foreach ($productos_destacados as $producto): ?>
                    <div class="producto">
                        <img src="ruta/a/imagen/<?= $producto['imagen'] ?>" alt="<?= $producto['nombre'] ?>">
                        <h3><?= $producto['nombre'] ?></h3>
                        <p><?= substr($producto['descripcion'], 0, 100) ?>...</p>
                        <p><strong>$<?= $producto['precio'] ?></strong></p>
                        <a href="producto_detalle.php?id=<?= $producto['id'] ?>">Ver más</a>
                    </div>
                <?php endforeach; ?>
            </div>
        </section>

        <!-- Carrito de compras (solo visible si el usuario está logueado) -->
        <?php if (isset($_SESSION['usuario_id'])): ?>
        <section id="carrito">
            <h2>Tu carrito de compras</h2>
            <?php
            // Aquí podrías mostrar los productos en el carrito
            $stmt = $conexion->prepare("SELECT p.nombre, p.precio, c.cantidad FROM carrito c JOIN productos p ON c.id_producto = p.id WHERE c.id_usuario = ?");
            $stmt->execute([$_SESSION['usuario_id']]);
            $carrito = $stmt->fetchAll();

            if (count($carrito) > 0): ?>
                <ul>
                    <?php foreach ($carrito as $item): ?>
                        <li><?= $item['nombre'] ?> - $<?= $item['precio'] ?> x <?= $item['cantidad'] ?></li>
                    <?php endforeach; ?>
                </ul>
                <a href="carrito.php">Ver carrito completo</a>
            <?php else: ?>
                <p>Tu carrito está vacío.</p>
            <?php endif; ?>
        </section>
        <?php endif; ?>

        <!-- Información adicional -->
        <section id="informacion">
            <h2>Acerca de nosotros</h2>
            <p>En nuestro supermercado online, ofrecemos una amplia variedad de productos a precios competitivos. ¡Compra desde la comodidad de tu hogar!</p>
        </section>

        <footer>
            <p>&copy; 2025 Supermercado Online. Todos los derechos reservados.</p>
        </footer>
    </div>
</body>
</html>
