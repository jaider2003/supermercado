<?php
include 'db.php';

$stmt = $conexion->query("SELECT * FROM productos");
$productos = $stmt->fetchAll();
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Catálogo de Productos</title>
    <link rel="stylesheet" href="estilos.css">
</head>
<body>
    <div class="container">
        <h1>Catálogo de Productos</h1>
        <div class="productos">
            <?php foreach ($productos as $producto): ?>
                <div class="producto">
                    <h3><?php echo $producto['nombre']; ?></h3>
                    <p><?php echo $producto['descripcion']; ?></p>
                    <p>Precio: $<?php echo number_format($producto['precio'], 2); ?></p>
                    <p>Stock: <?php echo $producto['cantidad']; ?></p>
                    <a href="agregar_al_carrito.php?id=<?php echo $producto['id']; ?>">Agregar al carrito</a>
                </div>
            <?php endforeach; ?>
        </div>
    </div>
</body>
</html>
