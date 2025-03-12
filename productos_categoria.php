<?php
require "db.php";
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Productos por Categoría</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container mt-5">

    <h2 class="mb-4">Buscar Productos por Categoría</h2>

    <form method="post">
        <div class="mb-3">
            <label for="categoria" class="form-label">Categoría:</label>
            <input type="text" class="form-control" name="categoria" required>
        </div>
        <button type="submit" class="btn btn-primary">Buscar</button>
    </form>

    <?php
    if ($_SERVER["REQUEST_METHOD"] == "POST") {
        $categoria = $_POST["categoria"];

        try {
            $stmt = $conexion->prepare("CALL ProductosPorCategoria(:categoria)");
            $stmt->bindParam(":categoria", $categoria);
            $stmt->execute();
            $resultados = $stmt->fetchAll(PDO::FETCH_ASSOC);

            if ($resultados) {
                echo "<ul class='list-group mt-3'>";
                foreach ($resultados as $producto) {
                    echo "<li class='list-group-item'>" . $producto['nombre'] . " - $" . $producto['precio'] . "</li>";
                }
                echo "</ul>";
            } else {
                echo "<div class='alert alert-warning mt-3'>No hay productos en esta categoría.</div>";
            }
        } catch (PDOException $e) {
            echo "<div class='alert alert-danger mt-3'>Error: " . $e->getMessage() . "</div>";
        }
    }
    ?>

</body>
</html>
