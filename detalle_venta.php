<?php
require "db.php";
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Detalle de Venta</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container mt-5">

    <h2 class="mb-4">Obtener Detalle de Venta</h2>

    <form method="post">
        <div class="mb-3">
            <label for="id_venta" class="form-label">ID de la Venta:</label>
            <input type="number" class="form-control" name="id_venta" required>
        </div>
        <button type="submit" class="btn btn-primary">Obtener Detalle</button>
    </form>

    <?php
    if ($_SERVER["REQUEST_METHOD"] == "POST") {
        $id_venta = $_POST["id_venta"];

        try {
            $stmt = $conexion->prepare("CALL ObtenerDetalleVenta(:id)");
            $stmt->bindParam(":id", $id_venta, PDO::PARAM_INT);
            $stmt->execute();
            $resultado = $stmt->fetch(PDO::FETCH_ASSOC);

            if ($resultado) {
                echo "<div class='alert alert-info mt-3'><strong>Detalles de la Venta:</strong><br>";
                foreach ($resultado as $key => $value) {
                    echo ucfirst($key) . ": " . $value . "<br>";
                }
                echo "</div>";
            } else {
                echo "<div class='alert alert-warning mt-3'>No se encontró la venta.</div>";
            }
        } catch (PDOException $e) {
            echo "<div class='alert alert-danger mt-3'>Error: " . $e->getMessage() . "</div>";
        }
    }
    ?>

</body>
</html>
