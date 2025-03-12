<?php
include 'conexion.php';

$ventas = [];

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $fecha_inicio = $_POST['fecha_inicio'];
    $fecha_fin = $_POST['fecha_fin'];

    try {
        $sql = "CALL ReporteVentasPorFecha(:fecha_inicio, :fecha_fin)";
        $stmt = $conexion->prepare($sql);
        $stmt->bindParam(':fecha_inicio', $fecha_inicio);
        $stmt->bindParam(':fecha_fin', $fecha_fin);
        $stmt->execute();
        $ventas = $stmt->fetchAll(PDO::FETCH_ASSOC);
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
    <title>Reporte de Ventas</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container mt-5">
    <h2 class="text-center">Reporte de Ventas</h2>

    <form method="post" class="card p-4 shadow-lg mb-4">
        <div class="row">
            <div class="col-md-5">
                <label class="form-label">Fecha Inicio:</label>
                <input type="date" name="fecha_inicio" class="form-control" required>
            </div>
            <div class="col-md-5">
                <label class="form-label">Fecha Fin:</label>
                <input type="date" name="fecha_fin" class="form-control" required>
            </div>
            <div class="col-md-2 d-flex align-items-end">
                <button type="submit" class="btn btn-primary w-100">Generar</button>
            </div>
        </div>
    </form>

    <?php if (!empty($ventas)) : ?>
        <table class="table table-striped table-hover">
            <thead class="table-dark">
                <tr>
                    <th>ID Venta</th>
                    <th>ID Cliente</th>
                    <th>ID Producto</th>
                    <th>Cantidad</th>
                    <th>Total</th>
                    <th>Fecha Venta</th>
                </tr>
            </thead>
            <tbody>
                <?php foreach ($ventas as $venta) : ?>
                    <tr>
                        <td><?= $venta['id_venta']; ?></td>
                        <td><?= $venta['id_cliente']; ?></td>
                        <td><?= $venta['id_producto']; ?></td>
                        <td><?= $venta['cantidad']; ?></td>
                        <td>$<?= number_format($venta['total'], 2); ?></td>
                        <td><?= $venta['fecha_venta']; ?></td>
                    </tr>
                <?php endforeach; ?>
            </tbody>
        </table>
    <?php elseif ($_SERVER["REQUEST_METHOD"] == "POST") : ?>
        <div class="alert alert-warning text-center">No se encontraron ventas en ese rango de fechas.</div>
    <?php endif; ?>
</body>
</html>
