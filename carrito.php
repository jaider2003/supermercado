<?php
session_start();
include 'db.php';

$id_usuario = $_SESSION['usuario_id']; // Asumimos que ya el usuario está logueado

// Obtener los productos en el carrito
$stmt = $conexion->prepare("SELECT p.nombre, c.cantidad, p.precio 
                            FROM carrito c 
                            JOIN productos p ON c.id_producto = p.id 
                            WHERE c.id_usuario = ?");
$stmt->execute([$id_usuario]);
$productos_carrito = $stmt->fetchAll();

// Calcular total
$total = 0;
foreach ($productos_carrito as $producto) {
    $total += $producto['precio'] * $producto['cantidad'];
}
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Carrito de Compras</title>
    <link rel="stylesheet" href="estilos.css">
</head>
<body>
    <div class="container">
        <h1>Carrito de Compras</h1>
        <table>
            <tr>
                <th>Producto</th>
                <th>Cantidad</th>
                <th>Precio</th>
                <th>Total</th>
            </tr>
            <?php foreach ($productos_carrito as $producto): ?>
                <tr>
                    <td><?php echo $producto['nombre']; ?></td>
                    <td><?php echo $producto['cantidad']; ?></td>
                    <td>$<?php echo number_format($producto['precio'], 2); ?></td>
                    <td>$<?php echo number_format($producto['precio'] * $producto['cantidad'], 2); ?></td>
                </tr>
            <?php endforeach; ?>
        </table>
        <h3>Total: $<?php echo number_format($total, 2); ?></h3>
        <a href="procesar_compra.php">Proceder a la compra</a>
    </div>
</body>
</html>
