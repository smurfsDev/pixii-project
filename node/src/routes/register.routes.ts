import { create } from '../controllers/register.controller';
module.exports = (app: any) => {


    // Create a new claim
    app.post("/node/register", create);


}