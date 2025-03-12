<?php
require "db.php";
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Eliminar Producto</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container mt-5">

    <h2 class="mb-4">Eliminar Producto</h2>

    <form method="post">
        <div class="mb-3">
            <label for="id_producto" class="form-label">ID del Producto:</label>
            <input type="number" class="form-control" name="id_producto" required>
        </div>
        <button type="submit" class="btn btn-danger">Eliminar</button>
    </form>

    <?php
    if ($_SERVER["REQUEST_METHOD"] == "POST") {
        $id_producto = $_POST["id_producto"];

        try {
            $stmt = $conexion->prepare("CALL EliminarProducto(:id)");
            $stmt->bindParam(":id", $id_producto, PDO::PARAM_INT);
            $stmt->execute();
            echo "<div class='alert alert-success mt-3'>Producto eliminado correctamente.</div>";
        } catch (PDOException $e) {
            echo "<div class='alert alert-danger mt-3'>Error: " . $e->getMessage() . "</div>";
        }
    }
    ?>

</body>
</html>
