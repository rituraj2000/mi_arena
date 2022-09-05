import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:mi_arena/common/widgets/customTextField.dart';
import 'package:mi_arena/common/widgets/custom_button.dart';
import 'package:mi_arena/constants/constants.dart';
import 'package:mi_arena/constants/utils.dart';
import 'package:mi_arena/features/admin/services/adminSevices.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({Key? key}) : super(key: key);
  static const routeName = "/add-product";
  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final _addProductFormKey = GlobalKey<FormState>();
  final AdminServices _adminServices = AdminServices();

  List<File> images = [];

  List<String> productCategories = [
    'Mobiles',
    'Essentials',
    'Appliances',
    'Books',
    'Fashion'
  ];

  String category = 'Mobiles';

  void selectImage() async {
    var res = await pickImages();
    setState(
      () {
        images = res;
      },
    );
  }

  void sellProduct() {
    _adminServices.sellProduct(
      context: context,
      name: productNameController.text,
      description: descriptionController.text,
      price: 5,
      quantity: 5,
      category: category,
      images: images,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariable.appBarGradient,
            ),
          ),
          title: const Text(
            'Add Product',
            style: TextStyle(
              color: Colors.white,
              fontSize: 17,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _addProductFormKey,
          child: Column(
            children: [
              images.isEmpty
                  ? GestureDetector(
                      onTap: selectImage,
                      child: Padding(
                        padding: const EdgeInsets.all(30),
                        child: DottedBorder(
                          child: Container(
                            width: double.infinity,
                            height: 150,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(40),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(Icons.folder),
                                Text('Add Product Images'),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  : CarouselSlider(
                      items: images
                          .map(
                            (i) => Builder(
                              builder: (BuildContext context) => Image.file(
                                i,
                                fit: BoxFit.cover,
                                height: 200,
                              ),
                            ),
                          )
                          .toList(),
                      options: CarouselOptions(),
                    ),
              CustomTextField(
                hint: 'name',
                controller: productNameController,
              ),
              CustomTextField(
                hint: 'description',
                controller: descriptionController,
                maxlines: 7,
              ),
              CustomTextField(
                hint: 'price',
                controller: priceController,
              ),
              CustomTextField(
                hint: 'quantity',
                controller: quantityController,
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                width: double.infinity,
                child: DropdownButton(
                  value: category,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: productCategories.map((String item) {
                    return DropdownMenuItem(
                      value: item,
                      child: Text(item),
                    );
                  }).toList(),
                  onChanged: (String? newVal) {
                    setState(() {
                      category = newVal!;
                    });
                  },
                ),
              ),
              CustomButton(
                text: 'Add Product',
                onTap: () {
                  sellProduct();
                  print("ddwdwdw");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    productNameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    quantityController.dispose();
    super.dispose();
  }
}
