// import 'package:meta/meta.dart';
// import 'dart:convert';

// class Posts {
//   List<Post> posts;

//   Posts({
//     required this.posts,
//   });

//   factory Posts.fromRawJson(String str) => Posts.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory Posts.fromJson(Map<String, dynamic> json) => Posts(
//         posts: List<Post>.from(json["posts"].map((x) => Post.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "posts": List<dynamic>.from(posts.map((x) => x.toJson())),
//       };
// }

// class Post {
//   int postId;
//   String postMessage;
//   int postLike;
//   DateTime postCreateAt;
//   DateTime postUpdateAt;
//   CreateByid createByid;

//   Post({
//     required this.postId,
//     required this.postMessage,
//     required this.postLike,
//     required this.postCreateAt,
//     required this.postUpdateAt,
//     required this.createByid,
//   });

//   factory Post.fromRawJson(String str) => Post.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory Post.fromJson(Map<String, dynamic> json) => Post(
//         postId: json["post_id"],
//         postMessage: json["post_message"],
//         postLike: json["post_like"],
//         postCreateAt: DateTime.parse(json["post_createAt"]),
//         postUpdateAt: DateTime.parse(json["post_updateAt"]),
//         createByid: CreateByid.fromJson(json["createByid"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "post_id": postId,
//         "post_message": postMessage,
//         "post_like": postLike,
//         "post_createAt": postCreateAt.toIso8601String(),
//         "post_updateAt": postUpdateAt.toIso8601String(),
//         "createByid": createByid.toJson(),
//       };
// }

// class CreateByid {
//   int userId;
//   String userEmail;
//   String userName;
//   String userCountry;
//   String userPosition;
//   String userAvatar;
//   String userIsAdmin;
//   DateTime userCreateAt;
//   DateTime userUpdateAt;
//   dynamic bandId;
//   String bandType;

//   CreateByid({
//     required this.userId,
//     required this.userEmail,
//     required this.userName,
//     required this.userCountry,
//     required this.userPosition,
//     required this.userAvatar,
//     required this.userIsAdmin,
//     required this.userCreateAt,
//     required this.userUpdateAt,
//     required this.bandId,
//     required this.bandType,
//   });

//   factory CreateByid.fromRawJson(String str) =>
//       CreateByid.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory CreateByid.fromJson(Map<String, dynamic> json) => CreateByid(
//         userId: json["user_id"],
//         userEmail: json["user_email"],
//         userName: json["user_name"],
//         userCountry: json["user_country"],
//         userPosition: json["user_position"],
//         userAvatar: json["user_avatar"],
//         userIsAdmin: json["user_isAdmin"],
//         userCreateAt: DateTime.parse(json["user_createAt"]),
//         userUpdateAt: DateTime.parse(json["user_updateAt"]),
//         bandId: json["band_id"],
//         bandType: json["band_Type"],
//       );

//   Map<String, dynamic> toJson() => {
//         "user_id": userId,
//         "user_email": userEmail,
//         "user_name": userName,
//         "user_country": userCountry,
//         "user_position": userPosition,
//         "user_avatar": userAvatar,
//         "user_isAdmin": userIsAdmin,
//         "user_createAt": userCreateAt.toIso8601String(),
//         "user_updateAt": userUpdateAt.toIso8601String(),
//         "band_id": bandId,
//         "band_Type": bandType,
//       };
// }
