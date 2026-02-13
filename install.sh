#!/bin/bash

# 1. Instalar Docker de la forma más rápida (oficial)
curl -fsSL https://get.docker.com | sh
sudo usermod -aG docker $USER

# 2. Crear carpeta y configuración mínima
mkdir -p ~/portracker && cd ~/portracker
cat <<EOF > config.yaml
targets:
  - 127.0.0.1
notifications:
  telegram:
    enabled: false
EOF

# 3. Lanzar Portracker (Descarga, crea y arranca todo a la vez)
sudo docker run -d \
  --name portracker \
  --restart always \
  -v $(pwd)/config.yaml:/app/config.yaml \
  mostafawahied/portracker:latest

echo "---"
echo "✅ Docker instalado y Portracker en marcha."
echo "Configuración en: ~/portracker/config.yaml"
echo "Logs: sudo docker logs -f portracker"
