@echo off
REM Windows batch script ktery spusti aplikaci pres WSL

echo ========================================
echo    Parking App - Startup (WSL)
echo ========================================
echo.

REM Spustit WSL skript
wsl bash -c "cd /mnt/c/Users/kadlcik/parking-app && ./start-app.sh"

pause
