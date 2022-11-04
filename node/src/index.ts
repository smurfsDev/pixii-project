import app from './configs/app.config';
import {connect} from './configs/db.config';
import router from './routes/index';

connect();

app.use('',router);

app.get('/', (req, res) => {
	  res.send('Hello World!');
});
let port = process.env.PORT || 3000;
let connected = false;
app.listen(port, () => {
	console.log('Server is running on port '+port);
});