import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:new_pos_project_2566_01_26/model/model_user.dart';

import '../utility/style.dart';

class ApiLogin {
  // String staticurl = "innoligent1.ddns.net:24004";
  // String staticurl = "192.168.1.45:8088";
  String staticurl = "192.168.1.94:35542";
  String verapi = "/v1";
  Map<String, String> headers = {
    "Access-Control-Allow-Origin": "*",
    "Access-Control-Allow-Methods": "*",
    "Access-Control-Allow-Headers": "*",
    "Bypass-Tunnel-Reminder": "true",
    "content-type": "application/json"
  };

  Future<ModelUser> login(String username, String password) async {
    ModelUser? modelUser;
    final url = Uri.http(staticurl, '$verapi/login', {
      'username': username,
      'password': MyObject().passwordhash(password),
    });
    http.Response response = await http.get(url, headers: headers).timeout(
        const Duration(seconds: 5),
        onTimeout: () {
          throw TimeoutException('The connection timed out');
        },
      );

    try {
      if (response.statusCode == 200) {
        modelUser =
            ModelUser.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
      }
      return modelUser!;
    } catch (e) {
      print(response.body);
      throw Exception("not found ");
    }
  }

  ApiLogin();
}
