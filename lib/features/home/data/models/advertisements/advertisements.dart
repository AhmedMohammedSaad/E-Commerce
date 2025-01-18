class Advertisements {
  String? id;
  DateTime? createdAt;
  String? titleName;
  String? descreption;
  String? imageUrl;

  Advertisements({
    this.id,
    this.createdAt,
    this.titleName,
    this.descreption,
    this.imageUrl,
  });

  factory Advertisements.fromJson(Map<String, dynamic> json) {
    return Advertisements(
      id: json['id'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      titleName: json['title_name'] as String?,
      descreption: json['descreption'] as String?,
      imageUrl: json['image_url'] as String?,
    );
  }

  Map<String, dynamic> fromJson() {
    return {
      'id': id,
      'created_at': createdAt?.toIso8601String(),
      'title_name': titleName,
      'descreption': descreption,
      'image_url': imageUrl,
    };
  }
}
