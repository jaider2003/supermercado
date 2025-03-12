<?php
require "db.php";
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reporte de Ingresos</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container mt-5">

    <h2 class="mb-4">Reporte de Ingresos Mensuales</h2>

    <form method="post">
        <div class="mb-3">
            <label for="mes" class="form-label">Mes:</label>
            <input type="number" class="form-control" name="mes" min="1" max="12" required>
        </div>
        <div class="mb-3">
            <label for="anio" class="form-label">Año:</label>
            <input type="number" class="form-control" name="anio" required>
        </div>
        <button type="submit" class="btn btn-primary">Generar Reporte</button>
    </form>

    <?php
    if ($_SERVER["REQUEST_METHOD"] == "POST") {
        $mes = $_POST["mes"];
        $anio = $_POST["anio"];

        try {
            $stmt = $conexion->prepare("CALL ReporteIngresosMensuales(:mes, :anio)");
            $stmt->bindParam(":mes", $mes, PDO::PARAM_INT);
            $stmt->bindParam(":anio", $anio, PDO::PARAM_INT);
            $stmt->execute();
            $resultado = $stmt->fetch(PDO::FETCH_ASSOC);

            echo "<div class='alert alert-info mt-3'><strong>Ingresos Totales:</strong> $" . $resultado['ingresos_totales'] . "</div>";
        } catch (PDOException $e) {
            echo "<div class='alert alert-danger mt-3'>Error: " . $e->getMessage() . "</div>";
        }
    }
    ?>

</body>
</html>
