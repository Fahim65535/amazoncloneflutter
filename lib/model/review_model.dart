class ReviewModel {
  final String senderName;
  final String description;
  final int rating;

  ReviewModel({
    required this.description,
    required this.rating,
    required this.senderName,
  });

  //map for review model
  factory ReviewModel.getModelFromJson({required Map<String, dynamic> json}) {
    return ReviewModel(
      description: json['description'],
      rating: json['rating'],
      senderName: json['sender name'],
    );
  }

  Map<String, dynamic> getJson() => {
        'sender name': senderName,
        'description': description,
        'rating': rating,
      };
}
