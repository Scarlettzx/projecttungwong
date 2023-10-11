// // // ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, file_names, unused_import

// // import 'package:chewie/chewie.dart';
// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'package:project/controller/Video_wrap_controller.dart';
// // import 'package:flutter/foundation.dart';
// // import 'package:project/view/OptionScreen.dart';
// // import 'package:video_player/video_player.dart';

// // class ContentScreen extends StatefulWidget {
// //   final String? src;
// //   const ContentScreen({super.key, required this.src});

// //   @override
// //   State<ContentScreen> createState() => _ContentScreenState();
// // }

// // class _ContentScreenState extends State<ContentScreen> {
// //   late VideoPlayerController videoPlayerController;
// //   ChewieController? chewieController;

// //   @override
// //   void initState() {
// //     // TODO: implement initState
// //     super.initState();
// //     initializePlayer();
// //   }

// //   @override
// //   void dispose() {
// //     videoPlayerController.dispose();
// //     chewieController!.dispose();
// //     super.dispose();
// //   }

// //   Future<void> initializePlayer() async {
// //     videoPlayerController =
// //         VideoPlayerController.networkUrl(Uri.parse(widget.src!));
// //     await Future.wait([videoPlayerController.initialize()]);
// //     chewieController = ChewieController(
// //       videoPlayerController: videoPlayerController,
// //       autoPlay: true,
// //       showControls: false,
// //       autoInitialize: true,
// //     );
// //     setState(() {});
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Stack(fit: StackFit.expand, children: [
// //       chewieController != null &&
// //               chewieController!.videoPlayerController.value.isInitialized
// //           ? Chewie(controller: chewieController!)
// //           : Column(
// //               mainAxisAlignment: MainAxisAlignment.center,
// //               children: [
// //                 CircularProgressIndicator(),
// //                 SizedBox(
// //                   height: 100,
// //                 ),
// //                 Text('Loading')
// //               ],
// //             ),
// //       OptionScreen()
// //     ]);
// //   }
// // }

// // ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, file_names, unused_import, unused_local_variable, no_leading_underscores_for_local_identifiers, prefer_typing_uninitialized_variables

// import 'package:chewie/chewie.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:project/controller/Video_wrap_controller.dart';
// import 'package:flutter/foundation.dart';
// import 'package:project/view/OptionScreen.dart';
// import 'package:video_player/video_player.dart';

// class ContentScreen extends StatelessWidget {
//   const ContentScreen({super.key, required this.src});
//   final String src;

//   @override
//   Widget build(BuildContext context) {
//     final Video_wrap_controller _controller = Get.put(Video_wrap_controller());
//     final temp = src;
//     // _controller.initializePlayer(src);

//     // debugPrint(_controller.src[_controller.count.value]);
//     if (_controller.check == false) {
//       _controller.initializePlayer(src);
//       _controller.check = true;
//     }

//     return Stack(children: [
//       GetBuilder<Video_wrap_controller>(
//           init: Video_wrap_controller(),
//           builder: (controller) => Positioned(
//                   child: Center(
//                 child: controller.chewieController != null &&
//                         controller.chewieController!.videoPlayerController.value
//                             .isInitialized
//                     ? Chewie(
//                         controller: controller.chewieController!,
//                       )
//                     : Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           CircularProgressIndicator(),
//                           SizedBox(
//                             height: 100,
//                           ),
//                           Text('Loading')
//                         ],
//                       ),
//               )))
//     ]);
//   }
// }
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, file_names, unused_import, deprecated_member_use

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/controller/Video_wrap_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:project/view/OptionScreen.dart';
import 'package:video_player/video_player.dart';

class ContentScreen extends StatefulWidget {
  final String? src;
  const ContentScreen({Key? key, required this.src}) : super(key: key);

  @override
  _ContentScreenState createState() => _ContentScreenState();
}

class _ContentScreenState extends State<ContentScreen> {
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
    videoPlayerController = VideoPlayerController.network(widget.src!);
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
        OptionsScreen(),
      ]),
    );
  }
}
