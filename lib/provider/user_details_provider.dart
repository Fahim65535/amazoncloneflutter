import 'package:amazone_clone_app/resources/cloudfirestore.dart';
import 'package:flutter/material.dart';
import '../model/barrel_model.dart';

class UserDetailsProvider with ChangeNotifier {
  UserDetails userDetails;

  UserDetailsProvider()
      : userDetails = UserDetails(address: 'Loading..', name: 'Loading..');

  Future getData() async {
    userDetails = await CloudFirestore().getNameAndAddress();
    notifyListeners();
  }
}
