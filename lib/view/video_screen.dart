// import 'package:chewie/chewie.dart';
// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';

// class CustomVideoScreen extends StatefulWidget {
//   final String pathvideo;

//   const CustomVideoScreen({Key? key, required this.pathvideo})
//       : super(key: key);

//   @override
//   State<CustomVideoScreen> createState() => CustomVideoScreenState();
// }

// class CustomVideoScreenState extends State<CustomVideoScreen> {
//   late VideoPlayerController videoplayercontroller;
//   ChewieController? chewieController;

//   @override
//   void initState() {
//     initializePlayer();
//     super.initState();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     videoplayercontroller.dispose();
//     chewieController?.dispose();
//   }

//   Future<void> initializePlayer() async {
//     videoplayercontroller = VideoPlayerController.network(widget.pathvideo);
//     await Future.wait([videoplayercontroller.initialize()]);
//     chewieController = ChewieController(
//       videoPlayerController: videoplayercontroller,
//       autoPlay: true,
//       showControls: false,
//       autoInitialize: true,
//       looping: true,
//     );

//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         return Stack(
//           fit: StackFit.expand,
//           children: [
//             if (chewieController != null &&
//                 chewieController!
//                     .videoPlayerController.value.isInitialized) ...[
//               Center(
//                 child: AspectRatio(
//                   aspectRatio: videoplayercontroller.value.aspectRatio,
//                   child: Chewie(controller: chewieController!),
//                 ),
//               ),
//               // Gradient Overlay
//               const Positioned.fill(
//                 child: DecoratedBox(
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                       colors: [
//                         Colors.black,
//                         Colors.transparent,
//                         Colors.transparent,
//                         Colors.black,
//                       ],
//                       begin: Alignment.topCenter,
//                       end: Alignment.bottomCenter, 
//                       stops: [0.0, 0.2, 0.8, 1.0],
//                     ),
//                   ),
//                 ),
//               ),
//             ] else
//               const Center(
//                 child: CircularProgressIndicator(),
//               )
//           ],
//         );
//       },
//     );
//   }
// }
