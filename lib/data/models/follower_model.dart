// To parse this JSON data, do
//
//     final followers = followersFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Followers followersFromJson(String str) => Followers.fromJson(json.decode(str));

String followersToJson(Followers data) => json.encode(data.toJson());

class Followers {
  List<Follower> followers;
  int followersLength;

  Followers({
    required this.followers,
    required this.followersLength,
  });

  factory Followers.fromJson(Map<String, dynamic> json) => Followers(
        followers: List<Follower>.from(
            json["followers"].map((x) => Follower.fromJson(x))),
        followersLength: json["followers_length"],
      );

  Map<String, dynamic> toJson() => {
        "followers": List<dynamic>.from(followers.map((x) => x.toJson())),
        "followers_length": followersLength,
      };
}

class Follower {
  int followersUid;
  PersonDetails personDetails;
  DateTime followersCreateAt;
  BandDetails bandDetails;

  Follower({
    required this.followersUid,
    required this.personDetails,
    required this.followersCreateAt,
    required this.bandDetails,
  });

  factory Follower.fromJson(Map<String, dynamic> json) => Follower(
        followersUid: json["followers_uid"],
        personDetails: PersonDetails.fromJson(json["person_details"]),
        followersCreateAt: DateTime.parse(json["followers_createAt"]),
        bandDetails: BandDetails.fromJson(json["band_details"]),
      );

  Map<String, dynamic> toJson() => {
        "followers_uid": followersUid,
        "person_details": personDetails.toJson(),
        "followers_createAt": followersCreateAt.toIso8601String(),
        "band_details": bandDetails.toJson(),
      };
}

class BandDetails {
  int bandId;
  String bandName;
  String bandCategory;
  String bandAvatar;
  DateTime bandCreateAt;
  DateTime bandUpdateAt;

  BandDetails({
    required this.bandId,
    required this.bandName,
    required this.bandCategory,
    required this.bandAvatar,
    required this.bandCreateAt,
    required this.bandUpdateAt,
  });

  factory BandDetails.fromJson(Map<String, dynamic> json) => BandDetails(
        bandId: json["band_id"],
        bandName: json["band_name"],
        bandCategory: json["band_category"],
        bandAvatar: json["band_avatar"],
        bandCreateAt: DateTime.parse(json["band_createAt"]),
        bandUpdateAt: DateTime.parse(json["band_updateAt"]),
      );

  Map<String, dynamic> toJson() => {
        "band_id": bandId,
        "band_name": bandName,
        "band_category": bandCategory,
        "band_avatar": bandAvatar,
        "band_createAt": bandCreateAt.toIso8601String(),
        "band_updateAt": bandUpdateAt.toIso8601String(),
      };
}

class PersonDetails {
  int userId;
  String userEmail;
  String userName;
  String userCountry;
  String userPosition;
  String userAvatar;
  String userIsAdmin;
  DateTime userCreateAt;
  DateTime userUpdateAt;
  int? bandId;
  String bandType;

  PersonDetails({
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

  factory PersonDetails.fromJson(Map<String, dynamic> json) => PersonDetails(
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
