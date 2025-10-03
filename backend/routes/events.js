const express = require('express');
const router = express.Router();
const pool = require('../config/event_db.js');

// Get all current and upcoming events
router.get('/', async (req, res) => {
  try {
    // current time and date
    const now = new Date();
    const formattedNow = now.toISOString().slice(0, 19).replace('T', ' ');
    
    // Check upcoming and current events (excluding suspended ones). This step is filtering (important).
    const [rows] = await pool.query(`
      SELECT e.*, c.name as category_name, o.name as organization_name 
      FROM events e
      JOIN categories c ON e.category_id = c.id
      JOIN organizations o ON e.organization_id = o.id
      WHERE e.status != 'suspended'
      ORDER BY e.date ASC
    `);
    
    res.json(rows);
  } catch (err) {
    console.error('Error fetching events:', err);
    res.status(500).json({ error: 'Failed to fetch events' });
  }
});

// Ensure that in events.js, the search route precedes the parameter route,An error occurred. HTTP status code 304.
router.get('/search', async (req, res) => {
  try {
    const { date, location, category_id } = req.query;
    let query = `
      SELECT e.*, c.name as category_name, o.name as organization_name 
      FROM events e
      JOIN categories c ON e.category_id = c.id
      JOIN organizations o ON e.organization_id = o.id
      WHERE e.status != 'suspended'
    `;
    const params = [];
    
    // Add search criteria
    if (date) {
      query += ` AND DATE(e.date) = ?`;
      params.push(date);
    }
    
    if (location) {
      query += ` AND e.location LIKE ?`;
      params.push(`%${location}%`);
    }
    
    if (category_id) {
      query += ` AND e.category_id = ?`;
      params.push(category_id);
    }
    
    query += ` ORDER BY e.date ASC`;
    
    const [rows] = await pool.query(query, params);
    res.json(rows);
  } catch (err) {
    console.error('Error searching events:', err);
    res.status(500).json({ error: 'Failed to search events' });
  }
});

// Retrieve event details by ID
router.get('/:id', async (req, res) => {
  try {
    const eventId = req.params.id;
    
    const [rows] = await pool.query(`
      SELECT e.*, c.name as category_name, o.name as organization_name, o.mission as organization_mission
      FROM events e
      JOIN categories c ON e.category_id = c.id
      JOIN organizations o ON e.organization_id = o.id
      WHERE e.id = ?
    `, [eventId]);
    
    if (rows.length === 0) {
      return res.status(404).json({ error: 'Event not found' });
    }
    
    res.json(rows[0]);
  } catch (err) {
    console.error('Error fetching event details:', err);
    res.status(500).json({ error: 'Failed to fetch event details' });
  }
});

module.exports = router;