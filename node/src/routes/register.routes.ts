import { accept, create } from '../controllers/register.controller';
module.exports = (app: any) => {


    // Create a new user
    app.post("/node/register", create);
    app.put("/node/accept/:username/:role", accept)


}