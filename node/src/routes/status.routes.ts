import { findAll, create, update, remove, findOne, setStatus } from '../controllers/status.controller';
module.exports = (app: any) => {


  // Create a new claim
  app.post("/node/status", create);

  // Retrieve all status
  app.get("/node/status", findAll);

  // Retrieve a single claim with claimId
  app.get("/node/status/:id", findOne);

  // Update a claim with claimId
  app.put("/node/status/:id", update);

  // Delete a claim with claimId
  app.delete("/node/status/:id", remove);

  // Set status of claim with claimId
  app.put("/node/status/:id/:status", setStatus);

}