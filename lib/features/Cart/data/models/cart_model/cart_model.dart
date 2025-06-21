import 'products.dart';

class CartModel {
  String? cartId;
  DateTime? createdAt;
  bool? isCart;
  String? forUserId;
  String? forProductId;
  Products? products;

  CartModel({
    this.cartId,
    this.createdAt,
    this.isCart,
    this.forUserId,
    this.forProductId,
    this.products,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      cartId: json['cart_id'] as String?,
      createdAt: json['created_at'] == null ? null : DateTime.parse(json['created_at'] as String),
      isCart: json['is_cart'] as bool?,
      forUserId: json['for_user_id'] as String?,
      forProductId: json['for_product_id'] as String?,
      products: json['products'] == null ? null : Products.fromJson(json['products'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> fromJson() {
    return {
      'cart_id': cartId,
      'created_at': createdAt?.toIso8601String(),
      'is_cart': isCart,
      'for_user_id': forUserId,
      'for_product_id': forProductId,
      'products': products?.fromJson(),
    };
  }
}
