const jwt = require("jsonwebtoken");
const Employee = require("../models/employee");

const auth = async (req, res, next) => {
  try {
    const token = req.header("x-auth-token");

    if (!token)
      return res.status(401).json({ message: "No auth token! Access denied!" });

    const verified = jwt.verify(token, "password");

    if (!verified)
      return res.status(401).json({ message: "Token Validation Failed!" });

    const employee = await Employee.findById(verified.id);

    if (employee.type != "admin")
      return res.status(401).json({ message: "Not Authorised as an Admin!" });

    req.employee = verified.id;
    req.token = token;
    next();
  } catch (err) {
    res.status(500).json(err);
  }
};

module.exports = auth;
