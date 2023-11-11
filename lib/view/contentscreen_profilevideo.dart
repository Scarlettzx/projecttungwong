// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, file_names, unused_import, deprecated_member_use

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/controller/Video_wrap_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:project/view/OptionScreen.dart';
import 'package:video_player/video_player.dart';

import '../data/models/video_model.dart';

class ContentScreenprofileVideo extends StatefulWidget {
  final Video src;
  const ContentScreenprofileVideo({Key? key, required this.src})
      : super(key: key);

  @override
  _ContentScreenprofileStateVideo createState() =>
      _ContentScreenprofileStateVideo();
}

class _ContentScreenprofileStateVideo extends State<ContentScreenprofileVideo> {
  late VideoPlayerController videoPlayerController;
  ChewieController? chewieController;

  @override
  void initState() {
    super.initState();
    initializePlayer();
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController?.dispose();
    super.dispose();
  }

  Future<void> initializePlayer() async {
    videoPlayerController =
        VideoPlayerController.network(widget.src.videoFilename!);
    await Future.wait([videoPlayerController.initialize()]);
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      autoPlay: true,
      showControls: false,
      autoInitialize: true,
      looping: true,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(fit: StackFit.expand, children: [
        chewieController != null &&
                chewieController!.videoPlayerController.value.isInitialized
            ? Center(
                child: AspectRatio(
                  aspectRatio: videoPlayerController.value.aspectRatio,
                  child: Chewie(controller: chewieController!),
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 100,
                  ),
                  Text('Loading'),
                ],
              ),
        OptionsScreen(videos: widget.src),
      ]),
    );
  }
}
