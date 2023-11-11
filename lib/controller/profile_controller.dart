import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
// import 'package:get_storage/get_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:project/controller/bands_controller.dart';
import 'package:project/data/models/profile_model.dart';
import 'package:project/utils/config.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http_parser/http_parser.dart';
// import '../components/user.dart';
import '../data/models/band_model.dart';
import '../data/models/follower_model.dart';
import '../data/models/users_model.dart';
import '../services/bandservice.dart';

class ProfileController extends GetxController {
  final BandService bandService = Get.find();
  // ! อันเดิม
  // final BandsController bandsController = Get.find<BandsController>();
  // ! อันใหม่
   final RxBool isvideo = false.obs;
  // final BandsController bandsController = Get.put(BandsController());
  RxString selectType = "User".obs;
  RxList<Map<String, dynamic>> personIdList = RxList<Map<String, dynamic>>();
  RxList<BandDetails> bandDetails = RxList<BandDetails>();
  RxList<PersonDetails> personDetails = RxList<PersonDetails>();
  RxList<BandDetails> bandDetailsfollowing = RxList<BandDetails>();
  RxList<PersonDetails> personDetailfollowing = RxList<PersonDetails>();
  final RxList<User> allusers = <User>[].obs;
  RxList<User> displayallUsers = <User>[].obs;
  var isFollowing = false.obs;
  var isEmpty = false.obs;
  var isAdmin = "".obs;
  final RxInt anotherprofileid = 0.obs;
  final anotherProfileType = "".obs;
  //  List<> memberList = [];
  // var persondetails = <PersonDetails>[].obs;
  // var bandDetails = <BandDetails>[].obs;
  var countFollowing = 0.obs;
  RxInt countFollowers = 0.obs;
  var bandanotherprofile = <Band>[].obs;
  var useranotherprofile = <ProfileModel>[].obs;
  var profileList = <ProfileModel>[].obs;
  var isLoading = true.obs;
  var isLoadingsearch = true.obs;
  final RxInt profileid = 0.obs;
  final selectedList = "followers".obs;
  // Initialize profileDetail as an RxMap<String, dynamic>?
  RxMap<String, dynamic>? profileDetail;

  // Constructor to initialize profileDetail
  ProfileController() {
    profileDetail = <String, dynamic>{}.obs;
  }

  // Future<void> loadProfileData() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final token = prefs.getString('token');

  //   if (token != null) {
  //     final Map<String, dynamic> decodedToken =
  //         JwtDecoder.decode(token)['result'];
  //     profileDetail!.value = {
  //       'userId': decodedToken['user_id'],
  //       'userCountry': decodedToken['user_country'],
  //       'userName': decodedToken['user_name'],
  //       'userPosition': decodedToken['user_position'],
  //       'userAvatar': decodedToken['user_avatar'],
  //     };
  //   }
  //   isLoading.value = false;
  // }

  Future<http.Response> changePassword(
      String oldpassword, String newpassword) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final Uri url = Uri.parse('${Config.endPoint}/api/users/changepassword');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final body =
        jsonEncode({'oldpassword': oldpassword, "newpassword": newpassword});
    return await http.patch(url, headers: headers, body: body);
  }

  Future<void> getAllProfie() async {
    isLoading.value = true;
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final Uri url = Uri.parse('${Config.endPoint}/api/users/getallusers');
    final response = await http.get(url, headers: headers);
    try {
      if (response.statusCode == 200) {
        print(response.body);
        final postsData = usersFromJson(response.body);
        allusers.assignAll(postsData.users!.whereType<User>());
        update_();
        // print(allusers);

        // update();
      } else if (response.statusCode == 404) {
        print(response.body);
      } else {
        Get.snackbar("Error Loading data",
            'Server Response: ${response.statusCode}:${response.reasonPhrase.toString()}');
      }
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<http.Response> editProfile(
      String name, String country, String position, String? filepath) async {
    print(filepath);
    // var token  = getToken();
    // print(token);
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final Uri url = Uri.parse('${Config.endPoint}/api/users/editprofile');
    var request = http.MultipartRequest('PATCH', url);
    request.fields['username'] = name;
    request.fields['country'] = country;
    request.fields['position'] = position;
    // ระบุชื่อฟิลด์และส่งรูปภาพจาก filepath
    if (filepath != null) {
      request.files.add(http.MultipartFile(
        'avatar',
        File(filepath).readAsBytes().asStream(),
        File(filepath).lengthSync(),
        filename: filepath,
        contentType: MediaType('image', filepath.split(".").last),
      ));
    }
    request.headers.addAll({
      'Content-Type': 'multipart/form-data',
      'Authorization': 'Bearer $token',
    });
    // ทำการส่งคำขอและรับคำขอ
    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    return response;
  }

// ! getprofileme
  Future<void> getProfile() async {
    isLoading.value = true;
    // print(profileid.value);
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token != null && JwtDecoder.isExpired(token) == false) {
      final Map<String, dynamic> decodedToken =
          JwtDecoder.decode(token)['result'];
      profileDetail!.value = {
        'userId': decodedToken['user_id'],
        'userCountry': decodedToken['user_country'],
        'userName': decodedToken['user_name'],
        'userPosition': decodedToken['user_position'],
        'userAvatar': decodedToken['user_avatar'],
      };
    }
    profileid.value = profileDetail!['userId'];
    print(("profileid.value function getprofile"));
    print(profileid.value);
    final response = await http.get(Uri.parse(
        '${Config.endPoint}/api/users/getbyuserid/${profileid.value}'));
    try {
      if (response.statusCode == 200) {
        // print(response.body);
        print(response.body);
        // final dynamic jsonData = jsonDecode(response.body);
        // final data = jsonDecode(response.body)['data'];

// 1. แปลง JSON ใน 'data' เป็น Map
        final Map<String, dynamic> data = jsonDecode(response.body)['data'];
        // print(data.runtimeType);
        // print(data);

// 2. สร้าง ProfileModel จากข้อมูลใน 'data'
        final ProfileModel profileModel = ProfileModel.fromJson(data);
        profileList.clear();
// 3. เพิ่ม ProfileModel เข้าไปใน profileList
        profileList.add(profileModel);
        print(json.encode(profileList));
        print(profileList);
        print("profileList[0].userIsAdmin");
        print(profileList[0].userIsAdmin);
        print("isAdmin.value");
        print(isAdmin.value);
        isAdmin.value = profileList[0].userIsAdmin;
        print("isAdmin.value");
        print(isAdmin.value);
        // final List<dynamic> result = jsonData["data"] as List<dynamic>;
        // print(result);
        // profileList.value =
        // result.map((e) => ProfileModel.fromJson(e).data).toList();
        // update();
      } else if (response.statusCode == 404) {
        print(response.body);
      } else {
        Get.snackbar("Error Loading data",
            'Server Response: ${response.statusCode}:${response.reasonPhrase.toString()}');
      }
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

// ! getuserAnotherprofile
  Future<void> getuserAnotherProfile() async {
    // print(profileid.value);
    // isLoading.value = true;
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final Uri url = Uri.parse(
        '${Config.endPoint}/api/users/getbyuserid/${anotherprofileid.value}');
    final response = await http.get(url, headers: headers);

    try {
      if (response.statusCode == 200) {
// 1. แปลง JSON ใน 'data' เป็น Map
        final Map<String, dynamic> data = jsonDecode(response.body)['data'];
        // print(data.runtimeType);
        // print(data);

// 2. สร้าง ProfileModel จากข้อมูลใน 'data'
        final ProfileModel profileModel = ProfileModel.fromJson(data);
        useranotherprofile.clear();
// 3. เพิ่ม ProfileModel เข้าไปใน profileList
        useranotherprofile.add(profileModel);
        print(json.encode(useranotherprofile));
        print(useranotherprofile);

        // update();
      } else if (response.statusCode == 404) {
        print(response.body);
      } else {
        Get.snackbar("Error Loading data",
            'Server Response: ${response.statusCode}:${response.reasonPhrase.toString()}');
      }
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

// ! getbandAnotherprofile
  Future<void> getbandAnotherprofile() async {
    // isLoading.value = true;
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final Uri url = Uri.parse(
      '${Config.endPoint}/api/bands/getbybandid/${anotherprofileid.value}',
    );
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final response = await http.get(url, headers: headers);

    try {
      if (response.statusCode == 200) {
        print(response.body);

// 1. แปลง JSON ใน 'data' เป็น Map
        final Map<String, dynamic> data = jsonDecode(response.body)['data'];
        // print(data.runtimeType);
        // print(data);

// 2. สร้าง ProfileModel จากข้อมูลใน 'data'
        final Band profileModel = Band.fromJson(data);
// 2.1 ลบข้อมูลชุดเดิมออกก่อน
        bandanotherprofile.clear();
// 3. เพิ่ม ProfileModel เข้าไปใน profileList
        bandanotherprofile.add(profileModel);
      } else if (response.statusCode == 404) {
        print(response.body);
      } else {
        Get.snackbar("Error Loading data",
            'Server Response: ${response.statusCode}:${response.reasonPhrase.toString()}');
      }
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

// ! Addfollow
  Future<void> dofollow() async {
    print("bandService.bandsController.isBand.value");
    print(bandService.bandsController.isBand.value);
    print("bandService.profileController.anotherProfileType.value");
    print(bandService.profileController.anotherProfileType.value);
    http.Response? response; // Initialize with null
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    // final Uri url = Uri.parse('${Config.endPoint}/api/users/addfollowers');
    // var body = {'followers_id': profileid.value};
    // final headers = {
    //   'Content-Type': 'application/json',
    //   'Authorization': 'Bearer $token',
    // };
    // var body = jsonEncode({'followers_id': followersid});
    // final response = await http.post(url, headers: headers, body: body);
    // print(response.body);
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
// ! User
    if (bandService.bandsController.isBand.value == false) {
      // ! followuser
      if (bandService.profileController.anotherProfileType.value == "user") {
        final Uri url =
            Uri.parse('${Config.endPoint}/api/follows/addfollowersbyuser');
        final body = jsonEncode({'followersuser_id': anotherprofileid.value});
        response = await http.post(url, headers: headers, body: body);
        // ! followband
      } else if (bandService.profileController.anotherProfileType.value ==
          "band") {
        final Uri url =
            Uri.parse('${Config.endPoint}/api/follows/addfollowersbyuser');
        final body = jsonEncode({'followersband_id': anotherprofileid.value});
        response = await http.post(url, headers: headers, body: body);
      }
      // ! Band
    } else if (bandService.bandsController.isBand.value == true) {
      // ! followuser
      if (bandService.profileController.anotherProfileType.value == "user") {
        final Uri url =
            Uri.parse('${Config.endPoint}/api/follows/addfollowersbyband');
        final body = jsonEncode({
          'band_id': bandService.bandsController.bandid.value,
          'followersuser_id': anotherprofileid.value
        });
        response = await http.post(url, headers: headers, body: body);
        // ! followband
      } else if (bandService.profileController.anotherProfileType.value ==
          "band") {
        final Uri url =
            Uri.parse('${Config.endPoint}/api/follows/addfollowersbyband');
        final body = jsonEncode({
          'band_id': bandService.bandsController.bandid.value,
          'followersband_id': anotherprofileid.value
        });
        response = await http.post(url, headers: headers, body: body);
      }
    }
    if (response != null) {
      try {
        if (response.statusCode == 409) {
          print('already follow');
          // isFollowing.value = true;
        } else if (response.statusCode == 200) {
          isFollowing.value = true;
          followerstest();
          followingtest();
          // Handle other successful responses if needed
        } else {
          // Handle other error responses if needed
        }
      } catch (e) {
        print(e.toString());
      }
    }
  }

// ! unfollow
  Future<void> doUnfollow() async {
    print("bandService.bandsController.isBand.value");
    print(bandService.bandsController.isBand.value);
    print("bandService.profileController.anotherProfileType.value");
    print(bandService.profileController.anotherProfileType.value);
    print("bandService.bandsController.bandid.value");
    print(bandService.bandsController.bandid.value);
    print("anotherprofileid.value");
    print(anotherprofileid.value);
    http.Response? response; // Initialize with null
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    // print(profileid.value);
    // final Uri url = Uri.parse('${Config.endPoint}/api/users/unfollowers');
    // var body = {'followers_id': profileid.value};
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    if (bandService.bandsController.isBand.value == false) {
      if (bandService.profileController.anotherProfileType.value == "user") {
        final Uri url =
            Uri.parse('${Config.endPoint}/api/follows/userunfollowers/user');
        final body = jsonEncode({'followersuser_id': anotherprofileid.value});
        response = await http.delete(url, headers: headers, body: body);
      } else if (bandService.profileController.anotherProfileType.value ==
          "band") {
        final Uri url =
            Uri.parse('${Config.endPoint}/api/follows/userunfollowers/band');
        final body = jsonEncode({'followersband_id': anotherprofileid.value});
        response = await http.delete(url, headers: headers, body: body);
      }
    } else if (bandService.bandsController.isBand.value == true) {
      if (bandService.profileController.anotherProfileType.value == "user") {
        final Uri url =
            Uri.parse('${Config.endPoint}/api/follows/bandunfollowers/user');
        final body = jsonEncode({
          'band_id': bandService.bandsController.bandid.value,
          'followersuser_id': anotherprofileid.value
        });
        response = await http.delete(url, headers: headers, body: body);
      } else if (bandService.profileController.anotherProfileType.value ==
          "band") {
        final Uri url =
            Uri.parse('${Config.endPoint}/api/follows/bandunfollowers/band');
        final body = jsonEncode({
          'band_id': bandService.bandsController.bandid.value,
          'followersband_id': anotherprofileid.value
        });
        response = await http.delete(url, headers: headers, body: body);
      }
    }
    if (response != null) {
      try {
        if (response.statusCode == 200) {
          isFollowing.value = false;
          followerstest();
          followingtest();
          // Handle other successful responses if needed
        } else {
          // Handle other error responses if needed
        }
      } catch (e) {
        print(e.toString());
      }
    }
  }

// ! checkfollow to be use for button follow or unfollow by check in DB
  Future<void> checkfollow() async {
    http.Response? response; // Initialize with null
    print("bandService.profileController.anotherProfileType.value");
    print(bandService.profileController.anotherProfileType.value);
    print("bandService.profileController.anotherprofileid.value");
    print(bandService.profileController.anotherprofileid.value);
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    if (bandService.bandsController.isBand.value == false) {
      if (bandService.profileController.anotherProfileType.value == "user") {
        final Uri url =
            Uri.parse('${Config.endPoint}/api/follows/checkuserfollowers/user');
        final body = jsonEncode({'user_id': anotherprofileid.value});
        response = await http.post(url, headers: headers, body: body);
      } else if (bandService.profileController.anotherProfileType.value ==
          "band") {
        print("anotherpro band");
        final Uri url =
            Uri.parse('${Config.endPoint}/api/follows/checkuserfollowers/band');
        final body = jsonEncode({'band_id': anotherprofileid.value});
        response = await http.post(url, headers: headers, body: body);
      }
    } else if (bandService.bandsController.isBand.value == true) {
      if (bandService.profileController.anotherProfileType.value == "user") {
        final Uri url =
            Uri.parse('${Config.endPoint}/api/follows/checkbandfollowers/user');
        final body = jsonEncode({
          'band_id': bandService.bandsController.bandid.value,
          'user_id': anotherprofileid.value
        });
        response = await http.post(url, headers: headers, body: body);
      } else if (bandService.profileController.anotherProfileType.value ==
          "band") {
        final Uri url =
            Uri.parse('${Config.endPoint}/api/follows/checkbandfollowers/band');
        final body = jsonEncode({
          'band_id': bandService.bandsController.bandid.value,
          'followersband_id': anotherprofileid.value
        });
        response = await http.post(url, headers: headers, body: body);
      }
    }

    // Check if 'response' is not null before using it
    if (response != null) {
      var jsonRes = json.decode(response.body);
      if (response.statusCode == 200) {
        if (jsonRes['followers'] == false) {
          isFollowing.value = false;
        } else if (jsonRes['followers'] == true) {
          isFollowing.value = true;
        }
      } else if (response.statusCode == 409) {
        print('this is profile him');
      }
    } else {
      Get.snackbar("Error Loading data", 'Server Response: null');
    }
  }

  // // ! checkfollowers
  // Future<void> followers() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final token = prefs.getString('token');
  //   // print(profileid.value);
  //   final Uri url = Uri.parse(
  //       '${Config.endPoint}/api/users/getallfollowerByuserid/${profileid.value}');
  //   // var body = {'followers_id': profileid.value};
  //   final headers = {
  //     'Content-Type': 'application/json',
  //     'Authorization': 'Bearer $token',
  //   };
  //   // final body = jsonEncode({'user_id': profileid.value});
  //   final response = await http.get(url, headers: headers);
  //   var jsonRes = json.decode(response.body);
  //   // print(response.body);
  //   try {
  //     if (response.statusCode == 200) {
  //       countFollowers.value = jsonRes['followers_length'];
  //       print('Followers=======================');
  //       var followers = jsonRes['followers'];
  //       personIdList.clear();
  //       for (var follower in followers) {
  //         var personIdData = follower['person_id'];
  //         personIdList.add(personIdData);
  //       }
  //       print(personIdList);
  //       // print(jsonRes['followers_length'].runtimeType);
  //       // print(countFollowers.value.runtimeType);
  //     } else if (response.statusCode == 404) {
  //       if (jsonRes['followers_length'] == 0) {
  //         personIdList.clear();
  //         countFollowers.value = jsonRes['followers_length'];
  //         // Get.snackbar("Error Loading data",
  //         //     'Server Response: ${response.statusCode}:${response.reasonPhrase.toString()}');
  //       }
  //     }
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }

  // ! checkfollowers
  Future<void> followerstest() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    Uri?
        url; // ประกาศตัวแปร url แบบ nullable ด้วย ? และกำหนดค่าเริ่มต้นเป็น null.

    print("bandsController.isBand.value in followers()");
    print(bandService.bandsController.isBand.value);
    if (bandService.profileController.anotherProfileType.value == '') {
      // !  getallfollowerByuserid
      if (bandService.bandsController.isBand.value == false) {
        print(bandService.profileController.profileid.value);
        url = Uri.parse(
            '${Config.endPoint}/api/follows/getallfollowerByuserid/${bandService.profileController.profileid.value}');
      } else if (bandService.bandsController.isBand.value == true) {
        // !  getallfollowerBybandid
        print(bandService.bandsController.bandid.value);
        url = Uri.parse(
            '${Config.endPoint}/api/follows/getallfollowerBybandid/${bandService.bandsController.bandid.value}');
      }
    } else if (bandService.profileController.anotherProfileType.value ==
        'user') {
      url = Uri.parse(
          '${Config.endPoint}/api/follows/getallfollowerByuserid/${bandService.profileController.anotherprofileid.value}');
    } else if (bandService.profileController.anotherProfileType.value ==
        'band') {
      url = Uri.parse(
          '${Config.endPoint}/api/follows/getallfollowerBybandid/${bandService.profileController.anotherprofileid.value}');
    }

    if (url != null) {
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };
      final response = await http.get(url, headers: headers);
      var jsonRes = json.decode(response.body);

      try {
        if (response.statusCode == 200) {
          countFollowers.value = jsonRes['followers_length'];
          print(countFollowers.value);
          print("response status: =  ${response.statusCode}");
          print(jsonRes);
          final List<dynamic> followersList =
              jsonDecode(response.body)['followers'];
          // final List<Follower> followersList = [];
          personDetails.clear();
          bandDetails.clear();
          print("followerJson");
          for (var followerJson in followersList) {
            var bandDetail = followerJson['band_details'];
            var personDetail = followerJson['person_details'];
            // ตรวจสอบว่า bandDetails ไม่ใช่ null ก่อนที่จะเข้าถึงข้อมูล
            if (bandDetail == null) {
              // print('$personDetail');
              // เพิ่ม personDetails ลงในรายการ personDetailsList
              personDetails.add(PersonDetails.fromJson(personDetail));
            } else {
              // print('$bandDetail');
              // เพิ่ม bandDetails ลงในรายการ bandDetailsList
              bandDetails.add(BandDetails.fromJson(bandDetail));
            }
          }
          // personDetails[0].userP
          print("persondetails");
          print(json.encode(personDetails));
          print("bandDetails");
          print(json.encode(bandDetails));
        } else if (response.statusCode == 404) {
          personDetails.clear();
          bandDetails.clear();
          countFollowers.value = jsonRes['followers_length'];
        }
      } catch (e) {
        print(e.toString());
      }
    }
  }

  Future<void> followingtest() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    Uri?
        url; // ประกาศตัวแปร url แบบ nullable ด้วย ? และกำหนดค่าเริ่มต้นเป็น null.

    print("bandsController.isBand.value in following()");
    print(bandService.bandsController.isBand.value);
    if (bandService.profileController.anotherProfileType.value == '') {
      // !  getallfollowerByuserid
      if (bandService.bandsController.isBand.value == false) {
        print(profileid.value);
        url = Uri.parse(
            '${Config.endPoint}/api/follows/getallfollowingByuserid/${bandService.profileController.profileid.value}');
      } else if (bandService.bandsController.isBand.value == true) {
        // !  getallfollowerBybandid
        print(bandService.bandsController.bandid.value);
        url = Uri.parse(
            '${Config.endPoint}/api/follows/getallfollowingBybandid/${bandService.bandsController.bandid.value}');
      }
    } else if (bandService.profileController.anotherProfileType.value ==
        'user') {
      url = Uri.parse(
          '${Config.endPoint}/api/follows/getallfollowingByuserid/${bandService.profileController.anotherprofileid.value}');
    } else if (bandService.profileController.anotherProfileType.value ==
        'band') {
      url = Uri.parse(
          '${Config.endPoint}/api/follows/getallfollowingBybandid/${bandService.profileController.anotherprofileid.value}');
    }

    if (url != null) {
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };
      final response = await http.get(url, headers: headers);
      var jsonRes = json.decode(response.body);

      try {
        if (response.statusCode == 200) {
          countFollowing.value = jsonRes['following_length'];
          print(countFollowing.value);
          print("response status: =  ${response.statusCode}");
          print(jsonRes);
          final List<dynamic> followeringList =
              jsonDecode(response.body)['following'];
          // final List<Follower> followersList = [];
          personDetails.clear();
          bandDetails.clear();
          print("followingJson");
          for (var followingJson in followeringList) {
            var bandDetail = followingJson['band_details'];
            var personDetail = followingJson['person_details'];
            // ตรวจสอบว่า bandDetails ไม่ใช่ null ก่อนที่จะเข้าถึงข้อมูล
            if (bandDetail == null) {
              // print('$personDetail');
              // เพิ่ม personDetails ลงในรายการ personDetailsList
              personDetails.add(PersonDetails.fromJson(personDetail));
            } else {
              // print('$bandDetail');
              // เพิ่ม bandDetails ลงในรายการ bandDetailsList
              bandDetails.add(BandDetails.fromJson(bandDetail));
            }
          }
          // personDetails[0].userP
          print("persondetails");
          print(json.encode(personDetails));
          print("bandDetails");
          print(json.encode(bandDetails));
        } else if (response.statusCode == 404) {
          personDetails.clear();
          bandDetails.clear();
          countFollowing.value = jsonRes['following_length'];
        }
      } catch (e) {
        print(e.toString());
      }
    }
  }

  // // ! checkfollowings
  // Future<void> following() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final token = prefs.getString('token');
  //   // print(profileid.value);
  //   final Uri url = Uri.parse(
  //       '${Config.endPoint}/api/users/getallfollowingByuserid/${profileid.value}');
  //   // var body = {'followers_id': profileid.value};
  //   final headers = {
  //     'Content-Type': 'application/json',
  //     'Authorization': 'Bearer $token',
  //   };
  //   // final body = jsonEncode({'user_id': profileid.value});
  //   final response = await http.get(url, headers: headers);
  //   var jsonRes = json.decode(response.body);
  //   // print(response.body);
  //   try {
  //     if (response.statusCode == 200) {
  //       countFollowing.value = jsonRes['following_length'];
  //       // print(jsonRes['following_length'].runtimeType);
  //       // print(countFollowing.value.runtimeType);
  //       print('Following=======================');
  //       var following = jsonRes['following'];
  //       personIdList.clear();
  //       for (var follower in following) {
  //         var personIdData = follower['followers_id'];
  //         personIdList.add(personIdData);
  //       }
  //       print(personIdList);
  //     } else if (response.statusCode == 404) {
  //       if (jsonRes['following_length'] == 0) {
  //         personIdList.clear();
  //         countFollowing.value = jsonRes['following_length'];
  //       }
  //     }
  //   } catch (e) {
  //     print(profileid.value);
  //     print(countFollowing.value.runtimeType);
  //     print(countFollowing.value);
  //     Get.snackbar("Error Loading data",
  //         'Server Response: ${response.statusCode}:${response.reasonPhrase.toString()}');
  //     print(e.toString());
  //   }
  // }

  // ! checkfollowersuser
  // ! checkfollowersband
  // ! checkfollowingsuser
  // ! checkfollowingsband
  // ! followersusers
  // Future<void> followerusers() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final token = prefs.getString('token');
  //   final Uri url = Uri.parse(
  //     '${Config.endPoint}/api/follows/getallfollowerByuserid/${profileid.value}',
  //   );

  //   final headers = {
  //     'Content-Type': 'application/json',
  //     'Authorization': 'Bearer $token',
  //   };

  //   final response = await http.get(url, headers: headers);
  //   var jsonRes = json.decode(response.body);
  //   try {
  //     if (response.statusCode == 200) {
  //       final Map<String, dynamic> jsonData = json.decode(response.body);

  //       final Followers followers = Followers(
  //         followers: (jsonData['following'] as List).map((followerData) {
  //           final Map<String, dynamic> followerMap =
  //               followerData as Map<String, dynamic>;

  //           final Follower follower = Follower(
  //             followersUid: followerMap['followers_uid'],
  //             personDetails: PersonDetails(
  //               userId: followerMap['person_details']['user_id'],
  //               userEmail: followerMap['person_details']['user_email'],
  //               userName: followerMap['person_details']['user_name'],
  //               userCountry: followerMap['person_details']['user_country'],
  //               userPosition: followerMap['person_details']['user_position'],
  //               userAvatar: followerMap['person_details']['user_avatar'],
  //               userIsAdmin: followerMap['person_details']['user_isAdmin'],
  //               userCreateAt: DateTime.parse(
  //                   followerMap['person_details']['user_createAt']),
  //               userUpdateAt: DateTime.parse(
  //                   followerMap['person_details']['user_updateAt']),
  //               bandId: followerMap['person_details']['band_id'],
  //               bandType: followerMap['person_details']['band_type'],
  //             ),
  //             followersCreateAt:
  //                 DateTime.parse(followerMap['followers_createAt']),
  //             bandDetails: followerMap['band_details'] != null
  //                 ? BandDetails(
  //                     bandId: followerMap['band_details']['band_id'],
  //                     bandName: followerMap['band_details']['band_name'],
  //                     bandCategory: followerMap['band_details']
  //                         ['band_category'],
  //                     bandAvatar: followerMap['band_details']['band_avatar'],
  //                     bandCreateAt: DateTime.parse(
  //                         followerMap['band_details']['band_createAt']),
  //                     bandUpdateAt: DateTime.parse(
  //                         followerMap['band_details']['band_updateAt']),
  //                   )
  //                 : null,
  //           );

  //           return follower;
  //         }).toList(),
  //         followersLength: jsonData['following_length'],
  //       );

  //       // อัปเดตตัวแปร followers ในแอปของคุณโดยใช้ข้อมูลใน followers

  //       countFollowing.value = followers.followersLength;
  //       personIdList.clear();

  //       for (final follower in followers.followers) {
  //         final personIdData = follower.followersUid;
  //         personIdList.add(personIdData);
  //       }
  //       print(personIdList);
  //     } else if (response.statusCode == 404) {
  //       if (jsonRes['following_length'] == 0) {
  //         personIdList.clear();
  //         countFollowing.value = jsonRes['following_length'];
  //       }
  //     }
  //   } catch (e) {
  //     print(profileid.value);
  //     print(countFollowing.value.runtimeType);
  //     print(countFollowing.value);
  //     Get.snackbar(
  //       "Error Loading data",
  //       'Server Response: ${response.statusCode}:${response.reasonPhrase.toString()}',
  //     );
  //     print(e.toString());
  //   }
  // }

  // ! followinguser
  // Future<void> followeringuser() async {}
  // ! followersband
  // ! followingband
  @override
  void onInit() {
    super.onInit();
    // loadProfileData();
    getProfile();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void update_() {
    displayallUsers.value = []; // ลบค่าเก่าทิ้ง
    displayallUsers.addAll(allusers); // เพิ่ม post ที่ผ่านการ where
    print('displaypost length : ${displayallUsers.length}');
  }
}
