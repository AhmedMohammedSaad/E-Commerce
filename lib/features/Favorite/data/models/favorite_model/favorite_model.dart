import 'products.dart';

class FavoriteModel {
  String? favorteId;
  DateTime? createdAt;
  bool? isbool;
  String? forUserId;
  String? forProductId;
  Products? products;

  FavoriteModel({
    this.favorteId,
    this.createdAt,
    this.isbool,
    this.forUserId,
    this.forProductId,
    this.products,
  });

  factory FavoriteModel.fromJson(Map<String, dynamic> json) {
    return FavoriteModel(
      favorteId: json['favorte_id'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      isbool: json['bool'] as bool?,
      forUserId: json['for_user_id'] as String?,
      forProductId: json['for_product_id'] as String?,
      products: json['products'] == null
          ? null
          : Products.fromJson(json['products'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> fromJson() {
    return {
      'favorte_id': favorteId,
      'created_at': createdAt?.toIso8601String(),
      'bool': bool,
      'for_user_id': forUserId,
      'for_product_id': forProductId,
      'products': products?.fromJson(),
    };
  }
}
