class Products {
  String? sale;
  String? price;
  dynamic isSale;
  String? imageUrl;
  String? oldPrice;
  DateTime? createdAt;
  String? productId;
  String? discription;
  String? productName;
  String? productCategory;

  Products({
    this.sale,
    this.price,
    this.isSale,
    this.imageUrl,
    this.oldPrice,
    this.createdAt,
    this.productId,
    this.discription,
    this.productName,
    this.productCategory,
  });

  factory Products.fromJson(Map<String, dynamic> json) {
    return Products(
      sale: json['sale'] as String?,
      price: json['price'] as String?,
      isSale: json['is_sale'] as dynamic,
      imageUrl: json['image_url'] as String?,
      oldPrice: json['old_price'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      productId: json['product_id'] as String?,
      discription: json['discription'] as String?,
      productName: json['product_name'] as String?,
      productCategory: json['product_category'] as String?,
    );
  }

  Map<String, dynamic> fromJson() {
    return {
      'sale': sale,
      'price': price,
      'is_sale': isSale,
      'image_url': imageUrl,
      'old_price': oldPrice,
      'created_at': createdAt?.toIso8601String(),
      'product_id': productId,
      'discription': discription,
      'product_name': productName,
      'product_category': productCategory,
    };
  }
}
