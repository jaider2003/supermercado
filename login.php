<?php
session_start(); // Iniciar la sesión

// Verifica si ya hay un usuario logueado, en cuyo caso lo redirige al index
if (isset($_SESSION['usuario_id'])) {
    header("Location: index.php");
    exit();
}

// Conectar a la base de datos
include 'db.php';

// Verifica si el formulario ha sido enviado
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    // Recoge los valores del formulario
    $correo = $_POST['correo'];
    $contrasena = $_POST['contrasena'];

    // Consulta para buscar el usuario por correo
    $stmt = $conexion->prepare("SELECT id, contrasena FROM usuarios WHERE correo = ?");
    $stmt->execute([$correo]);
    $usuario = $stmt->fetch();

    // Verifica si el usuario existe y si la contraseña es correcta
    if ($usuario && password_verify($contrasena, $usuario['contrasena'])) {
        // Establece la sesión del usuario
        $_SESSION['usuario_id'] = $usuario['id'];
        $_SESSION['usuario_correo'] = $correo;

        // Redirige al usuario a la página principal (index.php)
        header("Location: index.php");
        exit();
    } else {
        // Si el usuario no existe o la contraseña es incorrecta
        $error = "Correo o contraseña incorrectos.";
    }
}
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Iniciar sesión</title>
    <link rel="stylesheet" href="estilos.css">
</head>
<body>
    <div class="login-container">
        <h2>Iniciar sesión</h2>
        <form method="POST" action="login.php">
            <label for="correo">Correo electrónico:</label>
            <input type="email" name="correo" id="correo" required>

            <label for="contrasena">Contraseña:</label>
            <input type="password" name="contrasena" id="contrasena" required>

            <button type="submit">Iniciar sesión</button>
        </form>

        <?php if (isset($error)): ?>
            <p class="error"><?= $error; ?></p>
        <?php endif; ?>
        
        <p>¿No tienes cuenta? <a href="registro.php">Regístrate aquí</a></p>
    </div>
</body>
</html>
