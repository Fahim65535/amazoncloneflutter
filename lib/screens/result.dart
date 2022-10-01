import 'package:flutter/material.dart';
import 'package:amazone_clone_app/widgets/barrel_widgets.dart';
import 'package:amazone_clone_app/model/barrel_model.dart';

class ResultScreen extends StatelessWidget {
  final String query;
  const ResultScreen({Key? key, required this.query}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: SearchBar(
          isReadOnly: false,
          backButton: true,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: 'Showing results for ',
                        style: TextStyle(fontSize: 17, color: Colors.black),
                      ),
                      TextSpan(
                        text: query,
                        style: const TextStyle(
                            fontSize: 17,
                            fontStyle: FontStyle.italic,
                            color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: 2.5 / 3.5),
                itemCount: 12,
                itemBuilder: (context, index) {
                  return ResultWidget(
                    product: ProductModel(
                        cost: 999.99,
                        discount: 20,
                        noOfRating: 1,
                        productName: '2-seat black leather couch ',
                        rating: 4,
                        sellerName: 'Seller Name',
                        sellerUid: 'xxxxxxxxxx',
                        uid: 'xxxxxxxx',
                        url:
                            'https://www.ikea.com/gb/en/images/products/vimle-2-seat-sofa-grann-bomstad-black__0817321_pe773961_s5.jpg?f=s'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
