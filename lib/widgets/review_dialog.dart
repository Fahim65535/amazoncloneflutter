import 'package:amazone_clone_app/model/barrel_model.dart';
import 'package:amazone_clone_app/provider/user_details_provider.dart';
import 'package:amazone_clone_app/resources/cloudfirestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rating_dialog/rating_dialog.dart';

class ReviewDialog extends StatelessWidget {
  final String productUid;
  const ReviewDialog({Key? key, required this.productUid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RatingDialog(
      initialRating: 1.0,
      title: const Text(
        'Type in a review for this product',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
      submitButtonText: 'Send',
      commentHint: 'Type here',
      onSubmitted: (RatingDialogResponse response) async {
        CloudFirestore().uploadReview(
            reviewModel: ReviewModel(
                description: response.comment,
                rating: response.rating.toInt(),
                senderName:
                    Provider.of<UserDetailsProvider>(context, listen: false)
                        .userDetails
                        .name),
            productUid: productUid);
      },
    );
  }
}
