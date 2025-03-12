<?php
session_start();
include 'db.php';

$id_usuario = $_SESSION['usuario_id'];

// Obtener las compras realizadas por el usuario
$stmt = $conexion->prepare("SELECT * FROM compras WHERE id_usuario = ?");
$stmt->execute([$id_usuario]);
$compras = $stmt->fetchAll();
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mis Compras</title>
    <link rel="stylesheet" href="estilos.css">
</head>
<body>
    <div class="container">
        <h1>Mis Compras</h1>
        <table>
            <tr>
                <th>ID Compra</th>
                <th>Total</th>
                <th>Fecha</th>
            </tr>
            <?php foreach ($compras as $compra): ?>
                <tr>
                    <td><?php echo $compra['id']; ?></td>
                    <td>$<?php echo number_format($compra['total'], 2); ?></td>
                    <td><?php echo $compra['fecha']; ?></td>
                </tr>
            <?php endforeach; ?>
        </table>
    </div>
</body>
</html>
