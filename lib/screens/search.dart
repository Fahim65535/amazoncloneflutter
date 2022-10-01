import 'package:amazone_clone_app/widgets/barrel_widgets.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchBar(
        isReadOnly: false,
        backButton: true,
      ),
    );
  }
}
