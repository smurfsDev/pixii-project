import { findAll, create, update, remove, findOne, setStatus } from '../controllers/status.controller';
module.exports = (app: any) => {


  // Create a new claim
  app.post("/status", create);

  // Retrieve all status
  app.get("/status", findAll);

  // Retrieve a single claim with claimId
  app.get("/status/:id", findOne);

  // Update a claim with claimId
  app.put("/status/:id", update);

  // Delete a claim with claimId
  app.delete("/status/:id", remove);

  // Set status of claim with claimId
  app.put("/status/:id/:status", setStatus);

}