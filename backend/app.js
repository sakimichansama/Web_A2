const express = require('express');
const cors = require('cors');
const eventsRouter = require('./routes/events');
const categoriesRouter = require('./routes/categories');

const app = express();

// Middleware
app.use(cors());
app.use(express.json());

// routing
app.use('/api/events', eventsRouter);
app.use('/api/categories', categoriesRouter);

// root route
app.get('/', (req, res) => {
  res.json({ message: 'Charity Events API is running' });
});

// Error Handling Middleware
app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(500).json({ error: 'Something went wrong!' });
});

module.exports = app;
