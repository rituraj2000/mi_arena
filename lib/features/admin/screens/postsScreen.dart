import 'package:flutter/material.dart';
import 'package:mi_arena/features/admin/screens/addProductScreen.dart';
import 'package:mi_arena/features/admin/services/adminSevices.dart';
import 'package:mi_arena/features/admin/widgets/singleProduct.dart';
import 'package:mi_arena/models/product.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({Key? key}) : super(key: key);

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  AdminServices _adminServices = AdminServices();
  List<Product>? _productList;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProductsList();
  }

  void getProductsList() async {
    var temp = await _adminServices.fetchAllProducts(context);
    print(temp);
    _productList = temp;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return _productList == null
        ? const Center(child: Text("Fetching Posts......."))
        : Scaffold(
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddProductScreen()));
              },
              child: Icon(Icons.add),
            ),
            body: GridView.builder(
              itemCount: _productList!.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemBuilder: (context, index) {
                final productData = _productList![index];
                return Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      SingleProduct(
                        image:
                            "https://sathya.in/media/81658/catalog/pms_1646677667.5338160.png?size=256",
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: Text(
                              productData.name,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),
                          IconButton(
                            onPressed: () => {},
                            icon: const Icon(
                              Icons.delete_outline,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          );
  }
}
