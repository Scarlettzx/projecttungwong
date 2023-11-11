// To parse this JSON data, do
//
//     final videos = videosFromJson(jsonString);

import 'dart:convert';

Videos videosFromJson(String str) => Videos.fromJson(json.decode(str));

String videosToJson(Videos data) => json.encode(data.toJson());

class Videos {
  List<Video>? videos;

  Videos({
    this.videos,
  });

  factory Videos.fromJson(Map<String, dynamic> json) => Videos(
        videos: json["videos"] == null
            ? []
            : List<Video>.from(json["videos"]!.map((x) => Video.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "videos": videos == null
            ? []
            : List<dynamic>.from(videos!.map((x) => x.toJson())),
      };
}

class Video {
  int? videoId;
  String? videoMessage;
  String? videoFilename;
  int? videoLike;
  DateTime? videoCreateAt;
  DateTime? videoUpdateAt;
  int? countComment;
  PersonDetails? personDetails;
  BandDetails? bandDetails;

  Video({
    this.videoId,
    this.videoMessage,
    this.videoFilename,
    this.videoLike,
    this.videoCreateAt,
    this.videoUpdateAt,
    this.countComment,
    this.personDetails,
    this.bandDetails,
  });

  factory Video.fromJson(Map<String, dynamic> json) => Video(
        videoId: json["video_id"],
        videoMessage: json["video_message"],
        videoFilename: json["video_filename"],
        videoLike: json["video_like"],
        videoCreateAt: json["video_createAt"] == null
            ? null
            : DateTime.parse(json["video_createAt"]),
        videoUpdateAt: json["video_updateAt"] == null
            ? null
            : DateTime.parse(json["video_updateAt"]),
            countComment: json["count_comment"],
        personDetails: json["person_details"] == null
            ? null
            : PersonDetails.fromJson(json["person_details"]),
        bandDetails: json["band_details"] == null
            ? null
            : BandDetails.fromJson(json["band_details"]),
      );

  Map<String, dynamic> toJson() => {
        "video_id": videoId,
        "video_message": videoMessage,
        "video_filename": videoFilename,
        "video_like": videoLike,
        "video_createAt": videoCreateAt?.toIso8601String(),
        "video_updateAt": videoUpdateAt?.toIso8601String(),
         "count_comment": countComment,
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
