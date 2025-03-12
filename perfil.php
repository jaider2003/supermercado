<?php
session_start();
include 'db.php';

$id_usuario = $_SESSION['usuario_id'];

// Obtener los datos del usuario
$stmt = $conexion->prepare("SELECT * FROM usuarios WHERE id = ?");
$stmt->execute([$id_usuario]);
$usuario = $stmt->fetch();
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Perfil de Usuario</title>
    <link rel="stylesheet" href="estilos.css">
</head>
<body>
    <div class="container">
        <h1>Perfil de Usuario</h1>
        <p>Nombre: <?php echo $usuario['nombre']; ?></p>
        <p>Correo: <?php echo $usuario['correo']; ?></p>
        <a href="editar_perfil.php">Editar perfil</a>
    </div>
</body>
</html>
