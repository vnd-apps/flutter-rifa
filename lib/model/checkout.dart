import 'package:hive/hive.dart';

part 'checkout.g.dart';

@HiveType(typeId: 6)
class Checkout {
  @HiveField(0)
  final List<String> products;

  Checkout({
    required this.products,
  });
}
