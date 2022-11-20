import express from 'express';

const router = express.Router();

// require('./routesfile.routes')(router);
// example
require('./claims.routes')(router);
require('./comments.routes')(router);
require('./status.routes')(router);

export default router;

