@echo off
REM Windows batch script pro spuštění celé aplikace

echo ========================================
echo    Parking App - Startup
echo ========================================
echo.

REM Kontrola Node.js
where node >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo [X] Node.js neni nainstalovany!
    echo     Stahni z: https://nodejs.org/
    pause
    exit /b 1
)

echo [OK] Node.js:
node --version
echo [OK] npm:
npm --version
echo.

REM Přejít do složky backendu
cd backend

REM Kontrola node_modules
if not exist "node_modules\" (
    echo [*] Instaluji dependencies...
    call npm install
    echo.
)

echo [*] Spoustim backend server...
echo     Backend: http://localhost:3000
echo     API: http://localhost:3000/api
echo.

REM Spustit backend na pozadí
start "Parking App Backend" cmd /k "npm start"

REM Počkat 2 sekundy na start backendu
timeout /t 2 /nobreak >nul

echo [*] Spoustim frontend...
echo     Frontend: http://localhost:8080
echo.

REM Přejít do frontendu
cd ..\frontend

REM Zkusit npx http-server
where npx >nul 2>nul
if %ERRORLEVEL% EQU 0 (
    start "Parking App Frontend" cmd /k "npx http-server -p 8080 -o"
) else (
    REM Fallback - otevřít přímo soubor
    start "" "index.html"
)

echo.
echo ========================================
echo    Aplikace spustena!
echo ========================================
echo.
echo Backend: http://localhost:3000
echo Frontend: http://localhost:8080
echo.
echo Pro zastaveni zavri obe okna konzole.
echo.
pause
