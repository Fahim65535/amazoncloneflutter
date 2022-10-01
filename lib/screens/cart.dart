import 'package:amazone_clone_app/provider/user_details_provider.dart';
import 'package:amazone_clone_app/resources/cloudfirestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:amazone_clone_app/model/barrel_model.dart';
import 'package:amazone_clone_app/widgets/barrel_widgets.dart';
import 'package:amazone_clone_app/config/barrel_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  Size screenSize = Utils().getScreenSize();

  bool oneItem = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchBar(
        isReadOnly: true,
        backButton: false,
      ),
      body: Center(
        child: Stack(
          children: [
            const UserDetailsBar(offset: 0),
            Column(
              children: [
                const SizedBox(height: kAppBarHeight / 2),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .collection('cart items')
                        .snapshots(),
                    builder: (context,
                        AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                            snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const LoadingIndicator();
                      } else {
                        return ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: yellowColor,
                              fixedSize: Size(screenSize.width * 0.7, 40)),
                          onPressed: () async {
                            CloudFirestore().buyAllItemsinCart(
                                details: Provider.of<UserDetailsProvider>(
                                        context,
                                        listen: false)
                                    .userDetails);
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
                          child: oneItem //to be checked
                              ? const Text(
                                  'Proceed to buy item',
                                  style: TextStyle(color: Colors.black),
                                )
                              : Text(
                                  'Proceed to buy ${snapshot.data!.docs.length} items',
                                  style: const TextStyle(color: Colors.black),
                                ),
                        );
                      }
                    },
                  ),
                ),
                Expanded(
                    child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .collection('cart items')
                      .snapshots(),
                  builder: (context,
                      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                          snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container();
                    } else {
                      return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          ProductModel productModel =
                              ProductModel.getModelFromJson(
                                  json: snapshot.data!.docs[index].data());
                          return CarItem(product: productModel);
                        },
                      );
                    }
                  },
                )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
