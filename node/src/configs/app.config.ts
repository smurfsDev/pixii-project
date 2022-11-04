import express,{Request,Response} from 'express';
import bodyParser from 'body-parser';
const dotenv = require('dotenv');
dotenv.config();


const app = express();
app.use(bodyParser.json());

export default app;