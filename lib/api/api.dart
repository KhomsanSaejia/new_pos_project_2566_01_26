import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:new_pos_project_2566_01_26/model/model_getmeter.dart';
import 'package:new_pos_project_2566_01_26/model/model_products.dart';
import 'package:new_pos_project_2566_01_26/model/model_shift.dart';
import 'package:new_pos_project_2566_01_26/utility/style.dart';

class API {
  String staticurl = "192.168.1.45:8088";
  String verapi = "/v1";

  Future<String> login(String username, String password) async {
    var url = Uri.http(staticurl, '$verapi/login',
        {"username": username, "password": MyObject().passwordhash(password)});
    var headers = {"content-type": "application/json"};
    var response = await http.get(url, headers: headers).timeout(
      const Duration(seconds: 5),
      onTimeout: () {
        return http.Response('Timeout', 408);
      },
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
      if (data["status"] == true && data["resp_code"] == 200) {
        return utf8.decode(response.bodyBytes);
      } else {
        return utf8.decode(response.bodyBytes);
      }
    } else {
      return "null";
    }
  }

  Future<String> getDayOpen() async {
    var url = Uri.http(staticurl, '$verapi/day');
    var headers = {"content-type": "application/json"};
    var response = await http.get(url, headers: headers).timeout(
      const Duration(seconds: 5),
      onTimeout: () {
        return http.Response('Timeout', 408);
      },
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
      return data["resp_msg"];
    } else {
      return "null";
    }
  }
  Future<ModelShift> getDayOpenByDate(String date) async {
  final url = Uri.http(staticurl, '$verapi/daybydate', {"date": date});
  final headers = {"content-type": "application/json"};

  try {
    final response = await http.get(url, headers: headers).timeout(
      const Duration(seconds: 5),
      onTimeout: () {
        throw TimeoutException('The request timed out');
      },
    );

    if (response.statusCode == 200) {
      final modelShift = ModelShift.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
      return modelShift;
    } else {
      throw Exception('Failed to get data: ${response.statusCode}');
    }
  } on SocketException catch (_) {
    throw Exception('Failed to connect to the server');
  } on TimeoutException catch (_) {
    throw Exception('The request timed out');
  } catch (e) {
    throw Exception('Failed to get data: ${e.toString()}');
  }
}


  // Future<ModelShift> getDayOpenByDate(String date) async {
  //   ModelShift? modelShift;
  //   var url = Uri.http(staticurl, '$verapi/daybydate', {"date": date});
  //   var headers = {"content-type": "application/json"};
  //   var response = await http.get(url, headers: headers).timeout(
  //     const Duration(seconds: 5),
  //     onTimeout: () {
  //       return http.Response('Timeout', 408);
  //     },
  //   );
  //   if (response.statusCode == 200) {
  //     modelShift = ModelShift.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  //     return modelShift;
  //   } else {
  //     return modelShift!;
  //   }
  // }

  Future<List<ModelGetmeter>> getMeter() async {
    List<ModelGetmeter> modelgetmeters = [];
    var url = Uri.http(staticurl, '$verapi/getmeter/openshift');
    var headers = {"content-type": "application/json"};

    try {
      var response = await http.get(url, headers: headers).timeout(
        const Duration(seconds: 5),
        onTimeout: () {
          throw TimeoutException('The connection timed out');
        },
      );
      if (response.statusCode == 200) {
        List<dynamic> listDynamic = jsonDecode(utf8.decode(response.bodyBytes));
        for (var element in listDynamic) {
          ModelGetmeter modelGetmeter = ModelGetmeter.fromJson(element);
          modelgetmeters.add(modelGetmeter);
        }
      }
      return modelgetmeters;
    } catch (e) {
      print('Error occurred: $e');
    }
    return modelgetmeters;
  }

  Future<List<ModelProducts>> getProducts() async {
    List<ModelProducts> modelProducts = [];
    var url = Uri.http(staticurl, '$verapi/getproduct/all');
    var headers = {"content-type": "application/json"};

    try {
      var response = await http.get(url, headers: headers).timeout(
        const Duration(seconds: 5),
        onTimeout: () {
          throw TimeoutException('The connection timed out');
        },
      );
      if (response.statusCode == 200) {
        List<dynamic> listDynamic = jsonDecode(utf8.decode(response.bodyBytes));
        for (var element in listDynamic) {
          ModelProducts modelProduct = ModelProducts.fromJson(element);
          modelProducts.add(modelProduct);
        }
      }
      return modelProducts;
    } catch (e) {
      print('Error occurred: $e');
    }
    return modelProducts;
  }

  Future<String> postOpenShift(String data) async {
    var url = Uri.http(staticurl, '$verapi/openshift');
    Map<String, String> headers = {
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Methods": "*",
      "Access-Control-Allow-Headers": "*",
      "Bypass-Tunnel-Reminder": "true",
      "content-type": "application/json"
    };

    try {
      var response = await http.post(url, headers: headers, body: data).timeout(
        const Duration(seconds: 5),
        onTimeout: () {
          throw TimeoutException('The connection timed out');
        },
      );

      Map<String, dynamic> dataReturn =
          jsonDecode(utf8.decode(response.bodyBytes));
      return dataReturn["resp_msg"];
    } catch (e) {
      print('Error occurred: $e');
    }
    return "null";
  }

  API();
}
