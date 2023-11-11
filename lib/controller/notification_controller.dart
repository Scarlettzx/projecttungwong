import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:project/data/models/noti_model.dart';
import 'package:project/utils/color.constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../services/bandservice.dart';
import '../utils/config.dart';
import 'dart:io';

import 'main_wrapper_controller.dart';

class NotificationController extends GetxController {
  final RxBool isLoading = false.obs;
  final isInvited = false.obs;
  final sendOffer = false.obs;
  final MainWrapperController _mainWrapperController =
      Get.find<MainWrapperController>();
  bool hide = false;
  bool isEmpty = false;
  final invitebyuserid = 0.obs;
  final invitebybandid = 0.obs;
  // final
  final BandService bandService = Get.find();
  final RxList<Notification> notis = <Notification>[].obs;
  @override
  void onInit() {
    super.onInit();
    getNotifications();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> getNotifications() async {
    print("getNotifications()");
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final Uri url =
        Uri.parse('${Config.endPoint}/api/notifications/getnotifications');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    try {
      isLoading.value = true; // เริ่มโหลดข้อมูล
      final response = await http.get(url, headers: headers);
      print(response.body);
      if (response.statusCode == HttpStatus.ok) {
        var data = json.decode(response.body);
        // if (data['notifications'] == []) {
        //   isEmpty = true;
        //   print("isEmpty []");
        //   print(isEmpty);
        // }

        print(data['notifications']);
        // print(data);
        // isEmpty = false;
        // print("isEmpty ok");
        // print(isEmpty);
        final notiData = notificationsFromJson(response.body);
        notis.assignAll(notiData.notifications!.whereType<Notification>());
        print(notis.length);
      }
    } catch (e) {
      print('Error fetching posts: $e');
    } finally {
      Future.delayed(const Duration(seconds: 1), () {
        isLoading.value = false; // โหลดข้อมูลเสร็จสิ้น
      }); // โหลดข้อมูลเสร็จสิ้น
    }
  }

  Future<http.Response> createNoti(String message) async {
    http.Response? response;
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (bandService.bandsController.isBand.value == false) {
      final url =
          Uri.parse('${Config.endPoint}/api/notifications/invitebandbyuser');
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };
      final body = jsonEncode({
        'person_id': bandService.profileController.anotherprofileid.value,
        'message': message
      });
      response = await http.post(url, headers: headers, body: body);
    } else if (bandService.bandsController.isBand.value == true) {
      final url =
          Uri.parse('${Config.endPoint}/api/notifications/invitebandbyband');
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };
      final body = jsonEncode({
        'band_id': bandService.bandsController.bandid.value,
        'person_id': bandService.profileController.anotherprofileid.value,
        'message': message
      });
      response = await http.post(url, headers: headers, body: body);
    }
    return response!;
  }

  Future<void> checkInviteBand() async {
    http.Response? response;
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (bandService.bandsController.isBand.value == false) {
      final url =
          Uri.parse('${Config.endPoint}/api/notifications/checkinvitedbyuser');
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };
      final body = jsonEncode(
          {'person_id': bandService.profileController.anotherprofileid.value});
      response = await http.post(url, headers: headers, body: body);
    } else if (bandService.bandsController.isBand.value == true) {
      final url =
          Uri.parse('${Config.endPoint}/api/notifications/checkinvitedbyband');
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };
      final body = jsonEncode({
        'band_id': bandService.bandsController.bandid.value,
        'person_id': bandService.profileController.anotherprofileid.value
      });
      response = await http.post(url, headers: headers, body: body);
    }
    if (response != null) {
      var data = json.decode(response.body);
      print(data);
      try {
        if (response.statusCode == 200) {
          if (data['invited'] == false) {
            isInvited.value = false;
          } else if (data['invited'] == true) {
            isInvited.value = true;
          } else if (response.statusCode == 498) {
            _mainWrapperController.logOut();
          } else {
            Get.snackbar("Error Loading data", 'Server Response: null');
          }
        } else {
          Get.snackbar("Error Loading data", 'Server Response: null');
        }
      } catch (e) {
        print(e.toString());
      }
    } else {
      Get.snackbar("Error Loading data", 'Server Response: null');
    }
  }

  Future<http.Response> acceptInviteJoinBandbyband(int bandid) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final url = Uri.parse('${Config.endPoint}/api/bands/invitebyband');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final body = jsonEncode({
      'band_id': bandid,
      'person_id': bandService.profileController.profileid.value
    });
    return await http.post(url, headers: headers, body: body);
  }

  Future<http.Response> acceptInviteJoinBandbyuser(int userid) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final url = Uri.parse('${Config.endPoint}/api/bands/invitebyuser');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final body = jsonEncode({
      'user_id': userid,
      'person_id': bandService.profileController.profileid.value
    });
    return await http.post(url, headers: headers, body: body);
  }

  Future<void> deleteNotiInvitebandbyuser() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final url = Uri.parse(
        '${Config.endPoint}/api/notifications/deleteinvitedbandbyuser');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final body = jsonEncode({
      'user_id': invitebyuserid.value,
      'person_id': bandService.profileController.profileid.value
    });

    try {
      final response = await http.delete(url, headers: headers, body: body);
      var data = json.decode(response.body);
      print(data);
      if (response.statusCode == HttpStatus.ok) {
        print("deleteNotiInvitebandbyuser");
        getNotifications();
        // print(data);
      }
    } catch (e) {
      print('Error fetching posts: $e');
    }
  }

  Future<void> deleteNotiInvitebandbyband() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final url = Uri.parse(
        '${Config.endPoint}/api/notifications/deleteinvitedbandbyband');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final body = jsonEncode({
      'band_id': invitebybandid.value,
      'person_id': bandService.profileController.profileid.value
    });
    try {
      final response = await http.delete(url, headers: headers, body: body);
      var data = json.decode(response.body);
      print(data);
      if (response.statusCode == HttpStatus.ok) {
        getNotifications();
        print("deleteNotiInvitebandbyband");
        // print(data);
      }
    } catch (e) {
      print('Error fetching posts: $e');
    }
  }

  Future<http.Response> createSendEmailtoUser(String description) async {
    http.Response? response;
    print("createSendEmailtoUser");
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final url = Uri.parse('${Config.endPoint}/api/notifications/sendofferuser');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final body = jsonEncode(
      {
        'person_id': bandService.profileController.anotherprofileid.value,
        'message': description
      },
    );
    response = await http.post(url, headers: headers, body: body);
    return response;
  }

  Future<http.Response> createSendEmailtoBand(String description) async {
    http.Response? response;
    print("createSendEmailtoBand");
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final url = Uri.parse('${Config.endPoint}/api/notifications/sendofferband');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final body = jsonEncode({
      'band_id': bandService.profileController.anotherprofileid.value,
      'message': description
    });
    response = await http.post(url, headers: headers, body: body);
    return response;
  }

  Future<void> checkSendEmail() async {
    http.Response? response;
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (bandService.profileController.anotherProfileType.value == "user") {
      final url = Uri.parse(
          '${Config.endPoint}/api/notifications/checksendemailtouser');
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };
      final body = jsonEncode(
          {'person_id': bandService.profileController.anotherprofileid.value});
      response = await http.post(url, headers: headers, body: body);
    } else if (bandService.profileController.anotherProfileType.value ==
        "band") {
      final url = Uri.parse(
          '${Config.endPoint}/api/notifications/checksendemailtoband');
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };
      final body = jsonEncode({
        'band_id': bandService.bandsController.bandid.value,
        'person_id': bandService.profileController.anotherprofileid.value
      });
      response = await http.post(url, headers: headers, body: body);
    }
    if (response != null) {
      var data = json.decode(response.body);
      print("data");
      print(data);
      print("sendOffer.value");
      print(sendOffer.value);
      try {
        if (response.statusCode == 200) {
          if (data['sendOffer'] == false) {
            sendOffer.value = false;
            print("sendOffer.value");
            print(sendOffer.value);
          } else if (data['sendOffer'] == true) {
            sendOffer.value = true;
            print("sendOffer.value");
            print(sendOffer.value);
          } else if (response.statusCode == 498) {
            _mainWrapperController.logOut();
          } else {
            Get.snackbar("Error Loading data", 'Server Response: null');
          }
        } else {
          Get.snackbar("Error Loading data", 'Server Response: null');
        }
      } catch (e) {
        print(e.toString());
      }
    } else {
      Get.snackbar("Error Loading data", 'Server Response: null');
    }
  }
}
