import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_time_ago/get_time_ago.dart';
import 'package:iconly/iconly.dart';
import 'package:like_button/like_button.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:project/controller/Video_wrap_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:project/controller/main_wrapper_controller.dart';
import 'package:project/view/OptionScreen.dart';
import 'package:video_player/video_player.dart';

import '../controller/comments_video.controller.dart';
import '../controller/videos_controller.dart';
import '../data/models/video_model.dart';
import '../services/bandservice.dart';
import '../utils/color.constants.dart';
import '../utils/config.dart';
import 'another_profile_tab.dart';

class ContentScreen extends StatefulWidget {
  final Video video;
  const ContentScreen({Key? key, required this.video}) : super(key: key);

  @override
  _ContentScreenState createState() => _ContentScreenState();
}

class _ContentScreenState extends State<ContentScreen> {
  final MainWrapperController _mainWrapperController =
      Get.find<MainWrapperController>();
  final BandService bandService = Get.find();
  final CommentsVideosController _commentsvideoscontroller =
      Get.put(CommentsVideosController());
  final GlobalKey<FormState> _keyForm = GlobalKey<FormState>();
  // final VideosController _videosController = Get.find<VideosController>();
  late VideoPlayerController videoPlayerController;
  ChewieController? chewieController;
  TextEditingController _textcommentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    initializePlayer();
    // _textcommentController = TextEditingController();
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    videoPlayerController.pause();
    chewieController?.dispose();
    _textcommentController.dispose();
    super.dispose();
  }

// ? void showCustomSnackBar(String title, String message, Color color)
  void showCustomSnackBar(
      String title, String message, Color color, ContentType contentType) {
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

  String? _commentValidator(String? fieldContent) {
    if (fieldContent != null && fieldContent.contains(' ')) {
      showCustomSnackBar(
          'COMMENT FAILED',
          "Please Fill Message without spaces..",
          Colors.red,
          ContentType.failure);
      return 'Comments cannot contain spaces';
    }
    return null;
  }

  Future<void> initializePlayer() async {
    videoPlayerController =
        VideoPlayerController.network(widget.video.videoFilename!);
    await Future.wait([videoPlayerController.initialize()]);
    // print(videoPlayerController.value.size.width);
    // print(videoPlayerController.value.size.height);
    // print(MediaQuery.of(context).size.width);
    // print(MediaQuery.of(context).size.height);
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      autoPlay: true,
      showControls: true,
      autoInitialize: true,
      looping: true,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print("videoPlayerController.value.aspectRatio");
    print(videoPlayerController.value.aspectRatio);
    return AspectRatio(
      aspectRatio: videoPlayerController.value.aspectRatio,
      child: Stack(children: [
        if (chewieController != null &&
            chewieController!.videoPlayerController.value.isInitialized) ...[
          Center(
            child: Chewie(controller: chewieController!),
          ),
        ] else
          Center(
            child: LoadingAnimationWidget.dotsTriangle(
              color: ColorConstants.appColors,
              size: 50,
            ),
          ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: 200,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    //  final isBand =
                    //     (_postsController.posts[reverseindex].bandDetails !=
                    //         null);
                    children: [
                      Row(
                        children: [
                          (widget.video.bandDetails != null)
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () {
                                      var bandid =
                                          widget.video.bandDetails!.bandId;
                                      // ! เอาค่าbandidเก็บใน anotherprofileid เพื่อจะเข้า method
                                      bandService.profileController
                                          .anotherprofileid.value = bandid!;
                                      bandService.profileController
                                          .anotherProfileType.value = "band";
                                      print(bandService.profileController
                                          .anotherProfileType.value);
                                      print(bandService.profileController
                                          .anotherprofileid.value);
                                      bandService.profileController
                                          .checkfollow();
                                      Get.to(
                                          transition: Transition.downToUp,
                                          AnotherProfileTab(
                                            anotherpofileid: bandid,
                                          ));
                                    },
                                    child: CircleAvatar(
                                      backgroundColor: Colors.transparent,
                                      backgroundImage: NetworkImage(
                                          '${Config.getImageBand}${widget.video.bandDetails!.bandAvatar}'),
                                      radius: 15,
                                    ),
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () {
                                      var userid =
                                          widget.video.personDetails!.userId;
                                      bandService.profileController
                                          .anotherprofileid.value = userid!;
                                      bandService.profileController
                                          .anotherProfileType.value = "user";
                                      print(bandService.profileController
                                          .anotherProfileType.value);
                                      print(bandService.profileController
                                          .anotherprofileid.value);
                                      bandService.profileController
                                          .checkfollow();
                                      Get.to(
                                          transition: Transition.downToUp,
                                          AnotherProfileTab(
                                            anotherpofileid: userid,
                                          ));
                                    },
                                    child: CircleAvatar(
                                      backgroundColor: Colors.transparent,
                                      backgroundImage: NetworkImage(
                                          '${Config.getImage}${widget.video.personDetails!.userAvatar}'),
                                      radius: 15,
                                    ),
                                  ),
                                ),
                          SizedBox(width: 6),
                          (widget.video.bandDetails != null)
                              ? Text(
                                  widget.video.bandDetails!
                                      .bandName!, //username ของ user
                                  style: TextStyle(color: Colors.white))
                              : Text(
                                  widget.video.personDetails!
                                      .userName!, //username ของ user
                                  style: TextStyle(color: Colors.white)),
                        ],
                      ),
                      SizedBox(width: 6),
                      Text(widget.video.videoMessage!, // describtion ของ video
                          style: TextStyle(color: Colors.white)),
                      SizedBox(height: 10),
                    ],
                  ),
                  Column(
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(
                        right: 50,
                        // top: 50,
                      )),
                      LikeButton(
                        size: 40,
                      ),
                      Text('601k'), // total like
                      SizedBox(height: 20),
                      IconButton(
                        onPressed: () {
                          _textcommentController = TextEditingController();
                          _textcommentController.addListener(() {
                            if (_textcommentController.text.isNotEmpty) {
                              print(_textcommentController.text);
                              _commentsvideoscontroller
                                      .isIconButtonEnabled.value =
                                  true; // ถ้ามีข้อความ กำหนดให้ปุ่มสามารถกดได้
                            } else {
                              _commentsvideoscontroller
                                      .isIconButtonEnabled.value =
                                  false; // ถ้าไม่มีข้อความ กำหนดให้ปุ่มไม่สามารถกดได้
                            }
                          });
                          _commentsvideoscontroller.videoid.value =
                              widget.video.videoId!;
                          print(_commentsvideoscontroller.videoid.value);
                          _commentsvideoscontroller.getCommentsByvideoid();
                          showModalBottomSheet(
                            
                            // isScrollControlled: true,
                            context: context,
                            builder: (BuildContext context) {
                              return Padding(
                                padding: MediaQuery.of(context).viewInsets,
                                child: NestedScrollView(
                                  headerSliverBuilder: (BuildContext context,
                                      bool innerBoxIsScrolled) {
                                    return <Widget>[
                                      SliverAppBar(
                                        expandedHeight:
                                            30.0, // สูงสุดของ SliverAppBar
                                        floating: true, // ตั้งค่าเป็น false
                                        pinned: true, // ตั้งค่าเป็น false
                                        flexibleSpace: FlexibleSpaceBar(
                                          title: Text(
                                            "Commend",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 15),
                                          ),
                                        ),
                                      ),
                                    ];
                                  },
                                  body: Form(
                                    key:
                                        _keyForm, // ใส่ GlobalKey ที่คุณสร้างไว้
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: SingleChildScrollView(
                                              child: Obx(() {
                                                if (_commentsvideoscontroller
                                                    .isLoading.value) {
                                                  return Center(
                                                    child:
                                                        LoadingAnimationWidget
                                                            .dotsTriangle(
                                                      color: ColorConstants
                                                          .appColors,
                                                      size: 50,
                                                    ),
                                                  );
                                                } else {
                                                  if (_commentsvideoscontroller
                                                      .comments.isEmpty) {
                                                    return const Center(
                                                      child:
                                                          Text('No comments'),
                                                    );
                                                  } else {
                                                    return ListView.builder(
                                                      physics:
                                                          const BouncingScrollPhysics(),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5.0),
                                                      shrinkWrap:
                                                          true, // ให้ ListView ขยายตามเนื้อหาของมัน
                                                      itemCount:
                                                          _commentsvideoscontroller
                                                              .comments.length,
                                                      itemBuilder:
                                                          (context, i) {
                                                        var reverseindex =
                                                            _commentsvideoscontroller
                                                                    .comments
                                                                    .length -
                                                                1 -
                                                                i;
                                                        DateTime datetime =
                                                            _commentsvideoscontroller
                                                                .comments[
                                                                    reverseindex]
                                                                .commentCreateAt!;
                                                        final isBand =
                                                            (_commentsvideoscontroller
                                                                    .comments[
                                                                        reverseindex]
                                                                    .bandDetails !=
                                                                null);
                                                        if (isBand) {
                                                          return Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    5.0),
                                                            child: ListTile(
                                                              tileColor:
                                                                  ColorConstants
                                                                      .gray50,
                                                              title: Align(
                                                                alignment: Alignment
                                                                    .centerLeft,
                                                                child: Text(
                                                                  _commentsvideoscontroller
                                                                      .comments[
                                                                          reverseindex]
                                                                      .commentMessage!,
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          17),
                                                                ),
                                                              ),
                                                              // isThreeLine: true,
                                                              subtitle:
                                                                  const SizedBox(
                                                                height: 30,
                                                              ),
                                                              leading: Column(
                                                                children: [
                                                                  Expanded(
                                                                    child:
                                                                        Container(
                                                                      // margin: EdgeInsets.all(5.0),
                                                                      // color: ColorConstants.appColors,
                                                                      width:
                                                                          40, // ปรับขนาดของ Container ตามต้องการ
                                                                      height:
                                                                          70, // ปรับขนาดของ Container ตามต้องการ
                                                                      child:
                                                                          CircleAvatar(
                                                                        // radius: 10,
                                                                        backgroundColor:
                                                                            Colors.transparent,
                                                                        backgroundImage: _commentsvideoscontroller.comments[reverseindex].bandDetails!.bandAvatar!.isEmpty
                                                                            ? null
                                                                            : NetworkImage('${Config.getImageBand}${_commentsvideoscontroller.comments[reverseindex].bandDetails!.bandAvatar}'),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Text(_commentsvideoscontroller
                                                                      .comments[
                                                                          reverseindex]
                                                                      .bandDetails!
                                                                      .bandCategory!),
                                                                ],
                                                              ),

                                                              trailing: Text(
                                                                GetTimeAgo.parse(
                                                                    datetime),
                                                              ),
                                                            ),
                                                          );
                                                        } else {
                                                          return Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    5.0),
                                                            child: ListTile(
                                                              tileColor:
                                                                  ColorConstants
                                                                      .gray50,
                                                              title: Align(
                                                                alignment: Alignment
                                                                    .centerLeft,
                                                                child: Text(
                                                                  _commentsvideoscontroller
                                                                      .comments[
                                                                          reverseindex]
                                                                      .commentMessage!,
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          17),
                                                                ),
                                                              ),
                                                              // isThreeLine: true,
                                                              subtitle:
                                                                  const SizedBox(
                                                                height: 30,
                                                              ),
                                                              leading: Column(
                                                                children: [
                                                                  Expanded(
                                                                    child:
                                                                        Container(
                                                                      // margin: EdgeInsets.all(5.0),
                                                                      // color: ColorConstants.appColors,
                                                                      width:
                                                                          40, // ปรับขนาดของ Container ตามต้องการ
                                                                      height:
                                                                          70, // ปรับขนาดของ Container ตามต้องการ
                                                                      child:
                                                                          CircleAvatar(
                                                                        // radius: 10,
                                                                        backgroundColor:
                                                                            Colors.transparent,
                                                                        backgroundImage: _commentsvideoscontroller.comments[reverseindex].personDetails!.userAvatar!.isEmpty
                                                                            ? null
                                                                            : NetworkImage('${Config.getImage}${_commentsvideoscontroller.comments[reverseindex].personDetails!.userAvatar}'),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Text(_commentsvideoscontroller
                                                                      .comments[
                                                                          reverseindex]
                                                                      .personDetails!
                                                                      .userPosition!),
                                                                ],
                                                              ),

                                                              trailing: Text(
                                                                GetTimeAgo.parse(
                                                                    datetime),
                                                              ),
                                                            ),
                                                          );
                                                        }
                                                      },
                                                    );
                                                  }
                                                }
                                              }),
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            color: ColorConstants.appColors,
                                            child: Row(children: [
                                              Expanded(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: TextFormField(
                                                    validator:
                                                        _commentValidator,
                                                    controller:
                                                        _textcommentController,
                                                    obscureText: false,
                                                    keyboardType:
                                                        TextInputType.text,
                                                    decoration: InputDecoration(
                                                      labelText: 'Comment',
                                                      fillColor: Colors.white,
                                                      filled: true,
                                                      // border:
                                                      // OutlineInputBorder(),
                                                      suffixIcon:
                                                          Obx(() => IconButton(
                                                                iconSize: 40,
                                                                icon: Icon(
                                                                  IconlyBold
                                                                      .send,
                                                                  color: _commentsvideoscontroller
                                                                          .isIconButtonEnabled
                                                                          .value
                                                                      ? Color.fromARGB(243, 61, 255, 190)
                                                                      : Colors
                                                                          .grey, // กำหนดสีตามเงื่อนไข, // กำหนดสีตามเงื่อนไข
                                                                ),
                                                                onPressed: _commentsvideoscontroller
                                                                        .isIconButtonEnabled
                                                                        .value //
                                                                    ? () {
                                                                        subbmitComment().then((value) => SystemChannels
                                                                            .textInput
                                                                            .invokeMethod('TextInput.hide'));
                                                                        // _textcommentController
                                                                        //     .dispose();
                                                                      }
                                                                    : null, // ถ้าไม่มีข้อมูลให้ปุ่มเป็น non-clickable
                                                                // ถ้าไม่มีข้อมูลให้ปุ่มเป็น non-clickable
                                                              )),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide:
                                                            const BorderSide(
                                                          color: Colors.white,
                                                          width: 3,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(25),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              // SizedBox(
                                              //     width:
                                              //         8), // ระยะห่างระหว่าง TextFormField และปุ่ม
                                              // Padding(
                                              //   padding: const EdgeInsets.only(
                                              //       right: 8),
                                              //   child: ElevatedButton(
                                              //     onPressed: () {
                                              //       subbmitComment()
                                              //           .then((value) {
                                              //         SystemChannels.textInput
                                              //             .invokeMethod(
                                              //                 'TextInput.hide');
                                              //         _textcommentController
                                              //             .dispose(); // ทำลาย TextController เมื่อกดปุ่ม "Add"
                                              //       });
                                              //     },
                                              //     child: Text('Add'),
                                              //   ),
                                              // ),
                                            ]),
                                          ),
                                        ]),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        icon: Icon(
                          Icons.comment_rounded,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),

                      Text('1123'), //total commend
                      SizedBox(height: 20),
                      // Transform(
                      //   transform: Matrix4.rotationZ(5.8),
                      //   child: Icon(Icons.send),
                      // ),
                      // SizedBox(height: 50),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ]),
    );
  }

  Future subbmitComment() async {
    if (_keyForm.currentState!.validate()) {
      print(_textcommentController.text);
      var rs = await _commentsvideoscontroller
          .createComments(_textcommentController.text.trim());
      try {
        if (rs.statusCode == 200) {
          // การส่งข้อมูลสำเร็จ
          print('Post created successfully');
          _loadData();
          _textcommentController.clear();
          _commentsvideoscontroller.isIconButtonEnabled.value = false;
          setState(() {
            initState();
          });
        } else if (rs.statusCode == 498) {
          showCustomSnackBar(
              'COMMENT FAILED',
              "Invalid token",
              Colors.red, // สีแดงหรือสีที่คุณต้องการ
              ContentType.failure);
          _mainWrapperController.logOut();
          // การส่งข้อมูลไม่สำเร็จ
        } else if (rs.statusCode == 404) {
          print(rs.body);
          showCustomSnackBar(
              'COMMENT FAILED',
              "Please Fill Message or Something..",
              Colors.red, // สีแดงหรือสีที่คุณต้องการ
              ContentType.failure);
        }
      } catch (e) {
        // เกิดข้อผิดพลาดในการเชื่อมต่อ
        print('Error creating post: $e');
      }
    }
  }

  _loadData() async {
    _commentsvideoscontroller.getCommentsByvideoid();
    print(_commentsvideoscontroller.comments.length);
  }
}
