const jwt = require("jsonwebtoken");

const auth = async (req, res, next) => {
  try {
    const token = req.header("x-auth-token");

    if (!token)
      return res.status(401).json({ message: "No auth token! Access denied!" });

    const verified = jwt.verify(token, "password");

    if (!verified)
      return res.status(401).json({ message: "Token Validation Failed!" });

    req.employee = verified.id;
    req.token = token;
    next();
  } catch (err) {
    res.status(500).json(err);
  }
};

module.exports = auth;
