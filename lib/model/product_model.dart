class ProductModel {
  final String url;
  final String productName;
  final double cost;
  final int discount;
  final String uid;
  final String sellerName;
  final String sellerUid;
  final int rating;
  final int noOfRating;

  ProductModel({
    required this.cost,
    required this.discount,
    required this.noOfRating,
    required this.productName,
    required this.rating,
    required this.sellerName,
    required this.sellerUid,
    required this.uid,
    required this.url,
  });

  Map<String, dynamic> getJson() {
    return {
      'url': url,
      'product name': productName,
      'cost': cost,
      'discount': discount,
      'uid': uid,
      'seller uid': sellerUid,
      'seller name': sellerName,
      'rating': rating,
      'number of rating': noOfRating
    };
  }

  //doubt to be cleared
  //map for product model
  factory ProductModel.getModelFromJson({required Map<String, dynamic> json}) {
    return ProductModel(
        cost: json['cost'],
        discount: json['discount'],
        noOfRating: json['number of rating'],
        productName: json['product name'],
        rating: json['rating'],
        sellerName: json['seller name'],
        sellerUid: json['seller uid'],
        uid: json['uid'],
        url: json['url']);
  }
}
