import 'package:amazone_clone_app/config/barrel_config.dart';
import 'package:amazone_clone_app/resources/cloudfirestore.dart';
import 'package:amazone_clone_app/screens/barrel_screens.dart';
import 'package:amazone_clone_app/model/barrel_model.dart';
import 'package:amazone_clone_app/widgets/barrel_widgets.dart';
import 'package:flutter/material.dart';

class CarItem extends StatelessWidget {
  final ProductModel product;
  const CarItem({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    return Container(
      height: screenSize.height / 2,
      width: screenSize.width,
      decoration: const BoxDecoration(
        color: backgroundColor,
        border: Border(
          bottom: BorderSide(
            color: Colors.grey,
            width: 1,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0),
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return ProductDisplay(product: product);
                      },
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: screenSize.width / 3,
                        child: Image.network(
                          product.url,
                        ),
                      ),
                      ProductCartInfo(
                        productName: product.productName,
                        cost: product.cost,
                        sellerName: product.sellerName,
                      )
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  CartSquarebutton(
                    onPressed: () {},
                    color: backgroundColor,
                    dimension: 40,
                    child: const Icon(Icons.remove),
                  ),
                  CartSquarebutton(
                    onPressed: () {},
                    color: Colors.white,
                    dimension: 40,
                    child: const Text('0',
                        style: TextStyle(color: activeCyanColor)),
                  ),
                  CartSquarebutton(
                    onPressed: () async {
                      CloudFirestore().addProductToCart(
                        productModel: ProductModel(
                            cost: product.cost,
                            discount: product.discount,
                            noOfRating: product.noOfRating,
                            productName: product.productName,
                            rating: product.rating,
                            sellerUid: product.sellerUid,
                            sellerName: product.sellerName,
                            uid: Utils().getUid(),
                            url: product.url),
                      );
                    },
                    color: backgroundColor,
                    dimension: 40,
                    child: const Icon(Icons.add),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  Row(
                    children: [
                      CartButtons(
                          onPressed: () async {
                            CloudFirestore()
                                .deleteProductFromCart(uid: product.uid);
                          },
                          text: 'Delete'),
                      const SizedBox(width: 5),
                      CartButtons(onPressed: () {}, text: 'Save for later'),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Padding(
                    padding: EdgeInsets.only(left: 2.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'See more of these',
                        style: TextStyle(color: activeCyanColor),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
