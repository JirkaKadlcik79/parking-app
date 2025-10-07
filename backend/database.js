const Database = require('better-sqlite3');
const db = new Database('parking.db');

// Vytvoření tabulek
db.exec(`
  CREATE TABLE IF NOT EXISTS users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    role TEXT CHECK(role IN ('owner', 'guest')) NOT NULL,
    parking_spot_id INTEGER
  );

  CREATE TABLE IF NOT EXISTS parking_spots (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    number TEXT UNIQUE NOT NULL,
    owner_name TEXT NOT NULL,
    owner_email TEXT,
    is_electric BOOLEAN DEFAULT 0,
    is_management BOOLEAN DEFAULT 0,
    grid_row INTEGER NOT NULL,
    grid_col INTEGER NOT NULL
  );

  CREATE TABLE IF NOT EXISTS offers (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    spot_id INTEGER NOT NULL,
    user_id INTEGER,
    date_from TEXT NOT NULL,
    date_to TEXT NOT NULL,
    offer_type TEXT CHECK(offer_type IN ('paid', 'favor')),
    offer_note TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (spot_id) REFERENCES parking_spots(id)
  );

  CREATE TABLE IF NOT EXISTS reservations (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    offer_id INTEGER NOT NULL,
    spot_id INTEGER NOT NULL,
    user_id INTEGER,
    reserved_by_name TEXT NOT NULL,
    reserved_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (offer_id) REFERENCES offers(id),
    FOREIGN KEY (spot_id) REFERENCES parking_spots(id)
  );
`);

console.log('✅ Databáze inicializována');

module.exports = db;
