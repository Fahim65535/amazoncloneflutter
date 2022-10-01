import 'package:amazone_clone_app/config/barrel_config.dart';
import 'package:amazone_clone_app/model/barrel_model.dart';
import 'package:amazone_clone_app/widgets/barrel_widgets.dart';
import 'package:flutter/material.dart';

class ReviewWidget extends StatelessWidget {
  final ReviewModel review;
  const ReviewWidget({Key? key, required this.review}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    SizedBox height = const SizedBox(height: 10);
    SizedBox width = const SizedBox(width: 5);

    return Padding(
      padding: const EdgeInsets.only(top: 30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //seller name
          Text(
            review.senderName,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),

          height,
          //star rating with rating scale
          Row(
            children: [
              SizedBox(
                width: screenSize.width / 5,
                child: FittedBox(
                  child: ResultStarWidget(rating: review.rating),
                ),
              ),
              width,
              Text(
                ratingScale[review.rating - 1],
                style: const TextStyle(fontWeight: FontWeight.bold),
              )
            ],
          ),
          height,

          //description
          Text(
            review.description,
            style: const TextStyle(fontWeight: FontWeight.w500),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}
