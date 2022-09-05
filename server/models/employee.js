const mongoose = require("mongoose");

const employeeSchema = mongoose.Schema({
  name: {
    required: true,
    type: String,
    trimmed: true,
  },

  employeeCode: {
    required: true,
    type: String,
    trimmed: true,
  },

  password: {
    required: true,
    type: String,
  },

  storeCode: {
    required: true,
    type: String,
  },

  //Type : Cashier | Manager
  type: {
    required: true,
    type: String,
    default: "cashier",
  },
});

module.exports = mongoose.model("Employee", employeeSchema);
