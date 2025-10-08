<!DOCTYPE html>
<html>
<head>
    <title>Test Base de Données</title>
</head>
<body>
    <h1>Test de connexion à la base de données</h1>

<?php
// Connexion à la base de données
$mysqli = new mysqli("data", "user", "password", "testdb");

// Vérifier la connexion
if ($mysqli->connect_error) {
    die("Échec de la connexion : " . $mysqli->connect_error);
}

// Requête d'écriture (INSERT)
$sql_insert = "INSERT INTO compteur (valeur) VALUES (1) ON DUPLICATE KEY UPDATE valeur = valeur + 1";
if ($mysqli->query($sql_insert) === TRUE) {
    echo "<p>✓ Écriture réussie</p>";
} else {
    echo "<p>✗ Erreur lors de l'écriture : " . $mysqli->error . "</p>";
}

// Requête de lecture (SELECT)
$sql_select = "SELECT valeur FROM compteur WHERE id = 1";
$result = $mysqli->query($sql_select);

if ($result->num_rows > 0) {
    $row = $result->fetch_assoc();
    echo "<p>✓ Lecture réussie</p>";
    echo "<h2>Compteur : " . $row["valeur"] . "</h2>";
} else {
    echo "<p>✗ Aucun résultat</p>";
}

$mysqli->close();
?>

</body>
</html>
