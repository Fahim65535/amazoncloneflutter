import 'package:amazone_clone_app/config/barrel_config.dart';
import 'package:flutter/material.dart';
import '../screens/barrel_screens.dart';

class CategoriesListView extends StatelessWidget {
  const CategoriesListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kAppBarHeight,
      // width: double.infinity,
      color: Colors.white,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categoriesList.length,
        itemBuilder: (context, index) {
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
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                      categoryLogos[index],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(categoriesList[index]),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
