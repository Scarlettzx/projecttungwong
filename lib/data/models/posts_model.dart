// To parse this JSON data, do
//
//     final posts = postsFromJson(jsonString);

import 'dart:convert';

Posts postsFromJson(String str) => Posts.fromJson(json.decode(str));

String postsToJson(Posts data) => json.encode(data.toJson());

class Posts {
  List<Post>? posts;

  Posts({
    this.posts,
  });

  factory Posts.fromJson(Map<String, dynamic> json) => Posts(
        posts: json["posts"] == null
            ? []
            : List<Post>.from(json["posts"]!.map((x) => Post.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "posts": posts == null
            ? []
            : List<dynamic>.from(posts!.map((x) => x.toJson())),
      };
}

class Post {
  int? postId;
  String? postMessage;
  int? postLike;
  DateTime? postCreateAt;
  DateTime? postUpdateAt;
  PersonDetails? personDetails;
  BandDetails? bandDetails;

  Post({
    this.postId,
    this.postMessage,
    this.postLike,
    this.postCreateAt,
    this.postUpdateAt,
    this.personDetails,
    this.bandDetails,
  });

  factory Post.fromJson(Map<String, dynamic> json) => Post(
    postId: json["post_id"],
        postMessage: json["post_message"],
        postLike: json["post_like"],
        postCreateAt: json["post_createAt"] == null
            ? null
            : DateTime.parse(json["post_createAt"]),
        postUpdateAt: json["post_updateAt"] == null
            ? null
            : DateTime.parse(json["post_updateAt"]),
        personDetails: json["person_details"] == null
            ? null
            : PersonDetails.fromJson(json["person_details"]),
        bandDetails: json["band_details"] == null
            ? null
            : BandDetails.fromJson(json["band_details"]),
      );

  Map<String, dynamic> toJson() => {
    "post_id": postId,
        "post_message": postMessage,
        "post_like": postLike,
        "post_createAt": postCreateAt?.toIso8601String(),
        "post_updateAt": postUpdateAt?.toIso8601String(),
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
  dynamic bandId;
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
