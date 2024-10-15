const express = require('express');
const jamiBootstrap = require('jami-bootstrap');

const app = express();
const port = process.env.PORT || 4222;

// Configure your Jami Bootstrap options
const bootstrapOptions = {
  // ... your Jami Bootstrap configuration
};

// Initialize Jami Bootstrap
const jami = jamiBootstrap(bootstrapOptions);

// Define your routes
app.get('/', (req, res) => {
  res.send('Jami Bootstrap Server is running!');
});

// Start the server
app.listen(port, () => {
  console.log(`Server listening on port ${port}`);
});
