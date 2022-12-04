import { create } from '../controllers/register.controller';
module.exports = (app: any) => {


    // Create a new user
    app.post("/node/register", create);


}