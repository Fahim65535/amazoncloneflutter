import 'package:amazone_clone_app/config/barrel_config.dart';
import 'package:amazone_clone_app/widgets/barrel_widgets.dart';
import 'package:flutter/material.dart';

class ProductCartInfo extends StatelessWidget {
  final String productName;
  final double cost;
  final String sellerName;
  const ProductCartInfo(
      {Key? key,
      required this.productName,
      required this.cost,
      required this.sellerName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    return SizedBox(
      width: screenSize.width / 2,
      child: Padding(
        padding: const EdgeInsets.only(left: 15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                productName,
                maxLines: 1,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 17,
                  letterSpacing: 0.4,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Cost(color: Colors.black, cost: cost),
            const SizedBox(height: 12),
            Center(
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                        text: 'Sold by ',
                        style:
                            TextStyle(color: Colors.grey[700], fontSize: 14)),
                    TextSpan(
                        text: sellerName,
                        style: const TextStyle(
                            color: activeCyanColor, fontSize: 14)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
