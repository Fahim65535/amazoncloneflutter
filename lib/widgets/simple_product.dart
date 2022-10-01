import 'package:amazone_clone_app/model/barrel_model.dart';
import 'package:amazone_clone_app/screens/product_display.dart';
import 'package:flutter/material.dart';

class SimpleProductList extends StatelessWidget {
  final ProductModel productModel;
  const SimpleProductList({Key? key, required this.productModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return ProductDisplay(product: productModel);
            },
          ),
        );
      },
      child: AspectRatio(
        aspectRatio: 3 / 3,
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.network(productModel.url),
          ),
        ),
      ),
    );
  }
}
