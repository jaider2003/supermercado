<?php
require "db.php";
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Clientes Frecuentes</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container mt-5">

    <h2 class="mb-4">Clientes Frecuentes</h2>

    <form method="post">
        <button type="submit" class="btn btn-primary">Mostrar Clientes</button>
    </form>

    <?php
    if ($_SERVER["REQUEST_METHOD"] == "POST") {
        try {
            $stmt = $conexion->prepare("CALL ClientesFrecuentes()");
            $stmt->execute();
            $resultados = $stmt->fetchAll(PDO::FETCH_ASSOC);

            if ($resultados) {
                echo "<table class='table table-striped mt-3'><thead><tr><th>ID Cliente</th><th>Compras Realizadas</th></tr></thead><tbody>";
                foreach ($resultados as $fila) {
                    echo "<tr><td>" . $fila['id_cliente'] . "</td><td>" . $fila['compras_realizadas'] . "</td></tr>";
                }
                echo "</tbody></table>";
            } else {
                echo "<div class='alert alert-warning mt-3'>No hay clientes frecuentes.</div>";
            }
        } catch (PDOException $e) {
            echo "<div class='alert alert-danger mt-3'>Error: " . $e->getMessage() . "</div>";
        }
    }
    ?>

</body>
</html>
