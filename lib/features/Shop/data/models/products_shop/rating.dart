class Rating {
  String? ratingId;
  DateTime? createdAt;
  int? ratingNum;
  String? forUserId;
  String? forProducteId;

  Rating({
    this.ratingId,
    this.createdAt,
    this.ratingNum,
    this.forUserId,
    this.forProducteId,
  });

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      ratingId: json['rating_id'] as String?,
      createdAt: json['created_at'] == null ? null : DateTime.parse(json['created_at'] as String),
      ratingNum: json['rating_num'] as int?,
      forUserId: json['for_user_id'] as String?,
      forProducteId: json['for_producte_id'] as String?,
    );
  }

  Map<String, dynamic> fromJson() {
    return {
      'rating_id': ratingId,
      'created_at': createdAt?.toIso8601String(),
      'rating_num': ratingNum,
      'for_user_id': forUserId,
      'for_producte_id': forProducteId,
    };
  }
}
