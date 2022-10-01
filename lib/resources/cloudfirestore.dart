import 'dart:typed_data';
import 'package:amazone_clone_app/config/barrel_config.dart';
import 'package:amazone_clone_app/model/barrel_model.dart';
import 'package:amazone_clone_app/widgets/barrel_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

class CloudFirestore {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  //creating data
  Future userData({required UserDetails user}) async {
    await firebaseFirestore
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .set(user.getJson());
  }

  //getting name and address
  Future getNameAndAddress() async {
    DocumentSnapshot snap = await firebaseFirestore
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .get();
    UserDetails userModel = UserDetails.getFromJson(
      (snap.data() as dynamic),
    );

    return userModel;
  }

  //uploading data of the products
  Future<String> uploadProdData({
    required Uint8List? image,
    required String productName,
    required String rawCost,
    required int discount,
    required String sellerName,
    required String sellerUid,
  }) async {
    productName.trim();
    rawCost.trim();

    String output = 'Something went wrong';

    if (image != null && productName != '' && rawCost != '') {
      try {
        String uid = Utils().getUid();
        String url = await uploadImage(image: image, uid: uid);
        double cost = double.parse(rawCost);
        cost = cost - (cost * (discount / 100));
        ProductModel product = ProductModel(
            cost: cost,
            discount: discount,
            noOfRating: 0,
            productName: productName,
            rating: 3,
            sellerName: sellerName,
            sellerUid: sellerUid,
            uid: uid,
            url: url);

        await firebaseFirestore
            .collection('products')
            .doc(uid)
            .set(product.getJson());
        output = 'success';
      } catch (e) {
        output = e.toString();
      }
    } else {
      output = 'Please fill up the details';
    }
    return output;
  }

//creating image path url
  Future<String> uploadImage(
      {required Uint8List image, required String uid}) async {
    Reference storageRef =
        FirebaseStorage.instance.ref().child('products').child(uid);
    UploadTask uploadTask = storageRef.putData(image);
    TaskSnapshot task = await uploadTask;
    return task.ref.getDownloadURL();
  }

//sorting products with discounts (home screen functionality)
  Future<List<Widget>> getProductsFromDiscount(int discount) async {
    List<Widget> children = [];
    QuerySnapshot<Map<String, dynamic>> snap = await firebaseFirestore
        .collection('products')
        .where('discount', isEqualTo: discount)
        .get();

    for (int i = 0; i < snap.docs.length; i++) {
      DocumentSnapshot docSnap = snap.docs[i];
      ProductModel prodModel =
          ProductModel.getModelFromJson(json: docSnap.data() as dynamic);
      children.add(SimpleProductList(productModel: prodModel));
    }
    return children;
  }

//adding review (product display screen functionality)
  Future uploadReview({
    required ReviewModel reviewModel,
    required String productUid,
  }) async {
    await firebaseFirestore
        .collection('products')
        .doc(productUid)
        .collection('reviews')
        .add(reviewModel.getJson());
  }

//adding & setting cart item with its uid (cart screen functionality)
  Future addProductToCart({required ProductModel productModel}) async {
    await firebaseFirestore
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .collection('cart items')
        .doc(productModel.uid)
        .set(productModel.getJson());
  }

//removing cart item (cart screen functionality)
  Future deleteProductFromCart({required String uid}) async {
    await firebaseFirestore
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .collection('cart items')
        .doc(uid)
        .delete();
  }

//getting products from cart to account screen - proceed to buy button (cart screen functionality)
  Future buyAllItemsinCart({required UserDetails details}) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await firebaseFirestore
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .collection('cart items')
        .get();

    for (int i = 0; i < snapshot.docs.length; i++) {
      ProductModel model =
          ProductModel.getModelFromJson(json: snapshot.docs[i].data());
      addProductToOrders(model: model, details: details);
      await deleteProductFromCart(uid: model.uid);
    }
  }

//adding products to orders (account screen functionality)
  Future addProductToOrders(
      {required ProductModel model, required UserDetails details}) async {
    await firebaseFirestore
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .collection('orders')
        .add(model.getJson());
    await sendOrderRequests(prod: model, details: details);
  }

//sending order requests (account screen functionality)
  Future sendOrderRequests(
      {required ProductModel prod, required UserDetails details}) async {
    OrderRequestsModel reqModel = OrderRequestsModel(
        clientAddress: details.address, orderName: prod.productName);
    await firebaseFirestore
        .collection('users')
        .doc(prod.sellerUid)
        .collection('order requests')
        .add(reqModel.getJson());
  }
}
