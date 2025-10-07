#!/bin/bash
# Script pro spuštění frontendu

echo "🎨 Spouštím Parking App Frontend..."
echo ""

cd "$(dirname "$0")/frontend"

# Kontrola, jestli backend běží
if ! curl -s http://localhost:3000/api/spots > /dev/null 2>&1; then
    echo "⚠️  VAROVÁNÍ: Backend neběží na http://localhost:3000"
    echo "   Nejdřív spusť backend pomocí: ./start-backend.sh"
    echo ""
    read -p "Pokračovat? (y/n) " -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
fi

# Zkusit najít http-server
if command -v http-server &> /dev/null; then
    echo "✅ Používám http-server"
    echo "📍 Frontend: http://localhost:8080"
    echo ""
    echo "⏹️  Pro zastavení stiskni Ctrl+C"
    echo ""
    http-server -p 8080 -o
elif command -v python3 &> /dev/null; then
    echo "✅ Používám Python HTTP server"
    echo "📍 Frontend: http://localhost:8080"
    echo ""
    echo "⏹️  Pro zastavení stiskni Ctrl+C"
    echo ""
    python3 -m http.server 8080
elif command -v python &> /dev/null; then
    echo "✅ Používám Python HTTP server"
    echo "📍 Frontend: http://localhost:8080"
    echo ""
    echo "⏹️  Pro zastavení stiskni Ctrl+C"
    echo ""
    python -m SimpleHTTPServer 8080
else
    echo "📂 Otevírám přímo soubor v prohlížeči..."
    echo ""
    FILE_PATH="$(pwd)/index.html"

    if command -v xdg-open &> /dev/null; then
        xdg-open "$FILE_PATH"
    elif command -v open &> /dev/null; then
        open "$FILE_PATH"
    elif command -v start &> /dev/null; then
        start "$FILE_PATH"
    else
        echo "✅ Otevři tento soubor v prohlížeči:"
        echo "   $FILE_PATH"
    fi
fi
