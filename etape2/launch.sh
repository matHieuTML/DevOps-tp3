#!/bin/bash

# Nettoyage des anciens containers (si existants)
echo "🧹 Nettoyage des anciens containers..."
docker container stop http script data 2>/dev/null
docker container rm http script data 2>/dev/null
docker network rm tp3-network-etape2 2>/dev/null

# Création du réseau commun
docker network create tp3-network-etape2

# Construction de l'image PHP personnalisée avec mysqli
docker build -t php-mysqli .

# Lancement du container MariaDB (DATA)
docker container run -d \
  --name data \
  --network tp3-network-etape2 \
  -e MARIADB_RANDOM_ROOT_PASSWORD=yes \
  -v "$(pwd)/create.sql:/docker-entrypoint-initdb.d/create.sql" \
  mariadb

# Attendre que MariaDB soit prêt
echo "⏳ Attente du démarrage de MariaDB..."
sleep 15

# Lancement du container PHP-FPM (SCRIPT)
docker container run -d \
  --name script \
  --network tp3-network-etape2 \
  -v "$(pwd)/index.php:/app/index.php" \
  -v "$(pwd)/test.php:/app/test.php" \
  php-mysqli

# Lancement du container NGINX (HTTP)
docker container run -d \
  --name http \
  --network tp3-network-etape2 \
  -p 8080:80 \
  -v "$(pwd)/index.php:/app/index.php" \
  -v "$(pwd)/test.php:/app/test.php" \
  -v "$(pwd)/default.conf:/etc/nginx/conf.d/default.conf" \
  nginx

echo ""
echo "✓ Containers lancés avec succès"
echo "✓ Accédez à http://localhost:8080/ pour voir phpinfo()"
echo "✓ Accédez à http://localhost:8080/test.php pour tester la base de données"
