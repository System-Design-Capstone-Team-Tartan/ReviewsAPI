const express = require('express');

const app = express();

const port = 3000;

app.listen(port, () => {
  console.log(`Server Running at: http://localhost:${port}`);
});

app.get('/', (req, res) => {
  res.send('Test Index');
});

// getAllReviews = imported model
const getAllReviews = async (id) => {
  // const data = await (model to get data from db)
  console.log(id); // this is temp to hush airbnb
  return id; // return data
};

app.get('/reviews/', async (req, res) => { // async says this callback function has an await
  // page, count, sort, product_id
  try { // try this first - attempt the await function
    const data = await getAllReviews(req.body.product_id); // call the getAllReviews async function
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
