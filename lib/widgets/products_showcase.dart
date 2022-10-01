import 'package:amazone_clone_app/config/barrel_config.dart';
import 'package:flutter/material.dart';

class ProductShowcase extends StatelessWidget {
  final String title;
  final List<Widget> children;
  const ProductShowcase({
    Key? key,
    required this.title,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    double height = screenSize.height / 5.8;
    double titleHeight = 20;
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(top: 12),
      height: height,
      width: double.infinity,
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: titleHeight,
            child: Row(
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 6),
                const Text(
                  'Show more',
                  style: TextStyle(color: activeCyanColor),
                ),
              ],
            ),
          ),
          SizedBox(
            height: height - (titleHeight + 32),
            width: screenSize.width,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: children,
            ),
          ),
        ],
      ),
    );
  }
}
