#!/bin/bash

echo "🚀 Lancement de l'application avec Docker Compose..."

# Arrêt et suppression des anciens containers si existants
docker-compose down

# Construction et lancement des services
docker-compose up -d

# Attendre que les services soient prêts
echo "⏳ Attente du démarrage des services..."
sleep 10

echo ""
echo "✓ Application lancée avec succès"
echo "✓ Accédez à http://localhost:8080/ pour voir phpinfo()"
echo "✓ Accédez à http://localhost:8080/test.php pour tester la base de données"
