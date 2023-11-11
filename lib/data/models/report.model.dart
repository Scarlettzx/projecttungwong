// To parse this JSON data, do
//
//     final reports = reportsFromJson(jsonString);

import 'dart:convert';

Reports reportsFromJson(String str) => Reports.fromJson(json.decode(str));

String reportsToJson(Reports data) => json.encode(data.toJson());

class Reports {
  List<Report>? reports;

  Reports({
    this.reports,
  });

  factory Reports.fromJson(Map<String, dynamic> json) => Reports(
        reports: json["reports"] == null
            ? []
            : List<Report>.from(
                json["reports"]!.map((x) => Report.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "reports": reports == null
            ? []
            : List<dynamic>.from(reports!.map((x) => x.toJson())),
      };
}

class Report {
  int? reportId;
  int? postId;
  String? postMessage;
  int? postLike;
  DateTime? postCreateAt;
  DateTime? postUpdateAt;
  String? postIsHide;
  int? countComment;
  BandDetails? bandDetails;
  CreateReportByuser? createReportByuser;
  BandDetails? createReportByband;
  CreateReportByuser? personDetails;

  Report({
    this.reportId,
    this.postId,
    this.postMessage,
    this.postLike,
    this.postCreateAt,
    this.postUpdateAt,
    this.postIsHide,
    this.countComment,
    this.bandDetails,
    this.createReportByuser,
    this.createReportByband,
    this.personDetails,
  });

  factory Report.fromJson(Map<String, dynamic> json) => Report(
        reportId: json["report_id"],
        postId: json["post_id"],
        postMessage: json["post_message"],
        postLike: json["post_like"],
        postCreateAt: json["post_createAt"] == null
            ? null
            : DateTime.parse(json["post_createAt"]),
        postUpdateAt: json["post_updateAt"] == null
            ? null
            : DateTime.parse(json["post_updateAt"]),
        postIsHide: json["post_isHide"],
        countComment: json["count_comment"],
        bandDetails: json["band_details"] == null
            ? null
            : BandDetails.fromJson(json["band_details"]),
        createReportByuser: json["createReportByuser"] == null
            ? null
            : CreateReportByuser.fromJson(json["createReportByuser"]),
        createReportByband: json["createReportByband"] == null
            ? null
            : BandDetails.fromJson(json["createReportByband"]),
        personDetails: json["person_details"] == null
            ? null
            : CreateReportByuser.fromJson(json["person_details"]),
      );

  Map<String, dynamic> toJson() => {
        "report_id": reportId,
        "post_id": postId,
        "post_message": postMessage,
        "post_like": postLike,
        "post_createAt": postCreateAt?.toIso8601String(),
        "post_updateAt": postUpdateAt?.toIso8601String(),
        "post_isHide": postIsHide,
        "count_comment": countComment,
        "band_details": bandDetails?.toJson(),
        "createReportByuser": createReportByuser?.toJson(),
        "createReportByband": createReportByband?.toJson(),
        "person_details": personDetails?.toJson(),
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

class CreateReportByuser {
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

  CreateReportByuser({
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

  factory CreateReportByuser.fromJson(Map<String, dynamic> json) =>
      CreateReportByuser(
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
