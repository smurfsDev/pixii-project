import { findAll, create, remove, findOne, setCalled } from '../controllers/callback.controller';
module.exports = (app: any) => {


  // Create a new claim
  app.post("/node/callback", create);

  // Retrieve all callback
  app.get("/node/callback", findAll);

  // Retrieve a single claim with claimId
  app.get("/node/callback/:id", findOne);

  // Delete a claim with claimId
  app.delete("/node/callback/:id", remove);

  // Set callback of claim with claimId
  app.put("/node/callback/:id", setCalled);

}