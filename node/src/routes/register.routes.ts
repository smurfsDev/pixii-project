import { accept, create, refuse, updateImage } from '../controllers/register.controller';
module.exports = (app: any) => {


    // Create a new user
    app.post("/node/register", create);
    app.put("/node/accept/:username/:role", accept)
    app.put("/node/refuse/:username/:role", refuse)
	app.put("/node/updateImage/:username", updateImage)


}