class GetDataUser {
  final String name;
  final String id;
  final String email;
  // final String phone;
  // final String address;
  // final String image
  const GetDataUser({
    required this.id,
    required this.name,
    required this.email,
    // required this.phone,
    // required this.address,
    // required this.image,
  });

  // factory GetDataUser.fromJason(Map<String, dynamic> json) {
  //   return GetDataUser(
  //     id: json['user_id'],
  //     name: json['name'],
  //     email: json['email'],
  //   );
  // }
  factory GetDataUser.fromJson(Map<String, dynamic> json) {
    return GetDataUser(
      id: json['user_id'],
      name: json['name'],
      email: json['email'],
    );
  }
}
