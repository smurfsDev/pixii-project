import { findAll, create, update, remove, findOne } from '../controllers/comments.controller';
module.exports = (app: any) => {


  // Create a new comment
  app.post("/node/comments", create);

  // Retrieve all comments
  app.get("/node/comments", findAll);

  // Retrieve a single comment with commentId
  app.get("/node/comments/:id", findOne);

  // Update a comment with commentId
  app.put("/node/comments/:id", update);

  // Delete a comment with commentId
  app.delete("/node/comments/:id", remove);

}