// ignore_for_file: unnecessary_overrides

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:project/data/models/posts_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/bandservice.dart';
import '../utils/config.dart';

class PoststestController extends GetxController {
  final BandService bandService = Get.find();
  final RxBool isLoading = false.obs;
  final RxString selectProvice = "".obs;
  final RxList<Post> posts =
      <Post>[].obs; // เพิ่มตัวแปร posts และกำหนดเป็น RxList
  @override
  void onInit() {
    super.onInit();
    getPosts();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> getPosts() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final Uri url = Uri.parse('${Config.endPoint}/api/poststest/');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    try {
      isLoading.value = true; // เริ่มโหลดข้อมูล
      final response = await http.get(url, headers: headers);
      if (response.statusCode == HttpStatus.ok) {
        final postsData = postsFromJson(response.body);
        posts.assignAll(postsData.posts!.whereType<Post>());
      }
    } catch (e) {
      print('Error fetching posts: $e');
    } finally {
      Future.delayed(const Duration(seconds: 1), () {
        isLoading.value = false; // โหลดข้อมูลเสร็จสิ้น
      }); // โหลดข้อมูลเสร็จสิ้น
    }
  }

  Future<http.Response> createPost(String message) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (bandService.bandsController.isBand.value == false) {
      final url = Uri.parse('${Config.endPoint}/api/poststest/creatpostbyuser');
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };
      final body = jsonEncode({'message': message});
      return await http.post(url, headers: headers, body: body);
    } else if (bandService.bandsController.isBand.value == true) {
      final url = Uri.parse('${Config.endPoint}/api/poststest/creatpostbyband');
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };
      final body = jsonEncode({
        'band_id': bandService.bandsController.bandid.value,
        'message': message
      });
      return await http.post(url, headers: headers, body: body);
    }
    // Add a return statement for cases where none of the conditions are met.
    return Future.error(
        'Invalid condition'); // You can change the error message as needed.
  }
}
