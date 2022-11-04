import { findAll, create, update, remove, findOne, setStatus } from '../controllers/claims.controller';
module.exports = (app: any) => {


  // Create a new claim
  app.post("/claims", create);

  // Retrieve all claims
  app.get("/claims", findAll);

  // Retrieve a single claim with claimId
  app.get("/claims/:id", findOne);

  // Update a claim with claimId
  app.put("/claims/:id", update);

  // Delete a claim with claimId
  app.delete("/claims/:id", remove);

  // Set status of claim with claimId
  app.put("/claims/:id/:status", setStatus);

}