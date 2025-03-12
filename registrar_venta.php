<?php
include 'db.php';

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $id_cliente = $_POST['id_cliente'];
    $id_producto = $_POST['id_producto'];
    $cantidad = $_POST['cantidad'];
    $total = $_POST['total'];

    try {
        $sql = "CALL RegistrarVenta(:id_cliente, :id_producto, :cantidad, :total)";
        $stmt = $conexion->prepare($sql);
        $stmt->bindParam(':id_cliente', $id_cliente);
        $stmt->bindParam(':id_producto', $id_producto);
        $stmt->bindParam(':cantidad', $cantidad);
        $stmt->bindParam(':total', $total);
        $stmt->execute();
        $mensaje = "✅ Venta registrada correctamente.";
    } catch (PDOException $e) {
        $mensaje = "❌ Error: " . $e->getMessage();
    }
}
?>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registrar Venta</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container mt-5">
    <h2 class="text-center">Registrar Venta</h2>

    <?php if (isset($mensaje)) : ?>
        <div class="alert alert-info"><?= $mensaje; ?></div>
    <?php endif; ?>

    <form method="post" class="card p-4 shadow-lg">
        <div class="mb-3">
            <label class="form-label">ID Cliente:</label>
            <input type="number" name="id_cliente" class="form-control" required>
        </div>
        <div class="mb-3">
            <label class="form-label">ID Producto:</label>
            <input type="number" name="id_producto" class="form-control" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Cantidad:</label>
            <input type="number" name="cantidad" class="form-control" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Total:</label>
            <input type="number" step="0.01" name="total" class="form-control" required>
        </div>
        <button type="submit" class="btn btn-success w-100">Registrar Venta</button>
    </form>
</body>
</html>
