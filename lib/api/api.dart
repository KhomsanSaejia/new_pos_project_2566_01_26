import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:new_pos_project_2566_01_26/model/model_getmeter.dart';
import 'package:new_pos_project_2566_01_26/model/model_products.dart';
import 'package:new_pos_project_2566_01_26/model/model_shift.dart';
import 'package:new_pos_project_2566_01_26/model/model_shift_meter.dart';

class API {
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

  

  Future<String> getDayOpen() async {
    var url = Uri.http(staticurl, '$verapi/day');
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

    try {
      final response = await http.get(url, headers: headers).timeout(
        const Duration(seconds: 5),
        onTimeout: () {
          throw TimeoutException('The request timed out');
        },
      );

      if (response.statusCode == 200) {
        final modelShift =
            ModelShift.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
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

  Future<List<ModelShiftMeter>> getShiftByDate(
      String date, String shift) async {
    final url = Uri.http(
        staticurl, '$verapi/shift/meter', {"date": date, "shiftno": shift});

    try {
      final response = await http.get(url, headers: headers).timeout(
        const Duration(seconds: 5),
        onTimeout: () {
          throw TimeoutException('The request timed out');
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> listDynamic = jsonDecode(response.body);
        return listDynamic
            .map((element) => ModelShiftMeter.fromJson(element))
            .toList();
      } else {
        throw Exception('Failed to get data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to get data: ${e.toString()}');
    }
  }

  Future<List<ModelGetmeter>> getMeter() async {
    List<ModelGetmeter> modelgetmeters = [];
    var url = Uri.http(staticurl, '$verapi/getmeter/openshift');

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
      return modelgetmeters;
    }
    
  }

  Future<List<ModelProducts>> getProducts() async {
    List<ModelProducts> modelProducts = [];
    var url = Uri.http(staticurl, '$verapi/getproduct', {"product_type":"ALL"});

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
      return modelProducts;
    }
    
  }

  Future<String> postOpenShift(String data) async {
    var url = Uri.http(staticurl, '$verapi/openshift');

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
      return "null";
    }
    
  }

  

  API();
}
