import 'package:amazone_clone_app/config/barrel_config.dart';
import 'package:amazone_clone_app/model/barrel_model.dart';
import 'package:amazone_clone_app/provider/user_details_provider.dart';
import 'package:amazone_clone_app/resources/cloudfirestore.dart';
import 'package:amazone_clone_app/widgets/barrel_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDisplay extends StatefulWidget {
  final ProductModel product;
  const ProductDisplay({Key? key, required this.product}) : super(key: key);

  @override
  State<ProductDisplay> createState() => _ProductDisplayState();
}

class _ProductDisplayState extends State<ProductDisplay> {
  Size screenSize = Utils().getScreenSize();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: SearchBar(
          isReadOnly: true,
          backButton: true,
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    const SizedBox(height: kAppBarHeight / 2),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //product info on top left
                            Text(
                              widget.product.sellerName,
                              style: const TextStyle(
                                  fontSize: 18, color: activeCyanColor),
                            ),
                            const SizedBox(height: 7),
                            Text(widget.product.productName),
                          ],
                        ),

                        //star rating on top right
                        ResultStarWidget(rating: widget.product.rating),
                      ],
                    ),
                    const SizedBox(height: kAppBarHeight / 2),

                    //Image
                    SizedBox(
                      height: screenSize.height / 2.5,
                      child: Image.network(widget.product.url),
                    ),

                    const SizedBox(height: kAppBarHeight / 4),

                    //cost widget
                    Cost(color: Colors.black, cost: widget.product.cost),

                    const SizedBox(height: kAppBarHeight / 7),

                    //button - buy now
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.orange,
                          fixedSize: Size(screenSize.width * 0.7, 40)),
                      onPressed: () async {
                        await CloudFirestore().addProductToOrders(
                          model: widget.product,
                          details: Provider.of<UserDetailsProvider>(context,
                                  listen: false)
                              .userDetails,
                        );
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Orders Info'),
                              content: const Text(
                                'Ordered successfully!',
                              ),
                              actions: [
                                Center(
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: yellowColor),
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text(
                                      'Back',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: const Text(
                        'Buy now',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),

                    //button - add cart
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: yellowColor,
                          fixedSize: Size(screenSize.width * 0.7, 40)),
                      onPressed: () async {
                        await CloudFirestore()
                            .addProductToCart(productModel: widget.product);
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Cart Info'),
                              content: const Text(
                                'Product has been added to cart!',
                              ),
                              actions: [
                                Center(
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: yellowColor),
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text(
                                      'Back',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: const Text(
                        'Add to cart',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),

                    const SizedBox(height: kAppBarHeight / 7),

                    //review button
                    CartButtons(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return ReviewDialog(productUid: widget.product.uid);
                          },
                        );
                      },
                      text: 'Add a review for this product',
                    ),

                    //adding review to firestore from product screen
                    SizedBox(
                      height: screenSize.height,
                      child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('products')
                            .doc(widget.product.uid)
                            .collection('reviews')
                            .snapshots(),
                        builder: (context,
                            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                                snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Container();
                          } else {
                            return ListView.builder(
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                ReviewModel reviewModel =
                                    ReviewModel.getModelFromJson(
                                        json:
                                            snapshot.data!.docs[index].data());
                                return ReviewWidget(review: reviewModel);
                              },
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const UserDetailsBar(offset: 0),
          ],
        ),
      ),
    );
  }
}
