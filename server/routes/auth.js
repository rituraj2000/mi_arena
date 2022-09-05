const express = require("express");
const authRouter = express.Router();
const Employee = require("../models/employee");
const auth = require("../middlewares/auth.js");
const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");

authRouter.post("/api/signup", async (req, res) => {
  const { name, employeeCode, password, storeCode } = req.body;

  try {
    const existingEmployee = await Employee.findOne({
      employeeCode: employeeCode,
    });
    if (existingEmployee) {
      return res
        .status(400)
        .json({ response: "Employee already Registered! for this store" });
    }

    const hashedPassword = await bcrypt.hash(password, 8);

    let employee = new Employee({
      name: name,
      employeeCode: employeeCode,
      password: hashedPassword,
      storeCode: storeCode,
    });

    employee = await employee.save();

    res.json(employee);
  } catch (err) {
    res.status(500).send({ err: err.message });
  }
});

authRouter.post("/api/signin", async (req, res) => {
  const { employeeCode, password } = req.body;

  try {
    const existingEmployee = await Employee.findOne({
      employeeCode: employeeCode,
    });

    if (!existingEmployee)
      return res.status(400).json({ Error: "Employee not found" });

    const isMatch = await bcrypt.compare(password, existingEmployee.password);

    if (!isMatch) return res.status(400).json({ Error: "Password mismatch" });

    const token = jwt.sign({ id: existingEmployee._id }, "password");

    res.json({ token, ...existingEmployee._doc });
  } catch (err) {
    console.log(err);
  }
});

//validate the token
//TODO The JWT route
authRouter.post("/tokenisvalid", async (req, res) => {
  try {
    const token = req.header("x-auth-token");

    if (!token) return res.json(false);

    const verified = jwt.verify(token, "password");

    if (!verified) return res.json(false);

    const employee = await Employee.findById(verified.id);

    if (!employee) return res.json(false);

    res.json(true);
  } catch (err) {
    res.status(500).json({ error: err });
  }
});

//Get USer Data
authRouter.get("/", auth, async (req, res) => {
  const employee = await Employee.findById(req.employee);
  const token = req.token;
  
  res.json({ ...employee._doc, token });
});

module.exports = authRouter;
