const express = require('express');

// const mountRoutes = require('./routes');

const app = express();
// mountRoutes(app);

const port = 3000;

app.get('/', (req, res) => {
  res.send('Hello World!');
});

app.listen(port, () => {
  console.log(`We are LIVE at http://localhost:${port}`);
});
