import { findAll, create, update, remove, findOne } from '../controllers/comments.controller';
module.exports = (app: any) => {


  // Create a new comment
  app.post("/comments", create);

  // Retrieve all comments
  app.get("/comments", findAll);

  // Retrieve a single comment with commentId
  app.get("/comments/:id", findOne);

  // Update a comment with commentId
  app.put("/comments/:id", update);

  // Delete a comment with commentId
  app.delete("/comments/:id", remove);

}