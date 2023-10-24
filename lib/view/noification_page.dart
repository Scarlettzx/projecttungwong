import 'dart:convert';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_time_ago/get_time_ago.dart';
import 'package:http/src/response.dart';
import 'package:iconly/iconly.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:project/controller/main_wrapper_controller.dart';
import 'package:project/controller/notification_controller.dart';
import 'package:project/controller/profile_controller.dart';
import 'package:project/data/models/follower_model.dart';
import 'package:project/services/bandservice.dart';
import 'package:project/utils/color.constants.dart';
import 'package:project/utils/config.dart';

import 'another_profile_tab.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  // final NotificationController notificationController =
  bool _saving = false;
  //     Get.put(NotificationController());
  // final MainWrapperController _mainWrapperController =
  //     Get.find<MainWrapperController>();
  final MainWrapperController _mainWrapperController =
      Get.find<MainWrapperController>();
  late int userid;
  late int bandid;
  final BandService bandService = Get.find();
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _saving,
      progressIndicator: LoadingAnimationWidget.bouncingBall(
        size: 50,
        color: ColorConstants.appColors,
      ),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Notifications"),
          backgroundColor: ColorConstants.appColors,
          toolbarHeight: double.parse("70"),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: FutureBuilder<void>(
                      future:
                          bandService.notificationController.getNotifications(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          // กำลังโหลดข้อมูล แสดง Indicator หรือข้อความ "กำลังโหลด..."
                          return Center(
                            child: LoadingAnimationWidget.dotsTriangle(
                              size: 50,
                              color: ColorConstants.appColors,
                            ),
                          );
                        } else if (snapshot.hasError) {
                          // กรณีเกิดข้อผิดพลาด
                          return Center(
                              child: Text('เกิดข้อผิดพลาด: ${snapshot.error}'));
                        } else if (bandService
                                .notificationController.notis.isEmpty ||
                            bandService.notificationController.notis == []) {
                          // ถ้าไม่มีข้อมูล
                          return Center(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                IconlyBold.notification,
                                size: 200,
                                color: ColorConstants.gray50,
                              ),
                              Text(
                                'not have notifications',
                                style: TextStyle(
                                    color: ColorConstants.gray100,
                                    fontSize: 20),
                              ),
                            ],
                          ));
                        } else {
                          return Obx(
                            () => ListView.builder(
                              itemCount: bandService
                                  .notificationController.notis.length,
                              itemBuilder: (context, i) {
                                var reverseindex = bandService
                                        .notificationController.notis.length -
                                    1 -
                                    i;
                                DateTime datetime = bandService
                                    .notificationController
                                    .notis[reverseindex]
                                    .notiCreateAt!;
                                final isBand = (bandService
                                        .notificationController
                                        .notis[reverseindex]
                                        .bandDetails !=
                                    null);
                                final notidata = bandService
                                    .notificationController.notis[reverseindex];

                                // bandService
                                //     .notificationController
                                //     .invitebyuserid
                                //     .value = notidata.personDetails!.userId!;
                                // ทำสิ่งที่คุณต้องการด้วยข้อมูล personIdData
                                return Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Stack(children: [
                                      Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          side: BorderSide(
                                              width: 1,
                                              color: ColorConstants.appColors),
                                        ),
                                        child: ListTile(
                                          leading: InkWell(
                                            onTap: () {
                                              if (isBand) {
                                                var bandid = notidata
                                                    .bandDetails!.bandId;
                                                // ! เอาค่าbandidเก็บใน anotherprofileid เพื่อจะเข้า method
                                                bandService
                                                    .profileController
                                                    .anotherprofileid
                                                    .value = bandid!;
                                                bandService
                                                    .profileController
                                                    .anotherProfileType
                                                    .value = "band";
                                                print(bandService
                                                    .profileController
                                                    .anotherProfileType
                                                    .value);
                                                print(bandService
                                                    .profileController
                                                    .anotherprofileid
                                                    .value);
                                                bandService.profileController
                                                    .checkfollow();
                                                Get.to(
                                                    transition:
                                                        Transition.downToUp,
                                                    AnotherProfileTab(
                                                      anotherpofileid: bandid,
                                                    ));
                                              } else {
                                                var userid = notidata
                                                    .personDetails!.userId;
                                                bandService
                                                    .profileController
                                                    .anotherprofileid
                                                    .value = userid!;
                                                bandService
                                                    .profileController
                                                    .anotherProfileType
                                                    .value = "user";
                                                print(bandService
                                                    .profileController
                                                    .anotherProfileType
                                                    .value);
                                                print(bandService
                                                    .profileController
                                                    .anotherprofileid
                                                    .value);
                                                bandService.profileController
                                                    .checkfollow();
                                                Get.to(
                                                    transition:
                                                        Transition.downToUp,
                                                    AnotherProfileTab(
                                                      anotherpofileid: userid,
                                                    ));
                                              }
                                            },
                                            child: CircleAvatar(
                                              backgroundColor:
                                                  Colors.transparent,
                                              backgroundImage: (isBand)
                                                  ? NetworkImage(
                                                      '${Config.getImageBand}${notidata.bandDetails!.bandAvatar}',
                                                    )
                                                  : NetworkImage(
                                                      '${Config.getImage}${notidata.personDetails!.userAvatar}'),
                                              radius: 26,
                                            ),
                                          ),
                                          title: Container(
                                            child: Column(children: [
                                              Row(
                                                children: [
                                                  Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 5, top: 10),
                                                      child: Container(
                                                        color:
                                                            Colors.transparent,
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            2,
                                                        child: Wrap(children: [
                                                          if (notidata
                                                                  .notiType ==
                                                              "2") ...[
                                                            (isBand)
                                                                ? Text(
                                                                    '${notidata.bandDetails!.bandName} ได้เชิญคุณเข้าร่วมวง ',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            15,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  )
                                                                : Text(
                                                                    '${notidata.personDetails!.userName} ได้เชิญคุณเข้าร่วมวง ',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            15,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                          ],
                                                            if (notidata
                                                                  .notiType ==
                                                              "1") ...[
                                                            (isBand)
                                                                ? Text(
                                                                    '${notidata.bandDetails!.bandName} ได้ส่ง Email เสนองานให้วงดนตรีของคุณ',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            15,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  )
                                                                : Text(
                                                                    '${notidata.personDetails!.userName} ได้ส่ง Email เสนองานให้คุณ ',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            15,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                          ]
                                                        ]),
                                                      ))
                                                ],
                                              ),
                                              SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.05,
                                              ),
                                              Row(
                                                children: [
                                                  if (notidata.notiType ==
                                                      "2") ...[
                                                    ElevatedButton(
                                                        child: Text("Accept".toUpperCase(),
                                                            style: TextStyle(
                                                                fontSize: 12)),
                                                        style: ButtonStyle(
                                                            foregroundColor:
                                                                MaterialStateProperty.all<Color>(Colors
                                                                    .white),
                                                            backgroundColor:
                                                                MaterialStateProperty.all<Color>(
                                                                    ColorConstants
                                                                        .appColors),
                                                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                                RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(20),
                                                                    side: BorderSide(color: ColorConstants.appColors)))),
                                                        onPressed: () async {
                                                          if (isBand) {
                                                            setState(() {
                                                              bandid = notidata
                                                                  .bandDetails!
                                                                  .bandId!;
                                                            });

                                                            await doInviteband(
                                                                null, bandid);
                                                          } else {
                                                            setState(() {
                                                              userid = notidata
                                                                  .personDetails!
                                                                  .userId!;
                                                            });
                                                            await doInviteband(
                                                                userid, null);
                                                          }
                                                        }),
                                                    SizedBox(
                                                      width: 30,
                                                    ),
                                                    ElevatedButton(
                                                      child: Text(
                                                          "deny".toUpperCase(),
                                                          style: TextStyle(
                                                              fontSize: 12)),
                                                      style: ButtonStyle(
                                                          foregroundColor:
                                                              MaterialStateProperty.all<Color>(
                                                                  Colors.white),
                                                          backgroundColor:
                                                              MaterialStateProperty.all<Color>(
                                                                  Colors
                                                                      .redAccent),
                                                          shape: MaterialStateProperty.all<
                                                                  RoundedRectangleBorder>(
                                                              RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius.circular(20),
                                                                  side: BorderSide(color: Colors.redAccent)))),
                                                      onPressed: () async {
                                                        if (isBand) {
                                                          bandService
                                                                  .notificationController
                                                                  .invitebybandid
                                                                  .value =
                                                              notidata
                                                                  .bandDetails!
                                                                  .bandId!;
                                                          print(bandService
                                                              .notificationController
                                                              .invitebybandid
                                                              .value);
                                                          await bandService
                                                              .notificationController
                                                              .deleteNotiInvitebandbyband()
                                                              .then((_) =>
                                                                  setState(
                                                                      () {}));
                                                        } else {
                                                          bandService
                                                                  .notificationController
                                                                  .invitebyuserid
                                                                  .value =
                                                              notidata
                                                                  .personDetails!
                                                                  .userId!;
                                                          print(bandService
                                                              .notificationController
                                                              .invitebyuserid
                                                              .value);
                                                          await bandService
                                                              .notificationController
                                                              .deleteNotiInvitebandbyuser()
                                                              .then((_) =>
                                                                  setState(
                                                                      () {}));
                                                        }

                                                        // // หลังจากลบรายการแจ้งเตือนแล้ว คุณควรอัปเดตรายการ notis โดยลบรายการที่มีการประมวลผล
                                                        // bandService
                                                        //     .notificationController
                                                        //     .notis
                                                        //     .remove(notidata);
                                                      },
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    
                                                  ]
                                                ],
                                              )
                                            ]),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        bottom:
                                            10, // Adjust this value to position the timestamp as desired
                                        right:
                                            15, // Adjust this value to position the timestamp as desired
                                        child: Text(
                                          GetTimeAgo.parse(datetime),
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black54),
                                        ),
                                      )
                                    ]));
                              },
                            ),
                          );
                        }
                      }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ? void showCustomSnackBar(String title, String message, Color color)
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

  Future doInviteband(int? userid, int? bandid) async {
    print("userid");
    print(userid);
    print("bandid");
    print(bandid);
    // ignore: prefer_typing_uninitialized_variables
    var rs;
    if (userid != null) {
      rs = await bandService.notificationController
          .acceptInviteJoinBandbyuser(userid);
    }
    if (bandid != null) {
      rs = await bandService.notificationController
          .acceptInviteJoinBandbyband(bandid);
    }

    var jsonRes = jsonDecode(rs.body);
    print(rs.body);
    if (rs.statusCode == 200) {
      if (jsonRes['success'] == 1) {
        // ! redirect

        showCustomSnackBar('Congratulations', 'Accept Successfully',
            ColorConstants.appColors, ContentType.success);

        bandService.notificationController.getNotifications();
      }
      // }
    } else if (rs.statusCode == 404) {
      switch (jsonRes['message']) {
        // !  มีชื่อวงนี้อยู่ใน DB Table Bands อยู่แล้ว
        case "You cannot invite yourself to join the band":
          showCustomSnackBar(
              'AcceptInvite Failed',
              'You cannot invite yourself to join the band',
              Colors.red, // สีแดงหรือสีที่คุณต้องการ
              ContentType.failure);
          break;
        // ! สามารถสร้างได้วงเดียว
        case "The band has disbanded.":
          showCustomSnackBar(
              'AcceptInvite Failed',
              'The band has disbanded.',
              Colors.red, // สีแดงหรือสีที่คุณต้องการ
              ContentType.failure);
          break;
        case "The band members are full.":
          showCustomSnackBar(
              'AcceptInvite Failed',
              'The band members are full.',
              Colors.red, // สีแดงหรือสีที่คุณต้องการ
              ContentType.failure);
          break;
        case "Record not Found":
          showCustomSnackBar(
              'AcceptInvite Failed',
              'Record not Found',
              Colors.red, // สีแดงหรือสีที่คุณต้องการ
              ContentType.failure);
          break;
        case "This user already has a band.":
          showCustomSnackBar(
              'AcceptInvite Failed',
              'You have already band',
              Colors.red, // สีแดงหรือสีที่คุณต้องการ
              ContentType.failure);
          break;
      }
    } else if (rs.statusCode == 498) {
      showCustomSnackBar(
          'POST FAILED',
          "Invalid token",
          Colors.red, // สีแดงหรือสีที่คุณต้องการ
          ContentType.failure);
      _mainWrapperController.logOut();
      // การส่งข้อมูลไม่สำเร็จ
    }
  }
}
