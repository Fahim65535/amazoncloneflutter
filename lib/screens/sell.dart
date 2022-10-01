import 'dart:typed_data';
import 'package:amazone_clone_app/provider/user_details_provider.dart';
import 'package:amazone_clone_app/resources/cloudfirestore.dart';
import 'package:amazone_clone_app/widgets/barrel_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../config/barrel_config.dart';

class SellScreen extends StatefulWidget {
  const SellScreen({Key? key}) : super(key: key);

  @override
  State<SellScreen> createState() => _SellScreenState();
}

class _SellScreenState extends State<SellScreen> {
  bool isLoading = false;
  int selected = 1;
  Size screenSize = Utils().getScreenSize();
  Uint8List? image;
  SizedBox height = const SizedBox(height: 6);
  List<int> keysForDiscount = [0, 50, 60, 70];

  //controllers
  TextEditingController nameController = TextEditingController();
  TextEditingController costController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    costController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: !isLoading
            ? SingleChildScrollView(
                child: SizedBox(
                  height: screenSize.height,
                  width: screenSize.width,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              image == null
                                  ? Image.network(
                                      'https://icon-library.com/images/default-profile-icon/default-profile-icon-24.jpg',
                                      height: screenSize.height / 10,
                                    )
                                  : Image.memory(
                                      image!,
                                      height: screenSize.height / 10,
                                    ),
                              height,
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: yellowColor),
                                onPressed: () async {
                                  Uint8List? temp = await Utils().pickImg();
                                  if (temp != null) {
                                    setState(() {
                                      image = temp;
                                    });
                                  }
                                },
                                child: const Text(
                                  'Upload image from gallery',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                          height,
                          Container(
                            height: screenSize.height * 0.6,
                            width: screenSize.width * 0.9,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey.shade900,
                                width: 1,
                              ),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 18.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  height,
                                  TextFieldWidget(
                                    controller: nameController,
                                    obscureText: false,
                                    hintText: 'Enter your name',
                                    title: 'Name',
                                  ),
                                  height,
                                  TextFieldWidget(
                                    controller: costController,
                                    obscureText: false,
                                    hintText: 'Enter Amount',
                                    title: 'Cost',
                                  ),
                                  height,
                                  const Text(
                                    'Discount',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  ListTile(
                                    title: const Text('None'),
                                    leading: Radio(
                                      value: 1,
                                      groupValue: selected,
                                      onChanged: (int? value) {
                                        setState(
                                          () {
                                            selected = value!;
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                  ListTile(
                                    title: const Text('50%'),
                                    leading: Radio(
                                      value: 2,
                                      groupValue: selected,
                                      onChanged: (int? value) {
                                        setState(
                                          () {
                                            selected = value!;
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                  ListTile(
                                    title: const Text('60%'),
                                    leading: Radio(
                                      value: 3,
                                      groupValue: selected,
                                      onChanged: (int? value) {
                                        setState(
                                          () {
                                            selected = value!;
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                  ListTile(
                                    title: const Text('70%'),
                                    leading: Radio(
                                      value: 4,
                                      groupValue: selected,
                                      onChanged: (int? value) {
                                        setState(
                                          () {
                                            selected = value!;
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          height,
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: yellowColor,
                              fixedSize: Size(screenSize.width * 0.6, 30),
                            ),
                            onPressed: () async {
                              String output = await CloudFirestore()
                                  .uploadProdData(
                                      image: image,
                                      productName: nameController.text,
                                      rawCost: costController.text,
                                      discount: keysForDiscount[selected - 1],
                                      sellerName:
                                          Provider.of<UserDetailsProvider>(
                                                  context,
                                                  listen: false)
                                              .userDetails
                                              .name,
                                      sellerUid: FirebaseAuth
                                          .instance.currentUser!.uid);
                              if (output == 'success') {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text('Upload Success!'),
                                      content: const Text(
                                        'Your Product has been posted.',
                                      ),
                                      actions: [
                                        Center(
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                primary: yellowColor),
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            child: const Text(
                                              'Back',
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text('Alert!'),
                                      content: Text(output),
                                      actions: [
                                        Center(
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                primary: yellowColor),
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            child: const Text(
                                              'Back',
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                            },
                            child: const Text(
                              'Sell',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.grey[400],
                              fixedSize: Size(screenSize.width * 0.6, 30),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'Back',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            : const LoadingIndicator(),
      ),
    );
  }
}
