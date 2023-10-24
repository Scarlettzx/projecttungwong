// To parse this JSON data, do
//
//     final notifications = notificationsFromJson(jsonString);

import 'dart:convert';

Notifications notificationsFromJson(String str) => Notifications.fromJson(json.decode(str));

String notificationsToJson(Notifications data) => json.encode(data.toJson());

class Notifications {
    List<Notification>? notifications;

    Notifications({
        this.notifications,
    });

    factory Notifications.fromJson(Map<String, dynamic> json) => Notifications(
        notifications: json["notifications"] == null ? [] : List<Notification>.from(json["notifications"]!.map((x) => Notification.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "notifications": notifications == null ? [] : List<dynamic>.from(notifications!.map((x) => x.toJson())),
    };
}

class Notification {
    int? notiId;
    String? notiType;
    DateTime? notiCreateAt;
    PersonDetails? personDetails;
    BandDetails? bandDetails;

    Notification({
        this.notiId,
        this.notiType,
        this.notiCreateAt,
        this.personDetails,
        this.bandDetails,
    });

    factory Notification.fromJson(Map<String, dynamic> json) => Notification(
        notiId: json["noti_id"],
        notiType: json["noti_type"],
        notiCreateAt: json["noti_createAt"] == null ? null : DateTime.parse(json["noti_createAt"]),
        personDetails: json["person_details"] == null ? null : PersonDetails.fromJson(json["person_details"]),
        bandDetails: json["band_details"] == null ? null : BandDetails.fromJson(json["band_details"]),
    );

    Map<String, dynamic> toJson() => {
        "noti_id": notiId,
        "noti_type": notiType,
        "noti_createAt": notiCreateAt?.toIso8601String(),
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
        bandCreateAt: json["band_createAt"] == null ? null : DateTime.parse(json["band_createAt"]),
        bandUpdateAt: json["band_updateAt"] == null ? null : DateTime.parse(json["band_updateAt"]),
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
