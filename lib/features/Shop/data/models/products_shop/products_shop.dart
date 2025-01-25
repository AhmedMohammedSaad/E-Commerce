import 'rating.dart';

class ProductsShop {
  String? productId;
  DateTime? createdAt;
  String? productName;
  String? price;
  String? oldPrice;
  String? sale;
  String? productCategory;
  String? discription;
  String? imageUrl;
  bool? isSale;
  List<Rating>? rating;

  ProductsShop({
    this.productId,
    this.createdAt,
    this.productName,
    this.price,
    this.oldPrice,
    this.sale,
    this.productCategory,
    this.discription,
    this.imageUrl,
    this.isSale,
    this.rating,
  });

  factory ProductsShop.fromJson(Map<String, dynamic> json) {
    return ProductsShop(
      productId: json['product_id'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      productName: json['product_name'] as String?,
      price: json['price'] as String?,
      oldPrice: json['old_price'] as String?,
      sale: json['sale'] as String?,
      productCategory: json['product_category'] as String?,
      discription: json['discription'] as String?,
      imageUrl: json['image_url'] as String?,
      isSale: json['is_sale'] as bool?,
      rating: (json['rating'] as List<dynamic>?)
          ?.map((e) => Rating.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> fromJson() {
    return {
      'product_id': productId,
      'created_at': createdAt?.toIso8601String(),
      'product_name': productName,
      'price': price,
      'old_price': oldPrice,
      'sale': sale,
      'product_category': productCategory,
      'discription': discription,
      'image_url': imageUrl,
      'is_sale': isSale,
      'rating': rating?.map((e) => e.fromJson()).toList(),
    };
  }
}
