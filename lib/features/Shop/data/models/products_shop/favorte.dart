class Favorte {
  bool? isbool;
  DateTime? createdAt;
  String? favorteId;
  String? forUserId;
  String? forProductId;

  Favorte({
    this.isbool,
    this.createdAt,
    this.favorteId,
    this.forUserId,
    this.forProductId,
  });

  factory Favorte.fromJson(Map<String, dynamic> json) {
    return Favorte(
      isbool: json['bool'] as bool?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      favorteId: json['favorte_id'] as String?,
      forUserId: json['for_user_id'] as String?,
      forProductId: json['for_product_id'] as String?,
    );
  }

  Map<String, dynamic> fromJson() {
    return {
      'bool': bool,
      'created_at': createdAt?.toIso8601String(),
      'favorte_id': favorteId,
      'for_user_id': forUserId,
      'for_product_id': forProductId,
    };
  }
}
