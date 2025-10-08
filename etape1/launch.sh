
docker network create tp3-network

docker container run -d \
  --name script \
  --network tp3-network \
  -v "$(pwd)/index.php:/app/index.php" \
  php:fpm

docker container run -d \
  --name http \
  --network tp3-network \
  -p 8080:80 \
  -v "$(pwd)/index.php:/app/index.php" \
  -v "$(pwd)/default.conf:/etc/nginx/conf.d/default.conf" \
  nginx


echo "Accédez : http://localhost:8080/ pour voir phpinfo()"
