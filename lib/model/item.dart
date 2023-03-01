class Item {
  final int id;
  final String status;
  final int number;

  Item({required this.id, required this.status, required this.number});

  factory Item.fromJson(Map<String, dynamic> data) =>
      Item(id: data['id'], status: data['status'], number: data['number']);
}
