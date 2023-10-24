// To parse this JSON data, do
//
//     final users = usersFromJson(jsonString);

import 'dart:convert';

Users usersFromJson(String str) => Users.fromJson(json.decode(str));

String usersToJson(Users data) => json.encode(data.toJson());

class Users {
    List<User>? users;

    Users({
        this.users,
    });

    factory Users.fromJson(Map<String, dynamic> json) => Users(
        users: json["users"] == null ? [] : List<User>.from(json["users"]!.map((x) => User.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "users": users == null ? [] : List<dynamic>.from(users!.map((x) => x.toJson())),
    };
}

class User {
    int? userId;
    String? userName;
    String? userEmail;
    String? userCountry;
    String? userPosition;
    String? userAvatar;
    String? userIsAdmin;
    DateTime? userCreateAt;
    DateTime? userUpdateAt;
    int? bandId;
    String? bandType;

    User({
        this.userId,
        this.userName,
        this.userEmail,
        this.userCountry,
        this.userPosition,
        this.userAvatar,
        this.userIsAdmin,
        this.userCreateAt,
        this.userUpdateAt,
        this.bandId,
        this.bandType,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        userId: json["user_id"],
        userName: json["user_name"],
        userEmail: json["user_email"],
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
        "user_name": userName,
        "user_email": userEmail,
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
