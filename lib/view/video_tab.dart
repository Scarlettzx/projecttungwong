// ignore_for_file: unused_import, prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers, non_constant_identifier_names, unused_local_variable, no_leading_underscores_for_local_identifiers

import 'dart:math';

import 'package:card_swiper/card_swiper.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:project/controller/Video_wrap_controller.dart';
import 'package:project/controller/comments_video.controller.dart';
import 'package:project/utils/color.constants.dart';
import 'package:project/view/contentScreen.dart';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:project/view/upload_video.dart';
import 'package:project/view/video_screen.dart';
import 'package:video_player/video_player.dart';

import '../controller/poststest_controller.dart';
import '../controller/videos_controller.dart';
import '../services/bandservice.dart';
import '../utils/config.dart';

class VideoTab extends StatefulWidget {
  const VideoTab({super.key});
  // static const List<String> videos = [
  //   'https://res.cloudinary.com/dtcwehgib/video/upload/v1697378148/video_user/user-1697378145182.mp4.mp4',
  //   'https://assets.mixkit.co/videos/preview/mixkit-highway-in-the-middle-of-a-mountain-range-4633-large.mp4',
  //   'https://assets.mixkit.co/videos/preview/mixkit-young-mother-with-her-little-daughter-decorating-a-christmas-tree-39745-large.mp4',
  //   'https://assets.mixkit.co/videos/preview/mixkit-mother-with-her-little-daughter-eating-a-marshmallow-in-nature-39764-large.mp4',
  //   'https://assets.mixkit.co/videos/preview/mixkit-girl-in-neon-sign-1232-large.mp4',
  //   'https://assets.mixkit.co/videos/preview/mixkit-winter-fashion-cold-looking-woman-concept-video-39874-large.mp4',
  //   'https://assets.mixkit.co/videos/preview/mixkit-womans-feet-splashing-in-the-pool-1261-large.mp4',
  //   'https://assets.mixkit.co/videos/preview/mixkit-a-girl-blowing-a-bubble-gum-at-an-amusement-park-1226-large.mp4'
  // ];

  State<VideoTab> createState() => _VideoTabState();
}

class _VideoTabState extends State<VideoTab> {
  // late VideoPlayerController videoPlayerController;
  // ChewieController? chewieController;
  final PoststestController _postsController = Get.put(PoststestController());
  final VideosController _videosController = Get.put(VideosController());
  final BandService bandService = Get.find();

  @override
  void initState() {
    super.initState();
    _videosController.getVideos();
    bandService.notificationController.getNotifications();
    print("bandService.profileController.anotherProfileType.value");
    print(bandService.profileController.anotherProfileType.value);
    // _commentsvideoscontroller.getCommentsByvideoid();
    // _isMounted = true; // Set the flag to true when the widget is mounted
  }

  @override
  void dispose() {
    super.dispose();
    // _isMounted = false;
    // videoPlayerController.pause();
    // videoPlayerController.dispose();
    // chewieController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // return Obx(
    //   () {
    //     if (_videosController.isLoading.value) {
    //       // ใช้ CircularProgressIndicator ในระหว่างโหลดข้อมูล
    //       return Scaffold(
    //         backgroundColor: Colors.grey[300],
    //         body: Center(
    //           child: CircularProgressIndicator(),
    //         ),
    //       );
    //     } else {
    // แสดงหน้าแอพของคุณเมื่อโหลดข้อมูลเสร็จสมบูรณ์
    // return Scaffold(
    //   extendBodyBehindAppBar: true,
    //   // backgroundColor: Colors.grey[300],
    //   floatingActionButton: FloatingActionButton.small(
    //     elevation: 3,
    //     backgroundColor: ColorConstants.appColors,
    //     onPressed: () =>
    //         Get.to(UploadVideo(), transition: Transition.cupertino),
    //     child: const Icon(Icons.add),
    //   ),
    //   body: SingleChildScrollView(
    //     child: ListView.builder(
    //       shrinkWrap: true,
    //       physics: const NeverScrollableScrollPhysics(),
    //       padding: EdgeInsets.zero,
    //       itemCount: _videosController.videos.length,
    //       itemBuilder: (context, index) {
    //         var reverseindex = _videosController.videos.length - 1 - index;
    //         // final videoUrl =
    //         //     _videosController.videos[reverseindex].videoFilename;
    //         return CustomVideoScreen(
    //             pathvideo:
    //                 _videosController.videos[reverseindex].videoFilename!);
    //       },
    //     ),
    //   ),
    // );
    return Scaffold(
      // backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      floatingActionButton: FloatingActionButton.small(
        elevation: 3,
        backgroundColor: ColorConstants.appColors,
        onPressed: () =>
            Get.to(UploadVideo(), transition: Transition.cupertino),
        child: const Icon(Icons.add),
      ),
      // resizeToAvoidBottomInset: true,
      body: Obx(() {
        if (_videosController.isLoading.value) {
          return Center(
            child: LoadingAnimationWidget.dotsTriangle(
              color: ColorConstants.appColors,
              size: 50,
            ),
          );
        } else {
          return SafeArea(
            child: Swiper(
              itemBuilder: (BuildContext context, int index) {
                var reverseindex = _videosController.videos.length - 1 - index;
                return ContentScreen(
                  video: _videosController.videos[reverseindex],
                );
              },
              itemCount: _videosController.videos.length,
              scrollDirection: Axis.vertical,
            ),
          );
        }
      }),
    );
    //     }
    //   },
    // );
  }
}
