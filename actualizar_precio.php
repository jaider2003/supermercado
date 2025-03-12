<?php
require "db.php";
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Actualizar Precio</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container mt-5">

    <h2 class="mb-4">Actualizar Precio del Producto</h2>

    <form method="post">
        <div class="mb-3">
            <label for="id_producto" class="form-label">ID del Producto:</label>
            <input type="number" class="form-control" name="id_producto" required>
        </div>
        <div class="mb-3">
            <label for="nuevo_precio" class="form-label">Nuevo Precio:</label>
            <input type="text" class="form-control" name="nuevo_precio" required>
        </div>
        <button type="submit" class="btn btn-primary">Actualizar</button>
    </form>

    <?php
    if ($_SERVER["REQUEST_METHOD"] == "POST") {
        $id_producto = $_POST["id_producto"];
        $nuevo_precio = $_POST["nuevo_precio"];

        try {
            $stmt = $conexion->prepare("CALL ActualizarPrecioProducto(:id, :precio)");
            $stmt->bindParam(":id", $id_producto, PDO::PARAM_INT);
            $stmt->bindParam(":precio", $nuevo_precio);
            $stmt->execute();
            echo "<div class='alert alert-success mt-3'>Precio actualizado correctamente.</div>";
        } catch (PDOException $e) {
            echo "<div class='alert alert-danger mt-3'>Error: " . $e->getMessage() . "</div>";
        }
    }
    ?>

</body>
</html>
