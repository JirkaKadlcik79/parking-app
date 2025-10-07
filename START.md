# 🚀 Návod ke zprovoznění Parking App

## Rychlý start (3 kroky)

### Krok 1: Nainstaluj backend dependencies
```bash
cd /mnt/c/Users/kadlcik/parking-app/backend
npm install
```

### Krok 2: Spusť backend server
```bash
npm start
```
✅ Server poběží na `http://localhost:3000`

### Krok 3: Otevři frontend
```bash
# Otevři soubor v prohlížeči:
/mnt/c/Users/kadlcik/parking-app/frontend/index.html

# Nebo spusť jednoduchý HTTP server:
cd /mnt/c/Users/kadlcik/parking-app/frontend
npx http-server -p 8080
```
✅ Aplikace běží na `http://localhost:8080`

---

## 🎯 Rychlé spuštění pomocí skriptů

### Windows (PowerShell):
```powershell
# Spustí backend i frontend najednou
.\start-app.bat
```

### Linux/Mac/WSL:
```bash
# Spustí backend
./start-backend.sh

# V druhém terminálu spustí frontend
./start-frontend.sh
```

---

## 📋 Detailní postup

### 1. Kontrola požadavků
```bash
# Zkontroluj Node.js (musí být 16+)
node --version

# Zkontroluj npm
npm --version
```

Pokud nemáš Node.js: https://nodejs.org/

### 2. Instalace backendu
```bash
cd /mnt/c/Users/kadlcik/parking-app/backend
npm install
```

**Co se stane:**
- Nainstalují se: `express`, `cors`, `better-sqlite3`
- Vytvoří se složka `node_modules/`

### 3. Spuštění backendu
```bash
npm start
```

**Výstup by měl být:**
```
🚀 Server běží na http://localhost:3000
📡 API je dostupné na http://localhost:3000/api
```

**Test API:**
```bash
# Zkontroluj, že API funguje:
curl http://localhost:3000/api/spots
```

### 4. Spuštění frontendu

**Varianta A: Přímé otevření souboru**
```bash
# Windows
start /mnt/c/Users/kadlcik/parking-app/frontend/index.html

# Linux/WSL
xdg-open /mnt/c/Users/kadlcik/parking-app/frontend/index.html
```

**Varianta B: HTTP Server (doporučeno)**
```bash
cd /mnt/c/Users/kadlcik/parking-app/frontend
npx http-server -p 8080 -o
```

Otevře se automaticky `http://localhost:8080`

---

## 🧪 První test aplikace

1. **Otevři aplikaci v prohlížeči**
   - URL: `http://localhost:8080` nebo `file:///mnt/c/Users/kadlcik/parking-app/frontend/index.html`

2. **Přihlaš se:**
   - Jméno: `Test Uživatel`
   - Typ: `Nemám parkovací místo`
   - Klikni "Přihlásit se"

3. **Zkontroluj:**
   - ✅ Vidíš grid s parkovacími místy
   - ✅ Zelená místa jsou k rezervaci
   - ✅ Vidíš ikony 💰 (platba) nebo 🎁 (pozornost)

4. **Otestuj rezervaci:**
   - Klikni na zelené místo
   - Klikni "Rezervovat místo"
   - Místo by mělo zčervenat

---

## 🛠️ Řešení problémů

### Backend se nespustí
**Chyba: "Cannot find module 'express'"**
```bash
cd backend
npm install
```

**Chyba: "Port 3000 is already in use"**
```bash
# Najdi proces na portu 3000
netstat -ano | findstr :3000

# Zastav proces (Windows)
taskkill /PID <PID> /F

# Nebo změň port v backend/server.js na řádku 6:
const PORT = 3001;
```

### Frontend se nepřipojí k backendu
**Chyba v konzoli: "Failed to fetch"**

1. Zkontroluj, že backend běží:
   ```bash
   curl http://localhost:3000/api/spots
   ```

2. Zkontroluj URL v `frontend/index.html` na řádku 815:
   ```javascript
   const API_URL = 'http://localhost:3000/api';
   ```

### Databáze je prázdná
Backend automaticky vytvoří testovací data při prvním spuštění.

Pokud chceš reset:
```bash
# Smaž databázi
rm backend/parking.db

# Restartuj backend - vytvoří se nová databáze s dummy daty
npm start
```

---

## 📝 Testovací účty

### Držitelé míst (Mám parkovací místo):
- **Jiří Kadlčík** → Místo 55
- **Dalibor Podstuvka** → Místo 45
- **Patrik Szewczyk** → Místo 60

### Hosté (Nemám parkovací místo):
- Jakékoliv jméno

---

## 🎨 Co dál?

- 📧 Přidat email notifikace
- 👤 Autentizace uživatelů
- 💳 Integrace plateb
- 📊 Statistiky využití
- 📱 Mobilní verze

---

**💡 Tip:** Nech backend běžet v jednom terminálu a pracuj v druhém!
