import "dart:convert";

import "package:http/http.dart" as http;
import "package:my_grocery/model/checkout.dart";

import "../../const.dart";

class RemoteOrderService {
  var client = http.Client();

  Future<dynamic> create(
      {required String token, required Checkout checkout}) async {
    var response = await client.post(
      Uri.parse("$baseUrl/api/orders"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
      body: jsonEncode(checkout),
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
