import { findAll, create, update, remove, findOne, setStatus } from '../controllers/claims.controller';
module.exports = (app: any) => {


  // Create a new claim
  app.post("/node/claims", create);

  // Retrieve all claims
  app.get("/node/claims", findAll);

  // Retrieve a single claim with claimId
  app.get("/node/claims/:id", findOne);

  // Update a claim with claimId
  app.put("/node/claims/:id", update);

  // Delete a claim with claimId
  app.delete("/node/claims/:id", remove);

  // Set status of claim with claimId
  app.put("/node/claims/:id/:status", setStatus);

}