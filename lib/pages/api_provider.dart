import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'dart:io';
import 'dart:async';

import '../data/models/dropdown_province_model.dart';
import '../utils/config.dart';

class ApiProvider {
  ApiProvider();

//! Login(Post)
  Future<http.Response> doLogin(String email, String password) async {
    final Uri url = Uri.parse('${Config.endPoint}/api/users/login');
    // String url = '$endPoint/api/users/login';
    var body = {"email": email, 'password': password};
    return await http.post(url, body: body);
    // return http.post(url, body: body);
  }

  Future<http.Response> doRegister(String username, String province,
      String role, String email, String password, String filepath) async {
    print(filepath);
    final Uri url = Uri.parse('${Config.endPoint}/api/users/register');
    var request = http.MultipartRequest('POST', url);
    request.fields['username'] = username;
    request.fields['email'] = email;
    request.fields['password'] = password;
    request.fields['country'] = province;
    request.fields['position'] = role;
    // ระบุชื่อฟิลด์และส่งรูปภาพจาก filepath
    request.files.add(http.MultipartFile(
      'avatar',
      File(filepath).readAsBytes().asStream(),
      File(filepath).lengthSync(),
      filename: filepath,
      contentType: MediaType('image', filepath.split(".").last),
    ));
    request.headers.addAll({
      'Content-Type': 'multipart/form-data',
    });
    // ทำการส่งคำขอและรับคำขอ
    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    return response;
  }
//   Future<http.Response> doRegister(String username, String province,
//       String role, String email, String password) async {
//     final Uri url = Uri.parse('$endPoint/api/users/');
//     var body = {
//       "username": username,
//       "email": email,
//       "password": password,
//       "country": province,
//       "position": role,
//     };
//     return await http.post(url, body: body);
//   }

  Future<List<ProvinceDropdownModel>> fetchProvinceData() async {
    try {
      final response = await http.get(Uri.parse(Config.provinceAPI));
      final data = jsonDecode(response.body) as List;
      if (response.statusCode == 200) {
        final List<ProvinceDropdownModel> provinces =
            data.map((item) => ProvinceDropdownModel.fromJson(item)).toList();
        provinces.insert(
          0,
          ProvinceDropdownModel(
            nameTh: 'All',
            nameEn: 'All',
          ),
        );

        return provinces;
      } else {
        throw Exception('ไม่สามารถร้องขอข้อมูลจังหวัดได้');
      }
    } on SocketException {
      throw Exception('Error fetching data from');
    }
  }
  Future<List<ProvinceDropdownModel>> fetchProvinceDatad() async {
    try {
      final response = await http.get(Uri.parse(Config.provinceAPI));
      final data = jsonDecode(response.body) as List;
      if (response.statusCode == 200) {
        final List<ProvinceDropdownModel> provinces =
            data.map((item) => ProvinceDropdownModel.fromJson(item)).toList();

        return provinces;
      } else {
        throw Exception('ไม่สามารถร้องขอข้อมูลจังหวัดได้');
      }
    } on SocketException {
      throw Exception('Error fetching data from');
    }
  }
}

  // Future<http.Response> doGetuser(String username) async{
  //   final Uri url = Uri.parse('$endPoint/api/users/$username');
  //   return await http.get(url);
  // }
