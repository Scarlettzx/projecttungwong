// ignore_for_file: unnecessary_overrides

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:project/data/models/posts_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/models/report.model.dart';
import '../services/bandservice.dart';
import '../utils/config.dart';

class ReportsController extends GetxController {
  final BandService bandService = Get.find();
  final RxBool isLoading = false.obs;
  // final RxString selectProvice = "".obs;
  final RxInt postid = 0.obs;
  final RxList<Report> reports =
      <Report>[].obs; // เพิ่มตัวแปร posts และกำหนดเป็น RxList
  // RxList<Post> displaypost = <Post>[].obs;
  @override
  void onInit() {
    super.onInit();
    getAllreports();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> getAllreports() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final Uri url = Uri.parse('${Config.endPoint}/api/reports/');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    try {
      isLoading.value = true; // เริ่มโหลดข้อมูล
      final response = await http.get(url, headers: headers);
      if (response.statusCode == HttpStatus.ok) {
        final reportsData = reportsFromJson(response.body);
        reports.assignAll(reportsData.reports!.whereType<Report>());
      }
    } catch (e) {
      print('Error fetching posts: $e');
    } finally {
      Future.delayed(const Duration(seconds: 1), () {
        isLoading.value = false; // โหลดข้อมูลเสร็จสิ้น
      }); // โหลดข้อมูลเสร็จสิ้น
    }
  }

  Future<http.Response> createReport() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (bandService.bandsController.isBand.value == false) {
      final url =
          Uri.parse('${Config.endPoint}/api/reports/createreportbyuser');
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };
      final body = jsonEncode({'post_id': postid.value});
      return await http.post(url, headers: headers, body: body);
    } else if (bandService.bandsController.isBand.value == true) {
      final url =
          Uri.parse('${Config.endPoint}/api/reports/createreportbyband');
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };
      final body = jsonEncode({
        'band_id': bandService.bandsController.bandid.value,
        'post_id': postid.value
      });
      return await http.post(url, headers: headers, body: body);
    }
    // Add a return statement for cases where none of the conditions are met.
    return Future.error(
        'Invalid condition'); // You can change the error message as needed.
  }

  Future<http.Response> deleteReport(int reportid) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final url = Uri.parse('${Config.endPoint}/api/reports/deletereport');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final body = jsonEncode({'report_id': reportid});
    return await http.delete(url, headers: headers, body: body);
  }

  Future<http.Response> hidePost(int postid) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final url = Uri.parse('${Config.endPoint}/api/reports/hidepost');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final body = jsonEncode({'post_id': postid});
    return await http.patch(url, headers: headers, body: body);
  }
  // Future<http.Response> editPost(int postid, String message) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final token = prefs.getString('token');
  //   final url = Uri.parse('${Config.endPoint}/api/poststest/editpost');
  //   final headers = {
  //     'Content-Type': 'application/json',
  //     'Authorization': 'Bearer $token',
  //   };
  //   final body = jsonEncode({'post_id': postid, "post_message": message});
  //   return await http.patch(url, headers: headers, body: body);
  // }

  // Future<http.Response> deletePost(int postid) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final token = prefs.getString('token');
  //   final url = Uri.parse('${Config.endPoint}/api/poststest/deletepost');
  //   final headers = {
  //     'Content-Type': 'application/json',
  //     'Authorization': 'Bearer $token',
  //   };
  //   final body = jsonEncode({'post_id': postid});
  //   return await http.delete(url, headers: headers, body: body);
  // }
}
