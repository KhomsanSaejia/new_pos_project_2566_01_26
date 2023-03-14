import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/model_dispenser_status.dart';
import '../model/model_products.dart';
import '../model/model_sale_now.dart';

class ApiSale {
  // String staticurl = "innoligent1.ddns.net:24004";
  String staticurl = "192.168.1.45:8088";
  String verapi = "/v1";
  Map<String, String> headers = {
    "Access-Control-Allow-Origin": "*",
    "Access-Control-Allow-Methods": "*",
    "Access-Control-Allow-Headers": "*",
    "Bypass-Tunnel-Reminder": "true",
    "content-type": "application/json"
  };

  Future<List<ModelDispenserStatus>> getDispenserStatus() async {
    final url = Uri.http(staticurl, '$verapi/dispenser/status');
    final response = await http.get(url, headers: headers).timeout(
      const Duration(seconds: 5),
      onTimeout: () {
        throw TimeoutException('The connection timed out');
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to load dispenser status');
    }

    final jsonList = jsonDecode(utf8.decode(response.bodyBytes)) as List;
    final modelDispenserStatusS =
        jsonList.map((json) => ModelDispenserStatus.fromJson(json)).toList();

    return modelDispenserStatusS;
  }

  Future<List<ModelSaleNow>> getAllTransactionNow() async {
    final url = Uri.http(staticurl, '$verapi/transaction/now');
    final response = await http.get(url, headers: headers).timeout(
      const Duration(seconds: 5),
      onTimeout: () {
        throw TimeoutException('The connection timed out');
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to load data');
    }

    final List<dynamic> data = json.decode(response.body);
    final List<ModelSaleNow> modelSaleNows =
        data.map((item) => ModelSaleNow.fromJson(item)).toList();

    return modelSaleNows;
  }

  Future<List<ModelProducts>> getProductsNonOil() async {
    List<ModelProducts> modelProducts = [];
    var url =
        Uri.http(staticurl, '$verapi/getproduct', {"product_type": "NON-OIL"});

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

  Future<void> updateTranSactionSelect(int id, int status) async {
    var url = Uri.http(staticurl, '$verapi/transaction/select');

    final msg = jsonEncode({
      'id': id,
      'status': status,
    });

    await http.post(url, headers: headers, body: msg).timeout(
      const Duration(seconds: 5),
      onTimeout: () {
        throw TimeoutException('The connection timed out');
      },
    );
  }

  ApiSale();
}
