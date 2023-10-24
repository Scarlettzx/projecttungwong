// To parse this JSON data, do
//
//     final comments = commentsFromJson(jsonString);

import 'dart:convert';

Comments commentsFromJson(String str) => Comments.fromJson(json.decode(str));

String commentsToJson(Comments data) => json.encode(data.toJson());

class Comments {
  List<Comment>? comments;

  Comments({
    this.comments,
  });

  factory Comments.fromJson(Map<String, dynamic> json) => Comments(
        comments: json["comments"] == null
            ? []
            : List<Comment>.from(
                json["comments"]!.map((x) => Comment.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "comments": comments == null
            ? []
            : List<dynamic>.from(comments!.map((x) => x.toJson())),
      };
}

class Comment {
  int? commentId;
  String? commentMessage;
  int? commentLike;
  DateTime? commentCreateAt;
  int? postId;
  PersonDetails? personDetails;
  BandDetails? bandDetails;

  Comment({
    this.commentId,
    this.commentMessage,
    this.commentLike,
    this.commentCreateAt,
    this.postId,
    this.personDetails,
    this.bandDetails,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        commentId: json["comment_id"],
        commentMessage: json["comment_message"],
        commentLike: json["comment_like"],
        commentCreateAt: json["comment_createAt"] == null
            ? null
            : DateTime.parse(json["comment_createAt"]),
        postId: json["post_id"],
        personDetails: json["person_details"] == null
            ? null
            : PersonDetails.fromJson(json["person_details"]),
        bandDetails: json["band_details"] == null
            ? null
            : BandDetails.fromJson(json["band_details"]),
      );

  Map<String, dynamic> toJson() => {
        "comment_id": commentId,
        "comment_message": commentMessage,
        "comment_like": commentLike,
        "comment_createAt": commentCreateAt?.toIso8601String(),
        "post_id": postId,
        "person_details": personDetails?.toJson(),
        "band_details": bandDetails?.toJson(),
      };
}

class BandDetails {
  int? bandId;
  String? bandName;
  String? bandCategory;
  String? bandAvatar;
  DateTime? bandCreateAt;
  DateTime? bandUpdateAt;

  BandDetails({
    this.bandId,
    this.bandName,
    this.bandCategory,
    this.bandAvatar,
    this.bandCreateAt,
    this.bandUpdateAt,
  });

  factory BandDetails.fromJson(Map<String, dynamic> json) => BandDetails(
        bandId: json["band_id"],
        bandName: json["band_name"],
        bandCategory: json["band_category"],
        bandAvatar: json["band_avatar"],
        bandCreateAt: json["band_createAt"] == null
            ? null
            : DateTime.parse(json["band_createAt"]),
        bandUpdateAt: json["band_updateAt"] == null
            ? null
            : DateTime.parse(json["band_updateAt"]),
      );

  Map<String, dynamic> toJson() => {
        "band_id": bandId,
        "band_name": bandName,
        "band_category": bandCategory,
        "band_avatar": bandAvatar,
        "band_createAt": bandCreateAt?.toIso8601String(),
        "band_updateAt": bandUpdateAt?.toIso8601String(),
      };
}

class PersonDetails {
  int? userId;
  String? userEmail;
  String? userName;
  String? userCountry;
  String? userPosition;
  String? userAvatar;
  String? userIsAdmin;
  DateTime? userCreateAt;
  DateTime? userUpdateAt;
  int? bandId;
  String? bandType;

  PersonDetails({
    this.userId,
    this.userEmail,
    this.userName,
    this.userCountry,
    this.userPosition,
    this.userAvatar,
    this.userIsAdmin,
    this.userCreateAt,
    this.userUpdateAt,
    this.bandId,
    this.bandType,
  });

  factory PersonDetails.fromJson(Map<String, dynamic> json) => PersonDetails(
        userId: json["user_id"],
        userEmail: json["user_email"],
        userName: json["user_name"],
        userCountry: json["user_country"],
        userPosition: json["user_position"],
        userAvatar: json["user_avatar"],
        userIsAdmin: json["user_isAdmin"],
        userCreateAt: json["user_createAt"] == null
            ? null
            : DateTime.parse(json["user_createAt"]),
        userUpdateAt: json["user_updateAt"] == null
            ? null
            : DateTime.parse(json["user_updateAt"]),
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
        "user_createAt": userCreateAt?.toIso8601String(),
        "user_updateAt": userUpdateAt?.toIso8601String(),
        "band_id": bandId,
        "band_Type": bandType,
      };
}
