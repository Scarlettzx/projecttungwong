// To parse this JSON data, do
//
//     final profileModel = profileModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ProfileModel profileModelFromJson(String str) =>
    ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
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

  ProfileModel({
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

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
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
