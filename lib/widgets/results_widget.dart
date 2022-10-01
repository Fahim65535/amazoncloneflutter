import 'package:amazone_clone_app/config/barrel_config.dart';
import '../model/barrel_model.dart';
import 'package:amazone_clone_app/widgets/barrel_widgets.dart';
import 'package:flutter/material.dart';

class ResultWidget extends StatelessWidget {
  final ProductModel product;
  const ResultWidget({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    SizedBox size = const SizedBox(height: 7);
    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: screenSize.width / 3,
              child: Image.network(product.url),
            ),
            size,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ResultStarWidget(rating: product.rating),
                const SizedBox(width: 5),
                Text(
                  product.noOfRating.toString(),
                  style: const TextStyle(color: activeCyanColor),
                )
              ],
            ),
            size,
            Text(
              product.productName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
            size,
            Cost(
              color: const Color.fromARGB(255, 110, 15, 9),
              cost: product.cost,
            )
          ],
        ),
      ),
    );
  }
}
