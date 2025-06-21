import 'users.dart';

class Comment {
  Users? users;
  String? comment;
  String? commentId;
  DateTime? createdAt;
  String? forUserId;
  String? forProductId;

  Comment({
    this.users,
    this.comment,
    this.commentId,
    this.createdAt,
    this.forUserId,
    this.forProductId,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      users: json['users'] == null ? null : Users.fromJson(json['users'] as Map<String, dynamic>),
      comment: json['comment'] as String?,
      commentId: json['comment_id'] as String?,
      createdAt: json['created_at'] == null ? null : DateTime.parse(json['created_at'] as String),
      forUserId: json['for_user_id'] as String?,
      forProductId: json['for_product_id'] as String?,
    );
  }

  Map<String, dynamic> fromJson() {
    return {
      'users': users?.fromJson(),
      'comment': comment,
      'comment_id': commentId,
      'created_at': createdAt?.toIso8601String(),
      'for_user_id': forUserId,
      'for_product_id': forProductId,
    };
  }
}
