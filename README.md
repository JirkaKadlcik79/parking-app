# 🚗 Parking Reservation System

Rezervační systém pro parkovací místa v kancelářské budově. Umožňuje zaměstnancům s vlastním parkovacím místem nabízet své místo k dispozici kolegům během své nepřítomnosti, a to buď za symbolickou úplatu nebo za "pozornost" (např. domácí bábovka).

## 📋 Funkce

### Pro držitele parkovacích míst
- ✅ Nabídnutí místa k rezervaci na vybraný časový interval
- 💰 Možnost nabídky za úplatu (25 Kč/den)
- 🎁 Možnost nabídky za pozornost (např. káva, koláč)
- 🔄 Zrušení nabídky kdykoliv

### Pro zaměstnance bez parkovacího místa
- 🔍 Přehled volných parkovacích míst
- 📅 Informace o dostupnosti jednotlivých míst
- ⚡ Rychlá rezervace volného místa
- 📧 Kontakt na majitele místa (email, MS Teams)
- ❌ Možnost zrušení vlastní rezervace

### Obecné funkce
- 🗺️ Vizualizace parkoviště s rozložením míst
- 🎨 Barevné rozlišení stavů (volné, obsazené, rezervované)
- ⚡ Označení míst pro elektromobily
- 🏢 Označení míst pro správu budovy

## 🏗️ Struktura projektu

```
parking-app/
├── backend/              # Node.js backend server
│   ├── server.js        # Express server s REST API
│   ├── database.js      # SQLite databáze
│   └── package.json     # Dependencies
│
├── frontend/            # Frontend aplikace
│   └── index.html      # Single-page aplikace (HTML + CSS + JS)
│
├── .gitignore
└── README.md
```

## 🚀 Instalace a spuštění

### Požadavky
- Node.js (verze 16 nebo vyšší)
- npm

### Backend

1. Přejděte do složky backend:
```bash
cd backend
```

2. Nainstalujte dependencies:
```bash
npm install
```

3. Spusťte server:
```bash
npm start
```

Server poběží na `http://localhost:3000`

### Frontend

1. Otevřete soubor `frontend/index.html` v prohlížeči
2. Nebo použijte jednoduchý HTTP server:
```bash
cd frontend
npx http-server -p 8080
```

Frontend bude dostupný na `http://localhost:8080`

## 🔧 Technologie

### Backend
- **Express.js** - Web framework
- **Better-SQLite3** - SQLite databáze
- **CORS** - Cross-origin resource sharing

### Frontend
- **Vanilla JavaScript** - Žádné frameworky
- **CSS Grid** - Responzivní layout parkoviště
- **Fetch API** - Komunikace s backendem

### Databázové schéma

#### Tabulka: parking_spots
- `id` - Primární klíč
- `number` - Číslo parkovacího místa
- `owner_name` - Jméno majitele
- `owner_email` - Email majitele
- `is_electric` - Je místo pro elektromobily (0/1)
- `is_management` - Je místo pro správu (0/1)
- `grid_row` - Pozice v gridu (řádek)
- `grid_col` - Pozice v gridu (sloupec)

#### Tabulka: offers
- `id` - Primární klíč
- `spot_id` - Reference na parking_spots
- `user_id` - ID uživatele (majitele)
- `date_from` - Dostupné od
- `date_to` - Dostupné do
- `offer_type` - Typ nabídky ('paid' / 'favor')
- `offer_note` - Poznámka (pro favor)

#### Tabulka: reservations
- `id` - Primární klíč
- `offer_id` - Reference na offers
- `spot_id` - Reference na parking_spots
- `user_id` - ID rezervujícího uživatele
- `reserved_by_name` - Jméno rezervujícího

## 📡 REST API

### Endpoints

#### `GET /api/spots`
Získá seznam všech parkovacích míst s aktuálními nabídkami a rezervacemi.

#### `POST /api/offers`
Vytvoří novou nabídku parkovacího místa.
```json
{
  "spot_id": 1,
  "user_id": 123,
  "date_from": "2025-10-01",
  "date_to": "2025-10-10",
  "offer_type": "paid",
  "offer_note": null
}
```

#### `DELETE /api/offers/:id`
Zruší nabídku (včetně všech rezervací).

#### `POST /api/reservations`
Vytvoří rezervaci místa.
```json
{
  "offer_id": 5,
  "spot_id": 1,
  "user_id": 456,
  "reserved_by_name": "Jan Novák"
}
```

#### `DELETE /api/reservations/:offer_id`
Zruší rezervaci.

#### `POST /api/init-data`
Inicializuje databázi s testovacími daty (pouze pro vývoj).

## 🎨 Barevné schéma

- 🟢 **Zelená** - Volné místo k rezervaci
- 🔴 **Červená** - Rezervované místo
- 🔵 **Modrá** - Moje místo (pro držitele)
- ⚪ **Šedá** - Dlouhodobě obsazené
- 🟣 **Fialová** - Místo pro elektromobily
- ⚫ **Tmavě šedá** - Správa budovy

## 👥 Testovací data

Po prvním spuštění se databáze automaticky naplní testovacími daty:
- 57 parkovacích míst (čísla 22-67)
- Dummy držitelé míst
- 5 ukázkových nabídek
- Reální držitelé: Dalibor Podstuvka (45), Jiří Kadlčík (55), Patrik Szewczyk (60)

## 🛠️ Další vývoj

Možná vylepšení:
- [ ] Autentizace uživatelů
- [ ] Email notifikace
- [ ] Správa plateb
- [ ] Statistiky využití
- [ ] Mobilní aplikace
- [ ] Export do kalendáře
- [ ] Historie rezervací

## 📝 Licence

Tento projekt je vytvořen pro interní použití v Atlas Group.

## 👨‍💻 Autor

Vytvořeno s pomocí Claude Code
