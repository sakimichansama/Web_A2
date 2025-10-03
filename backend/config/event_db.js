const mysql = require('mysql2/promise');

// Create a database connection pool
const pool = mysql.createPool({
  host: 'localhost',
  user: 'root',         // MySQL username
  password: '143578901Ww', // MySQL password
  database: 'charityevents_db',
  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0
});

module.exports = pool;