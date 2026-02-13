#!/bin/bash

echo "🚀 Levantando servicios de prueba..."

# 1. Abrir 3 puertos usando contenedores ultra-ligeros (Nginx Alpine)
docker run -d --name web-test-1 -p 8081:80 nginx:alpine
docker run -d --name web-test-2 -p 8082:80 nginx:alpine
docker run -d --name web-test-3 -p 8083:80 nginx:alpine

echo "✅ Puertos 8081, 8082 y 8083 abiertos."

# 2. Re-lanzar Portracker con --network host para que vea la máquina real
echo "🔄 Reconfigurando Portracker para escaneo local eficiente..."
docker stop portracker && docker rm portracker

docker run -d \
  --name portracker \
  --restart always \
  --network host \
  -v ~/portracker/config.yaml:/app/config.yaml \
  mostafawahied/portracker:latest

echo "---"
echo "🔍 Portracker está escaneando ahora mismo la red del host."
echo "Puedes ver si detectó los nuevos puertos con: docker logs portracker"
