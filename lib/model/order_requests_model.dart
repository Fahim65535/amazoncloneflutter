class OrderRequestsModel {
  final String orderName;
  final String clientAddress;

  OrderRequestsModel({
    required this.clientAddress,
    required this.orderName,
  });

  //mapping order requests
  Map<String, dynamic> getJson() => {
        'order name': orderName,
        'client address': clientAddress,
      };

  //factory fucntion of getModelFromJson
  factory OrderRequestsModel.getModelFromJson(
      {required Map<String, dynamic> json}) {
    return OrderRequestsModel(
        clientAddress: json['client address'], orderName: json['order name']);
  }
}
