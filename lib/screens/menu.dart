import 'package:amazone_clone_app/config/barrel_config.dart';
import 'package:amazone_clone_app/widgets/barrel_widgets.dart';
import 'package:flutter/material.dart';

class MenuScreeen extends StatelessWidget {
  const MenuScreeen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchBar(isReadOnly: true, backButton: false),
      body: Padding(
        padding: const EdgeInsets.all(6.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 2.2 / 3.5,
            crossAxisSpacing: 6,
            mainAxisSpacing: 6,
          ),
          itemCount: categoriesList.length,
          itemBuilder: (context, index) => CategoryMenuList(index: index),
        ),
      ),
    );
  }
}
