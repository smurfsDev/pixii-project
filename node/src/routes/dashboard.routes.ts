import { CountClaimsByStatus  , CountUsersByRole ,CountBikes ,CountMineClaims} from "../controllers/dashboard.controller";
module.exports = (app: any) => {
    app.get("/node/dashboard/claimsByStatus", CountClaimsByStatus);
    app.get("/node/dashboard/users", CountUsersByRole);
    app.get("/node/dashboard/bikes", CountBikes);
    app.get("/node/dashboard/mineClaims", CountMineClaims);
};