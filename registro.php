<?php
include 'db.php';

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $nombre = $_POST['nombre'];
    $correo = $_POST['correo'];
    $contrasena = $_POST['contrasena'];
    $confirmar_contrasena = $_POST['confirmar_contrasena'];

    // Validar si las contraseñas coinciden
    if ($contrasena == $confirmar_contrasena) {
        $contrasena_hash = password_hash($contrasena, PASSWORD_DEFAULT);

        // Insertar usuario en la base de datos
        $stmt = $conexion->prepare("INSERT INTO usuarios (nombre, correo, contrasena) VALUES (?, ?, ?)");
        $stmt->execute([$nombre, $correo, $contrasena_hash]);

        echo "Registro exitoso, puedes <a href='login.html'>iniciar sesión</a>.";
    } else {
        echo "Las contraseñas no coinciden.";
    }
}
?>
