import 'package:amazone_clone_app/config/barrel_config.dart';
import 'package:flutter/material.dart';
import '../screens/barrel_screens.dart';

class CategoryMenuList extends StatelessWidget {
  final int index;

  const CategoryMenuList({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return ResultScreen(query: categoriesList[index]);
            },
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 4,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.network(categoryLogos[index]),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    categoriesList[index],
                    style: const TextStyle(
                        fontWeight: FontWeight.w500, letterSpacing: 0.5),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
