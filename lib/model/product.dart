import 'dart:convert';

import 'package:hive/hive.dart';

import 'item.dart';

part 'product.g.dart';

List<Product> popularProductListFromJson(String val) => List<Product>.from(
    json.decode(val)['data'].map((val) => Product.popularProductFromJson(val)));

List<Product> productListFromJson(String val) => List<Product>.from(
    json.decode(val)['data'].map((val) => Product.productFromJson(val)));

@HiveType(typeId: 3)
class Product {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final String status;
  @HiveField(4)
  final double price;
  @HiveField(5)
  final List<String> images;
  @HiveField(6)
  final List<Item> items;

  Product(
      {required this.id,
      required this.name,
      required this.description,
      required this.status,
      required this.price,
      required this.images,
      required this.items});

  factory Product.popularProductFromJson(Map<String, dynamic> data) => Product(
      id: data['id'],
      name: data['attributes']['product']['data']['attributes']['name'],
      description: data['attributes']['product']['data']['attributes']
          ['description'],
      status: data['attributes']['product']['data']['attributes']['status'],
      price: data['attributes']['product']['data']['attributes']['price']
          .toDouble(),
      images: List<String>.from(data['attributes']['product']['data']
              ['attributes']['images']['data']
          .map((image) => image['attributes']['url'])),
      items: []);

  factory Product.productFromJson(Map<String, dynamic> data) => Product(
      id: data['id'],
      name: data['attributes']['name'],
      description: data['attributes']['description'],
      status: data['attributes']['status'],
      price: data['attributes']['price'].toDouble(),
      images: List<String>.from(data['attributes']['images']['data']
          .map((image) => image['attributes']['url'])),
      items: List<Item>.from(
          data['attributes']['items'].map((val) => Item.fromJson(val))));
}
