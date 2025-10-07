#!/bin/bash
# WSL/Linux script pro spuštění celé aplikace

echo "========================================"
echo "   Parking App - Startup"
echo "========================================"
echo ""

cd "$(dirname "$0")"

# Kontrola Node.js
if ! command -v node &> /dev/null; then
    echo "[X] Node.js neni nainstalovany!"
    echo "    Nainstaluj: curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash - && sudo apt-get install -y nodejs"
    exit 1
fi

echo "[OK] Node.js: $(node --version)"
echo "[OK] npm: $(npm --version)"
echo ""

# Backend
cd backend
if [ ! -d "node_modules" ]; then
    echo "[*] Instaluji dependencies..."
    npm install
    echo ""
fi

echo "[*] Spoustim backend server..."
echo "    Backend: http://localhost:3000"
echo "    API: http://localhost:3000/api"
echo ""

# Spustit backend na pozadí
npm start &
BACKEND_PID=$!

# Počkat na start
sleep 3

# Test backendu
if curl -s http://localhost:3000/api/spots > /dev/null 2>&1; then
    echo "[OK] Backend bezi!"
else
    echo "[X] Backend se nespustil!"
    kill $BACKEND_PID 2>/dev/null
    exit 1
fi

echo ""
echo "[*] Spoustim frontend..."
cd ../frontend

# Zkusit http-server, pak Python, pak přímo soubor
if command -v http-server &> /dev/null; then
    echo "    Frontend: http://localhost:8080"
    echo ""
    echo "========================================"
    echo "    Aplikace spustena!"
    echo "========================================"
    echo ""
    echo "Backend: http://localhost:3000"
    echo "Frontend: http://localhost:8080"
    echo ""
    echo "Pro zastaveni stiskni Ctrl+C"
    echo ""

    # Trap pro ukončení
    trap "echo ''; echo 'Zastavuji servery...'; kill $BACKEND_PID 2>/dev/null; exit 0" INT TERM

    npx http-server -p 8080 -o
elif command -v python3 &> /dev/null; then
    echo "    Frontend: http://localhost:8080"
    echo ""
    echo "========================================"
    echo "    Aplikace spustena!"
    echo "========================================"
    echo ""
    echo "Backend: http://localhost:3000"
    echo "Frontend: http://localhost:8080"
    echo ""
    echo "Pro zastaveni stiskni Ctrl+C"
    echo ""

    trap "echo ''; echo 'Zastavuji servery...'; kill $BACKEND_PID 2>/dev/null; exit 0" INT TERM

    python3 -m http.server 8080
else
    echo "[*] HTTP server nenalezen, otviram soubor..."
    FILE_PATH="file://$(pwd)/index.html"
    echo "    Otevri v prohlizeci: $FILE_PATH"
    echo ""
    echo "Backend PID: $BACKEND_PID"
    echo "Pro zastaveni backendu: kill $BACKEND_PID"
fi
