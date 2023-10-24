// // ignore_for_file: unnecessary_overrides

// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:http/http.dart' as http;
// import 'package:get/get.dart';
// import 'package:jwt_decoder/jwt_decoder.dart';
// import 'package:project/data/models/post_model.dart';
// import 'package:project/data/providers/post_provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import '../utils/config.dart';
// import '../utils/custom_snakebar.dart';
// import 'main_wrapper_controller.dart';

// class PostsController extends GetxController {
//   final count = 0.obs;
//   final posts = <Post>[].obs;
//   final RxBool isLoading = false.obs;
//   final RxString selectProvice = "".obs;
//   final RxBool emptyPost = false.obs;
//   @override
//   void onInit() {
//     super.onInit();
//     getPosts();
//   }

//   @override
//   void onReady() {
//     super.onReady();
//   }

//   @override
//   void onClose() {
//     super.onClose();
//   }

//   Future<http.Response> createPost(String message) async {
//     final prefs = await SharedPreferences.getInstance();
//     final token = prefs.getString('token');
//     final url = Uri.parse('${Config.endPoint}/api/posts/');
//     final headers = {
//       'Content-Type': 'application/json',
//       'Authorization': 'Bearer $token',
//     };
//     final body = jsonEncode({'message': message});
//     return await http.post(url, headers: headers, body: body);
//   }

//   void getPosts() async {
//     // final prefs = await SharedPreferences.getInstance();
//     // final token = prefs.getString('token');
//     // if (token != null && JwtDecoder.isExpired(token) == false) {
//     //   // CustomSnackBar.show(
//     //   //   context as BuildContext, // BuildContext ของหน้าอื่น ๆ
//     //   //   'POST FAILED',
//     //   //   "Invalid token",
//     //   //   Colors.red, // สีพื้นหลังของ SnackBar
//     //   //   CustomSnackBarContentType
//     //   //       .failure, // ประเภทของ SnackBar (success, warning, help)
//     //   // );
//     //   // );
//     //   _mainWrapperController.logOut();
//     // }
//     isLoading.value = true; // เริ่มโหลดข้อมูล
//     var r = await Get.put(PostProvider()).getApi();
//     var p = r?.posts ?? [];
//     posts.clear();
//     posts.addAll(p);
//     Future.delayed(const Duration(seconds: 1), () {
//       isLoading.value = false; // โหลดข้อมูลเสร็จสิ้น
//     });
//   }

//   void increment() => count.value++;
// }
