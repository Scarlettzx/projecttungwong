// ignore_for_file: unnecessary_overrides

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:project/data/models/comments_model.dart';
// import 'package:project/data/models/posts_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/bandservice.dart';
import '../utils/config.dart';

class CommentsVideosController extends GetxController {
  final BandService bandService = Get.find();
  final RxBool isLoading = false.obs;
  final RxList<Comment> comments =
      <Comment>[].obs; // เพิ่มตัวแปร comments และกำหนดเป็น RxList
  final RxInt videoid = 0.obs;
  final isIconButtonEnabled = RxBool(false);
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

  Future<void> getCommentsByvideoid() async {
    print("getCommentsByvideoid is running");
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final Uri url =
        Uri.parse('${Config.endPoint}/api/commentvideos/${videoid.value}');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    try {
      isLoading.value = true; // เริ่มโหลดข้อมูล
      final response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        final commentsData = commentsFromJson(response.body);
        comments.assignAll(commentsData.comments!.whereType<Comment>());
      } else if (response.statusCode == 404) {
        comments.clear();
      }
    } catch (e) {
      print('Error fetching posts: $e');
    } finally {
      Future.delayed(const Duration(seconds: 1), () {
        isLoading.value = false; // โหลดข้อมูลเสร็จสิ้น
      }); // โหลดข้อมูลเสร็จสิ้น
    }
  }

  Future<http.Response> createComments(String message) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    print("bandService.bandsController.isBand.value");
    print(bandService.bandsController.isBand.value);
    if (bandService.bandsController.isBand.value == false) {
      final url =
          Uri.parse('${Config.endPoint}/api/commentvideos/createcommentbyuser');
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };
      final body = jsonEncode({'message': message, 'video_id': videoid.value});
      return await http.post(url, headers: headers, body: body);
    } else if (bandService.bandsController.isBand.value == true) {
      final url =
          Uri.parse('${Config.endPoint}/api/commentvideos/createcommentbyband');
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };
      final body = jsonEncode({
        'message': message,
        'band_id': bandService.bandsController.bandid.value,
        'video_id': videoid.value
      });
      return await http.post(url, headers: headers, body: body);
    }
    // Add a return statement for cases where none of the conditions are met.
    return Future.error(
        'Invalid condition'); // You can change the error message as needed.
  }
}
