import 'package:amazone_clone_app/config/barrel_config.dart';
import 'package:amazone_clone_app/model/barrel_model.dart';
import 'package:amazone_clone_app/screens/barrel_screens.dart';
import 'package:amazone_clone_app/widgets/barrel_widgets.dart';
import 'package:amazone_clone_app/provider/user_details_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AccountAppBar(),
      body: SingleChildScrollView(
        child: SizedBox(
          height: screenSize.height,
          width: screenSize.width,
          child: Column(
            children: [
              const AccountIntroWidget(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.orange,
                    fixedSize: Size(screenSize.width * 0.7, 40)),
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                },
                child: const Text(
                  'Sign out',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: yellowColor,
                    fixedSize: Size(screenSize.width * 0.7, 40)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return SellScreen();
                      },
                    ),
                  );
                },
                child: const Text(
                  'Sell',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection('users')
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .collection('orders')
                    .get(),
                builder: (context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container();
                  } else {
                    List<Widget> children = [];

                    for (int i = 0; i < snapshot.data!.docs.length; i++) {
                      ProductModel model = ProductModel.getModelFromJson(
                          json: snapshot.data!.docs[i].data());
                      children.add(SimpleProductList(productModel: model));
                    }
                    return ProductShowcase(
                        title: 'Your Orders', children: children);
                  }
                },
              ),
              const Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Order Requests',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Expanded(
                child: FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection('users')
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .collection('order requests')
                      .get(),
                  builder: (context,
                      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                          snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container();
                    } else {
                      return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          OrderRequestsModel requestsModel =
                              OrderRequestsModel.getModelFromJson(
                                  json: snapshot.data!.docs[index].data());
                          return ListTile(
                            title: Text(
                              'Order: ${requestsModel.orderName}',
                              style:
                                  const TextStyle(fontWeight: FontWeight.w500),
                            ),
                            subtitle:
                                Text('Address: ${requestsModel.clientAddress}'),
                            trailing: IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.check)),
                          );
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
    );
  }
}

class AccountIntroWidget extends StatelessWidget {
  const AccountIntroWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserDetails userDetail =
        Provider.of<UserDetailsProvider>(context).userDetails;
    return Container(
      height: kAppBarHeight / 2,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: backgroundGradient,
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      child: Container(
        height: kAppBarHeight,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [Colors.white, Colors.white.withOpacity(0)],
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                        text: 'Hello, ',
                        style: TextStyle(fontSize: 27, color: Colors.black)),
                    TextSpan(
                        text: userDetail.name,
                        style: const TextStyle(
                            fontSize: 27,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://m.media-amazon.com/images/I/11uufjN3lYL._SX90_SY90_.png'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
