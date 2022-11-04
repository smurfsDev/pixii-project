import express from 'express';

const router = express.Router();

// require('./routesfile.routes')(router);
// example
require('./claims.routes')(router);
require('./comments.routes')(router);

export default router;

