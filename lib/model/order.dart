import "dart:convert";

import "package:hive/hive.dart";
import "package:my_grocery/model/product.dart";

part "order.g.dart";

List<Order> orderListFromJson(String val) => List<Order>.from(
    json.decode(val)['data'].map((val) => Order.fromJson(val)));

@HiveType(typeId: 6)
class Order {
  @HiveField(1)
  final String status;
  @HiveField(2)
  final String qrCode;
  @HiveField(3)
  final String qrCodeBase64;
  @HiveField(4)
  final List<Product> products;

  Order({
    required this.status,
    required this.qrCode,
    required this.qrCodeBase64,
    required this.products,
  });

  factory Order.fromJson(Map<String, dynamic> data) => Order(
        status: data['status'],
        qrCode: data['qr_code'],
        qrCodeBase64: data['qr_code_base64'],
        products: List<Product>.from(data['products']
            .map((product) => Product.productFromJson(product))),
      );
}
