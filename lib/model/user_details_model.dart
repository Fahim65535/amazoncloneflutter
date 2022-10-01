class UserDetails {
  final String name;
  final String address;

  UserDetails({required this.address, required this.name});

  Map<String, dynamic> getJson() => {
        "Address": address,
        "Name": name,
      };

  //map for user deatils
  factory UserDetails.getFromJson(Map<String, dynamic> data) {
    return UserDetails(
      address: data["Address"],
      name: data["Name"],
    );
  }
}
