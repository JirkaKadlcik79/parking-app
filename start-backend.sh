#!/bin/bash
# Script pro spuštění backendu

echo "🚀 Spouštím Parking App Backend..."
echo ""

cd "$(dirname "$0")/backend"

# Kontrola Node.js
if ! command -v node &> /dev/null; then
    echo "❌ Node.js není nainstalován!"
    echo "Stáhni z: https://nodejs.org/"
    exit 1
fi

echo "✅ Node.js: $(node --version)"
echo "✅ npm: $(npm --version)"
echo ""

# Kontrola node_modules
if [ ! -d "node_modules" ]; then
    echo "📦 Instaluji dependencies..."
    npm install
    echo ""
fi

echo "🏃 Spouštím server..."
echo "📍 Backend: http://localhost:3000"
echo "📡 API: http://localhost:3000/api"
echo ""
echo "⏹️  Pro zastavení stiskni Ctrl+C"
echo ""

npm start
