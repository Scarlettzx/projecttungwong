// To parse this JSON data, do
//
//     final bandModel = bandModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

BandModel bandModelFromJson(String str) => BandModel.fromJson(json.decode(str));

String bandModelToJson(BandModel data) => json.encode(data.toJson());

class BandModel {
    Band band;
    List<Member> member;

    BandModel({
        required this.band,
        required this.member,
    });

    factory BandModel.fromJson(Map<String, dynamic> json) => BandModel(
        band: Band.fromJson(json["Band"]),
        member: List<Member>.from(json["Member"].map((x) => Member.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "Band": band.toJson(),
        "Member": List<dynamic>.from(member.map((x) => x.toJson())),
    };
}

class Band {
    int bandId;
    String bandName;
    String bandCategory;
    String bandAvatar;
    DateTime bandCreateAt;
    DateTime bandUpdateAt;

    Band({
        required this.bandId,
        required this.bandName,
        required this.bandCategory,
        required this.bandAvatar,
        required this.bandCreateAt,
        required this.bandUpdateAt,
    });

    factory Band.fromJson(Map<String, dynamic> json) => Band(
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

class Member {
    int userId;
    String userEmail;
    String userName;
    String userCountry;
    String userPosition;
    String userAvatar;
    String userIsAdmin;
    DateTime userCreateAt;
    DateTime userUpdateAt;
    int bandId;
    String bandType;

    Member({
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

    factory Member.fromJson(Map<String, dynamic> json) => Member(
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
