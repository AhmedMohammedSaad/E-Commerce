import 'comment.dart';

class Comments {
  String? productId;
  List<Comment>? comments;

  Comments({this.productId, this.comments});

  factory Comments.fromJson(Map<String, dynamic> json) {
    return Comments(
      productId: json['product_id'] as String?,
      comments: (json['comments'] as List<dynamic>?)
          ?.map((e) => Comment.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> fromJson() {
    return {
      'product_id': productId,
      'comments': comments?.map((e) => e.fromJson()).toList(),
    };
  }
}
