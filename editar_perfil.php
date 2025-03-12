<?php
session_start();

// Verifica si el usuario está logueado
if (!isset($_SESSION['usuario_id'])) {
    header("Location: login.php"); // Redirige al login si no está autenticado
    exit();
}

// Obtener la información del usuario de la base de datos
include 'db.php';
$usuario_id = $_SESSION['usuario_id'];
$stmt = $conexion->prepare("SELECT * FROM usuarios WHERE id = ?");
$stmt->execute([$usuario_id]);
$usuario = $stmt->fetch();

if (!$usuario) {
    // Si no se encuentra el usuario en la base de datos
    die("Usuario no encontrado");
}

// Procesar la actualización del perfil (si es necesario)
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $nombre = $_POST['nombre'];
    $correo = $_POST['correo'];

    // Aquí podrías validar y actualizar los datos en la base de datos
    $stmt = $conexion->prepare("UPDATE usuarios SET nombre = ?, correo = ? WHERE id = ?");
    $stmt->execute([$nombre, $correo, $usuario_id]);

    echo "Perfil actualizado con éxito.";
}

?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Editar Perfil</title>
    <link rel="stylesheet" href="estilos.css">
</head>
<body>
    <h1>Editar Perfil</h1>
    <form method="POST">
        <label for="nombre">Nombre:</label>
        <input type="text" name="nombre" value="<?= $usuario['nombre'] ?>" required>

        <label for="correo">Correo:</label>
        <input type="email" name="correo" value="<?= $usuario['correo'] ?>" required>

        <button type="submit">Actualizar</button>
    </form>
</body>
</html>
