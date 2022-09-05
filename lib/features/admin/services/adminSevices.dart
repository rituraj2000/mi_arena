import 'dart:convert';
import 'dart:io';
import "package:http/http.dart" as http;
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/cupertino.dart';
import 'package:mi_arena/constants/constants.dart';
import 'package:mi_arena/constants/error_handling.dart';
import 'package:mi_arena/models/product.dart';
import 'package:mi_arena/providers/employee_provider.dart';
import 'package:provider/provider.dart';

class AdminServices {
  //Sell Product
  void sellProduct({
    required BuildContext context,
    required String name,
    required String description,
    required double price,
    required double quantity,
    required String category,
    required List<File> images,
  }) async {
    final cloudinary = CloudinaryPublic("amznpersonal1", "miarena");

    List<String> imageUrls = [];

    for (int i = 0; i < images.length; i++) {
      CloudinaryResponse res = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(images[i].path, folder: name),
      );

      imageUrls.add(res.secureUrl);
    }

    Product product = Product(
      name: name,
      description: description,
      quantity: quantity,
      images: imageUrls,
      category: category,
      price: price,
    );

    try {
      http.Response res = await http.post(
        Uri.parse("${GlobalVariable.uri}/admin/addProducts"),
        body: product.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': Provider.of<EmployeeProvider>(context, listen: false)
              .employee
              .token,
        },
      );

      print("AdminSeevice/addImage " + res.body);
    } catch (e) {
      print(
        "Error in Admin Service/addproducts " + e.toString(),
      );
    }
  }

  //Get Products
  Future<List<Product>> fetchAllProducts(BuildContext context) async {
    final userProvider = Provider.of<EmployeeProvider>(context, listen: false);
    List<Product> productList = [];
    try {
      http.Response res = await http
          .get(Uri.parse('${GlobalVariable.uri}/admin/getproducts'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.employee.token,
      });

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            productList.add(
              Product.fromJson(
                jsonEncode(
                  jsonDecode(res.body)[i],
                ),
              ),
            );
          }
        },
      );
    } catch (e) {
      print(e.toString());
    }

    return productList;
  }
}
