const express = require("express");
const adminROuter = express.Router();
const { Product } = require("../models/product");
const admin = require("../middlewares/admin");

adminROuter.post("/admin/addProducts", admin, async (req, res) => {
  try {
    const { name, description, category, quantity, images, price } = req.body;

    let product = new Product({
      name,
      description,
      images,
      quantity,
      price,
      category,
    });

    product = await product.save();

    res.json(product);
  } catch (e) {
    res.status(400).json({ error: e.message });
  }
});

adminROuter.get("/admin/getproducts", admin, async (req, res) => {
  try {
    const products = await Product.find({});

    res.json( products );
  } catch (e) {
    res.status(500).json({ e });
  }
});

module.exports = adminROuter;
