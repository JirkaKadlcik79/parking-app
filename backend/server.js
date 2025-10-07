const express = require('express');
const cors = require('cors');
const db = require('./database');

const app = express();
const PORT = 3000;

// Middleware
app.use(cors());
app.use(express.json());

// ============= API ENDPOINTS =============

// Získat všechna parkovací místa
app.get('/api/spots', (req, res) => {
  try {
    const spots = db.prepare(`
      SELECT
        ps.*,
        o.id as offer_id,
        o.date_from,
        o.date_to,
        o.offer_type,
        o.offer_note,
        r.reserved_by_name
      FROM parking_spots ps
      LEFT JOIN offers o ON ps.id = o.spot_id
        AND date('now') BETWEEN date(o.date_from) AND date(o.date_to)
      LEFT JOIN reservations r ON o.id = r.offer_id
      ORDER BY ps.id
    `).all();

    res.json(spots);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Přidat novou nabídku místa
app.post('/api/offers', (req, res) => {
  try {
    const { spot_id, user_id, date_from, date_to, offer_type, offer_note } = req.body;

    const result = db.prepare(`
      INSERT INTO offers (spot_id, user_id, date_from, date_to, offer_type, offer_note)
      VALUES (?, ?, ?, ?, ?, ?)
    `).run(spot_id, user_id, date_from, date_to, offer_type, offer_note);

    res.json({ success: true, offer_id: result.lastInsertRowid });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Zrušit nabídku
app.delete('/api/offers/:id', (req, res) => {
  try {
    // Nejdřív smazat rezervace
    db.prepare('DELETE FROM reservations WHERE offer_id = ?').run(req.params.id);
    // Pak smazat nabídku
    db.prepare('DELETE FROM offers WHERE id = ?').run(req.params.id);

    res.json({ success: true });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Rezervovat místo
app.post('/api/reservations', (req, res) => {
  try {
    const { offer_id, spot_id, user_id, reserved_by_name } = req.body;

    const result = db.prepare(`
      INSERT INTO reservations (offer_id, spot_id, user_id, reserved_by_name)
      VALUES (?, ?, ?, ?)
    `).run(offer_id, spot_id, user_id, reserved_by_name);

    res.json({ success: true, reservation_id: result.lastInsertRowid });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Zrušit rezervaci
app.delete('/api/reservations/:offer_id', (req, res) => {
  try {
    db.prepare('DELETE FROM reservations WHERE offer_id = ?').run(req.params.offer_id);
    res.json({ success: true });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Inicializovat testovací data (volat pouze jednou)
app.post('/api/init-data', (req, res) => {
  try {
    const { spots, offers } = req.body;

    // Smazat existující data
    db.prepare('DELETE FROM reservations').run();
    db.prepare('DELETE FROM offers').run();
    db.prepare('DELETE FROM parking_spots').run();

    // Vložit místa
    const insertSpot = db.prepare(`
      INSERT INTO parking_spots
      (number, owner_name, owner_email, is_electric, is_management, grid_row, grid_col)
      VALUES (?, ?, ?, ?, ?, ?, ?)
    `);

    spots.forEach(spot => {
      insertSpot.run(
        spot.number,
        spot.owner,
        spot.ownerEmail,
        spot.isElectric ? 1 : 0,
        spot.isManagement ? 1 : 0,
        spot.gridRow,
        spot.gridCol
      );
    });

    // Vložit ukázkové nabídky (pokud jsou poskytnuty)
    if (offers && offers.length > 0) {
      const insertOffer = db.prepare(`
        INSERT INTO offers (spot_id, user_id, date_from, date_to, offer_type, offer_note)
        VALUES (?, ?, ?, ?, ?, ?)
      `);

      offers.forEach(offer => {
        insertOffer.run(
          offer.spot_id,
          offer.user_id || null,
          offer.date_from,
          offer.date_to,
          offer.offer_type,
          offer.offer_note || null
        );
      });
    }

    res.json({ success: true, message: 'Data inicializována' });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Spustit server
app.listen(PORT, () => {
  console.log(`🚀 Server běží na http://localhost:${PORT}`);
  console.log(`📡 API je dostupné na http://localhost:${PORT}/api`);
});
