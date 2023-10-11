// ignore_for_file: unnecessary_overrides

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:project/data/providers/comment_provider.dart';
// import 'package:project/data/models/post_model.dart';
// import 'package:project/data/providers/post_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/models/comment_model.dart';
import '../utils/config.dart';

class CommentsController extends GetxController {
  //TODO: Implement HomeController

  final count = 0.obs;
  final comments = <Comment>[].obs;
  final RxInt postid = 0.obs;
  final RxBool isLoading = false.obs;
  final isIconButtonEnabled = RxBool(false);
  final RxBool isEmpty = false.obs;
  @override
  void onInit() {
    super.onInit();
    // getCommentsBypostid();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<http.Response> createComment(String message) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final url = Uri.parse('${Config.endPoint}/api/comments/');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final body = jsonEncode({'message': message, 'post_id': postid.value});
    return await http.post(url, headers: headers, body: body);
  }

  void getCommentsBypostid() async {
    isLoading.value = true; // เริ่มโหลดข้อมูล
    var r =
        await Get.put(CommentProvider()).getcommentBypostidApi(postid.value);
    var p = r?.comments ?? [];
    print(p);
    print(r);
    if (r == null) {
      isEmpty.value = true;
      print('no comments');
      print(comments);
      print(isEmpty.value);
    } else {
      comments.clear();
      comments.addAll(p);
      isEmpty.value = false;
      print(isEmpty.value);
    }
    // print(comments);
    Future.delayed(const Duration(seconds: 1), () {
      isLoading.value = false; // โหลดข้อมูลเสร็จสิ้น
    });
  }

  void increment() => count.value++;
}
