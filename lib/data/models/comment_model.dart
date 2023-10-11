import 'package:meta/meta.dart';
import 'dart:convert';

class Comments {
  List<Comment> comments;

  Comments({
    required this.comments,
  });

  factory Comments.fromRawJson(String str) =>
      Comments.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Comments.fromJson(Map<String, dynamic> json) => Comments(
        comments: List<Comment>.from(
            json["comments"].map((x) => Comment.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "comments": List<dynamic>.from(comments.map((x) => x.toJson())),
      };
}

class Comment {
  int commentId;
  String commentMessage;
  int commentLike;
  DateTime commentCreateAt;
  int postId;
  CreateByid createByid;

  Comment({
    required this.commentId,
    required this.commentMessage,
    required this.commentLike,
    required this.commentCreateAt,
    required this.postId,
    required this.createByid,
  });

  factory Comment.fromRawJson(String str) => Comment.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        commentId: json["comment_id"],
        commentMessage: json["comment_message"],
        commentLike: json["comment_like"],
        commentCreateAt: DateTime.parse(json["comment_createAt"]),
        postId: json["post_id"],
        createByid: CreateByid.fromJson(json["createByid"]),
      );

  Map<String, dynamic> toJson() => {
        "comment_id": commentId,
        "comment_message": commentMessage,
        "comment_like": commentLike,
        "comment_createAt": commentCreateAt.toIso8601String(),
        "post_id": postId,
        "createByid": createByid.toJson(),
      };
}

class CreateByid {
  int userId;
  String userEmail;
  String userName;
  String userCountry;
  String userPosition;
  String userAvatar;
  String userIsAdmin;
  DateTime userCreateAt;
  DateTime userUpdateAt;
  dynamic bandId;
  String bandType;

  CreateByid({
    required this.userId,
    required this.userEmail,
    required this.userName,
    required this.userCountry,
    required this.userPosition,
    required this.userAvatar,
    required this.userIsAdmin,
    required this.userCreateAt,
    required this.userUpdateAt,
    required this.bandId,
    required this.bandType,
  });

  factory CreateByid.fromRawJson(String str) =>
      CreateByid.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CreateByid.fromJson(Map<String, dynamic> json) => CreateByid(
        userId: json["user_id"],
        userEmail: json["user_email"],
        userName: json["user_name"],
        userCountry: json["user_country"],
        userPosition: json["user_position"],
        userAvatar: json["user_avatar"],
        userIsAdmin: json["user_isAdmin"],
        userCreateAt: DateTime.parse(json["user_createAt"]),
        userUpdateAt: DateTime.parse(json["user_updateAt"]),
        bandId: json["band_id"],
        bandType: json["band_Type"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "user_email": userEmail,
        "user_name": userName,
        "user_country": userCountry,
        "user_position": userPosition,
        "user_avatar": userAvatar,
        "user_isAdmin": userIsAdmin,
        "user_createAt": userCreateAt.toIso8601String(),
        "user_updateAt": userUpdateAt.toIso8601String(),
        "band_id": bandId,
        "band_Type": bandType,
      };
}
