import mongoose from 'mongoose';
import app from './configs/app.config';
import { connect } from './configs/db.config';
import status from './models/status.model';
import router from './routes/index';
import { seed } from './seeder';

connect();


seed();

app.use('', router);

app.get('/', (req, res) => {
	res.send('Hello Worlsd!');
});
let port = process.env.PORT || 3000;
let connected = false;
// const PORT = process.env.PORT || 3000;
const eurekaHelper = require('./eureka-helper');

// app.listen(PORT, () => {
//     console.log("user-service on 3000");
// })

// app.get('/', (req, res) => {
// 	res.json("I am user-service")
// })
eurekaHelper.registerWithEureka('node-service', port);

app.listen(port, () => {
	console.log('Server is running on port ' + port);
});