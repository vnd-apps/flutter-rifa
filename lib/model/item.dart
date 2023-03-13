import "package:hive/hive.dart";

part "item.g.dart";

@HiveType(typeId: 6)
class Item {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String status;
  @HiveField(2)
  final int number;

  Item({required this.id, required this.status, required this.number});

  factory Item.fromJson(Map<String, dynamic> data) => Item(
      id: data['id'], status: data['status'] ?? '', number: data['number']);
}
