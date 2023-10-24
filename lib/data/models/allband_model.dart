// To parse this JSON data, do
//
//     final bands = bandsFromJson(jsonString);

import 'dart:convert';

Bands bandsFromJson(String str) => Bands.fromJson(json.decode(str));

String bandsToJson(Bands data) => json.encode(data.toJson());

class Bands {
    List<Band>? bands;

    Bands({
        this.bands,
    });

    factory Bands.fromJson(Map<String, dynamic> json) => Bands(
        bands: json["bands"] == null ? [] : List<Band>.from(json["bands"]!.map((x) => Band.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "bands": bands == null ? [] : List<dynamic>.from(bands!.map((x) => x.toJson())),
    };
}

class Band {
    String? bandName;
    String? bandCategory;
    String? bandAvatar;
    DateTime? bandCreateAt;
    DateTime? bandUpdateAt;
    CreateBandBy? createBandBy;

    Band({
        this.bandName,
        this.bandCategory,
        this.bandAvatar,
        this.bandCreateAt,
        this.bandUpdateAt,
        this.createBandBy,
    });

    factory Band.fromJson(Map<String, dynamic> json) => Band(
        bandName: json["band_name"],
        bandCategory: json["band_category"],
        bandAvatar: json["band_avatar"],
        bandCreateAt: json["band_createAt"] == null ? null : DateTime.parse(json["band_createAt"]),
        bandUpdateAt: json["band_updateAt"] == null ? null : DateTime.parse(json["band_updateAt"]),
        createBandBy: json["createBandBy"] == null ? null : CreateBandBy.fromJson(json["createBandBy"]),
    );

    Map<String, dynamic> toJson() => {
        "band_name": bandName,
        "band_category": bandCategory,
        "band_avatar": bandAvatar,
        "band_createAt": bandCreateAt?.toIso8601String(),
        "band_updateAt": bandUpdateAt?.toIso8601String(),
        "createBandBy": createBandBy?.toJson(),
    };
}

class CreateBandBy {
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

    CreateBandBy({
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

    factory CreateBandBy.fromJson(Map<String, dynamic> json) => CreateBandBy(
        userId: json["user_id"],
        userEmail: json["user_email"],
        userName: json["user_name"],
        userCountry: json["user_country"],
        userPosition: json["user_position"],
        userAvatar: json["user_avatar"],
        userIsAdmin: json["user_isAdmin"],
        userCreateAt: json["user_createAt"] == null ? null : DateTime.parse(json["user_createAt"]),
        userUpdateAt: json["user_updateAt"] == null ? null : DateTime.parse(json["user_updateAt"]),
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
