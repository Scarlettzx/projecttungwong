import 'dart:convert';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:get_time_ago/get_time_ago.dart';
import 'package:iconly/iconly.dart';

import '../controller/main_wrapper_controller.dart';
import '../controller/poststest_controller.dart';
import '../controller/reports.controller.dart';
import '../services/bandservice.dart';
import '../utils/color.constants.dart';
import '../utils/config.dart';
import 'another_profile_tab.dart';

class ReportTab extends StatefulWidget {
  const ReportTab({super.key});

  @override
  State<ReportTab> createState() => _ReportTabState();
}

class _ReportTabState extends State<ReportTab> {
  String? bandName;
  String? userName;
  final BandService bandService = Get.find();
  final MainWrapperController _mainWrapperController =
      Get.find<MainWrapperController>();
  final PoststestController _postsController = Get.put(PoststestController());
  final ReportsController _reportsController = Get.put(ReportsController());

  @override
  void initState() {
    super.initState();
    _reportsController.getAllreports();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Obx(
        () => Column(
          children: _reportsController.reports.reversed.map((reportsAlldata) {
            DateTime datetime = reportsAlldata.postCreateAt!;
            final isBand = (reportsAlldata.bandDetails != null);
            return Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.transparent,
                        backgroundImage: NetworkImage(
                          reportsAlldata.createReportByband != null
                              ? '${Config.getImageBand}${reportsAlldata.createReportByband!.bandAvatar}'
                              : reportsAlldata.createReportByuser != null
                                  ? '${Config.getImage}${reportsAlldata.createReportByuser!.userAvatar}'
                                  : '${Config.getImageBand}${reportsAlldata.createReportByband!.bandAvatar}',
                        ),
                        radius: 20,
                      ),
                      Container(
                        alignment: AlignmentDirectional.centerStart,
                        // color: Colors.black,
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          (reportsAlldata.createReportByband != null)
                              ? reportsAlldata.createReportByband!.bandName ??
                                  'Unknown Band'
                              : (reportsAlldata.createReportByuser != null)
                                  ? reportsAlldata
                                          .createReportByuser!.userName ??
                                      'Unknown User'
                                  : 'Unknown',
                          style: TextStyle(
                            color: ColorConstants.gray400,
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                      Text('ได้รีพอร์ตโพสต์นี้'),
                      IconButton(
                        onPressed: null,
                        icon: Icon(
                          IconlyBold.arrow_down_square,
                        ),
                      )
                    ],
                  ),
                ),
                Slidable(
                  endActionPane: ActionPane(
                    motion: const StretchMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (BuildContext context) async {
                          var postid = reportsAlldata.postId!;
                          await dohidepost(context, postid);
                        },
                        flex: 3,
                        backgroundColor: Colors.green,
                        icon: IconlyBold.hide,
                        foregroundColor: Colors.white,
                      ),
                      SlidableAction(
                        flex: 4,
                        onPressed: (BuildContext context) async {
                          var reportid = reportsAlldata.reportId!;
                          print(reportid);
                          // _reportsController.report.id.value =
                          await doDeleteReport(context, reportid);
                        },
                        backgroundColor: Colors.red,
                        icon: IconlyBold.delete,
                        foregroundColor: Colors.white,
                      ),
                    ],
                  ),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    elevation: 8,
                    margin: const EdgeInsets.all(15),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                            color: ColorConstants.appColors, width: 0.7),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                          right: 20,
                          top: 10,
                          left: 20,
                          bottom: 20,
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 30),
                                  child: InkWell(
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      if (isBand) {
                                        var bandid =
                                            reportsAlldata.bandDetails!.bandId;
                                        bandService.profileController
                                            .anotherprofileid.value = bandid!;
                                        bandService.profileController
                                            .anotherProfileType.value = "band";
                                      } else {
                                        var userid = reportsAlldata
                                            .personDetails!.userId;
                                        bandService.profileController
                                            .anotherprofileid.value = userid!;
                                        bandService.profileController
                                            .anotherProfileType.value = "user";
                                      }

                                      try {
                                        await bandService.profileController
                                            .checkfollow();
                                        await bandService.notificationController
                                            .checkSendEmail();
                                        if (isBand) {
                                          await bandService
                                              .notificationController
                                              .checkInviteBand();
                                        }
                                      } catch (e) {
                                        print("Error: $e");
                                        // Handle the error as needed
                                      }
                                    },
                                    child: CircleAvatar(
                                      backgroundColor: Colors.transparent,
                                      backgroundImage: NetworkImage(
                                        isBand
                                            ? '${Config.getImageBand}${reportsAlldata.bandDetails!.bandAvatar}'
                                            : '${Config.getImage}${reportsAlldata.personDetails!.userAvatar}',
                                      ),
                                      radius: 30,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 20),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 250,
                                      height: 30,
                                      color: Colors.transparent,
                                      child: Stack(
                                        children: [
                                          Text(
                                            isBand
                                                ? reportsAlldata
                                                    .bandDetails!.bandName!
                                                : reportsAlldata
                                                    .personDetails!.userName!,
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        isBand
                                            ? reportsAlldata
                                                .bandDetails!.bandCategory!
                                            : reportsAlldata
                                                .personDetails!.userPosition!,
                                        style: TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                    if (!isBand)
                                      SizedBox(
                                        height: 10,
                                      ),
                                    if (!isBand)
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          reportsAlldata
                                              .personDetails!.userCountry!,
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(reportsAlldata.postMessage!),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Divider(
                              thickness: 2,
                            ),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.favorite_sharp,
                                    size: 30,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                IconButton(
                                  onPressed: () {
                                    // Handle comment button click
                                  },
                                  icon: Icon(
                                    Icons.comment_rounded,
                                    size: 30,
                                  ),
                                ),
                                SizedBox(width: 2),
                                Text('${reportsAlldata.countComment}'),
                                SizedBox(width: 80),
                                Text(GetTimeAgo.parse(datetime))
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }

  Future doDeleteReport(
    BuildContext context,
    int reportid,
  ) async {
    var rs = await _reportsController.deleteReport(reportid);
    print(rs.body);
    var jsonRes = jsonDecode(rs.body);
    if (rs.statusCode == 200) {
      if (jsonRes['success'] == 1) {
        showCustomSnackBar('Congratulations', 'deleteReport Successfully',
            ColorConstants.appColors, ContentType.success);
        _reportsController.getAllreports();
      }
      // }
    } else if (rs.statusCode == 500) {
      showCustomSnackBar(
          'deleteReport Failed',
          'Database connection error',
          Colors.red, // สีแดงหรือสีที่คุณต้องการ
          ContentType.failure);
    } else if (rs.statusCode == 498) {
      _mainWrapperController.logOut();
      showCustomSnackBar(
          'deleteReport Failed',
          "Invalid token",
          Colors.red, // สีแดงหรือสีที่คุณต้องการ
          ContentType.failure);
      // การส่งข้อมูลไม่สำเร็จ
    }
  }

  Future dohidepost(BuildContext context, int postid) async {
    var rs = await _reportsController.hidePost(postid);
    print(rs.body);
    var jsonRes = jsonDecode(rs.body);
    if (rs.statusCode == 200) {
      if (jsonRes['success'] == 1) {
        showCustomSnackBar('Congratulations', 'deleteReport Successfully',
            ColorConstants.appColors, ContentType.success);
        // _reportsController.getAllreports();
        await _postsController.getPosts();
      }
      // }
    } else if (rs.statusCode == 500) {
      showCustomSnackBar(
          'deleteReport Failed',
          'Database connection error',
          Colors.red, // สีแดงหรือสีที่คุณต้องการ
          ContentType.failure);
    } else if (rs.statusCode == 498) {
      _mainWrapperController.logOut();
      showCustomSnackBar(
          'deleteReport Failed',
          "Invalid token",
          Colors.red, // สีแดงหรือสีที่คุณต้องการ
          ContentType.failure);
      // การส่งข้อมูลไม่สำเร็จ
    }
  }

  void showCustomSnackBar(
      String title, String message, Color color, ContentType contentType) {
    // late final ContentType contentType;
    final snackBar = SnackBar(
      /// need to set following properties for best effect of awesome_snackbar_content
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: title,
        message: message,

        /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
        contentType: contentType,
        color: color,
      ),
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
