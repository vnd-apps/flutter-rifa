import "dart:convert";

import "package:http/http.dart" as http;

import "../../const.dart";
import "../../model/product.dart";

class RemoteOrderService {
  var client = http.Client();

  Future<dynamic> create(
      {required String token, required List<Product> products}) async {
    var body = {"products": products};
    var response = await client.post(
      Uri.parse("$baseUrl/api/order"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
      body: jsonEncode(body),
    );

    return response;
  }

  Future<dynamic> get({
    required String? token,
  }) async {
    var response = await client.get(
      Uri.parse("$baseUrl/api/order"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
    );

    return response;
  }
}
