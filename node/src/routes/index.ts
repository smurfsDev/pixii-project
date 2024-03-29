import express from 'express';
import { fetchUser } from '../configs/auth.config';

const router = express.Router();
router.use(fetchUser);
// require('./routesfile.routes')(router);
// example
require('./claims.routes')(router);
require('./comments.routes')(router);
require('./status.routes')(router);
require('./register.routes')(router);
require('./role.routes')(router);
require('./users.routes')(router);
require('./bike.routes')(router);
require('./dashboard.routes')(router);
require('./callback.routes')(router);

export default router;

