<?php
include 'db.php';

// Verificar si el usuario tiene rol de administrador
session_start();
if ($_SESSION['rol'] !== 'administrador') {
    header("Location: index.php");
    exit();
}

// Obtener todos los productos
$stmt = $conexion->query("SELECT * FROM productos");
$productos = $stmt->fetchAll();
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Administrar Productos</title>
    <link rel="stylesheet" href="estilos.css">
</head>
<body>
    <div class="container">
        <h1>Administrar Productos</h1>
        <table>
            <tr>
                <th>Nombre</th>
                <th>Descripción</th>
                <th>Precio</th>
                <th>Cantidad</th>
                <th>Acciones</th>
            </tr>
            <?php foreach ($productos as $producto): ?>
                <tr>
                    <td><?php echo $producto['nombre']; ?></td>
                    <td><?php echo $producto['descripcion']; ?></td>
                    <td>$<?php echo number_format($producto['precio'], 2); ?></td>
                    <td><?php echo $producto['cantidad']; ?></td>
                    <td><a href="editar_producto.php?id=<?php echo $producto['id']; ?>">Editar</a> | <a href="eliminar_producto.php?id=<?php echo $producto['id']; ?>">Eliminar</a></td>
                </tr>
            <?php endforeach; ?>
        </table>
        <a href="agregar_producto.php">Agregar Nuevo Producto</a>
    </div>
</body>
</html>
