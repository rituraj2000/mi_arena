const express = require("express");
const authRouter = require("./routes/auth");
const adminRouter = require("./routes/admin");
const app = express();
const mongoose = require("mongoose");
const PORT = 8080;

app.use(express.json());
app.use(authRouter);
app.use(adminRouter);

const DB =
  "mongodb+srv://rituraj:Rx2000!Rn@cluster0.ifa0pbs.mongodb.net/?retryWrites=true&w=majority";

mongoose
  .connect(DB)
  .then(() => console.log("Connected to DB!"))
  .catch((e) => console.log(e));

//Listen to server
app.listen(PORT, "0.0.0.0", () => {
  console.log("listening on port");
});
