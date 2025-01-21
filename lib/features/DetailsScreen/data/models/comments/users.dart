class Users {
  String? name;

  Users({this.name});

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      name: json['name'] as String?,
    );
  }

  Map<String, dynamic> fromJson() {
    return {
      'name': name,
    };
  }
}
