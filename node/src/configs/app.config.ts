import express,{Request,Response} from 'express';
import bodyParser from 'body-parser';
const dotenv = require('dotenv');
const cors = require('cors');
dotenv.config();


const app = express();
app.use(cors());
app.use(bodyParser.json());

export default app;