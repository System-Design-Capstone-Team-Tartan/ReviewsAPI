const express = require('express');
const pool = require('./db');

const app = express();
const port = 3000;

app.listen(port, () => {
  console.log(`Server Running at: http://localhost:${port}`);
});

app.get('/', (req, res) => {
  res.send('Test Index');
});

// Model for getting ALL reviews for a product_id
const getAllReviews = async (id, page, count) => {
  try {
    const endIndex = (page + 1) * count;
    const startIndex = endIndex - count;
    const data = await pool.query(`SELECT * FROM review
      WHERE product_id = ${id}
      [ LIMIT { ${count} | ALL } ] [ OFFSET ${startIndex}]`);
    return data; // return data
  } catch (err) {
    return err;
  }
};

app.get('/reviews/', async (req, res) => { // async says this callback function has an await
  // page, count, sort, product_id
  try { // try this first - attempt the await function
    const id = req.query.product_id || -1;
    if (id === -1) {
      res.send('Bad Request');
    }
    const page = req.query.page || 0;
    const count = req.query.count || 5;
    // const sort = req.query.sort
    const data = await getAllReviews(id, page, count); // call the getAllReviews async function
    // do not continue until AFTER the await above
    res.send('Review Get Request', data); // return the data (if we got it)
  } catch (err) { // if something goes wrong with the await process
    res.send('Error', err); // return error
  }
});

app.get('/reviews/meta', (req, res) => {
  // product_id
  res.send('Review Meta Get Request');
});

app.post('/reviews', (req, res) => {
  // product_id, rating, summary, body, recommend, name, email, photos, characteristics
  // integer,    int,    text,    text,  bool,    text,  text,  [text], object
  res.send('Review Post Request');
});

app.put('/reviews/:review_id/helpful', (req, res) => {
  // review_id
  res.send('Helpful Put Request');
});

app.get('/reviews', (req, res) => {
  // review_id
  res.send('Report Put Request');
});
