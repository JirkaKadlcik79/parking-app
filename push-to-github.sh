#!/bin/bash

# Script pro nahrání projektu na GitHub
# Použití: ./push-to-github.sh

cd /mnt/c/Users/kadlcik/parking-app

echo "🔗 Připojuji k GitHub repository..."
git remote add origin https://github.com/JirkaKadlcik79/parking-app.git

echo "📤 Nahrávám kód na GitHub..."
git push -u origin main

echo ""
echo "✅ Hotovo! Tvůj projekt je na GitHubu:"
echo "   https://github.com/JirkaKadlcik79/parking-app"
