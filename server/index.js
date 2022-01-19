const express = require('express');

const app = express();

const port = 3000;

app.listen(port, () => {
  console.log(`Server Running at: http://localhost:${port}`);
});

// getAllReviews = imported model
const getAllReviews = (id) => {
  return new Promise((resolve) => {
    // model to get data from db
    resolve('DATA FROM MODEL GOES HERE', id);
  });
};

async function getAll(id) {
  const data = await getAllReviews(id);
  return data;
}

app.get('/', (req, res) => {
  res.send('Test Index');
});

app.get('/reviews/', (req, res) => {
  // page, count, sort, product_id
  const data = getAll(req.body.product_id);
  res.send('Review Get Request', data);
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
