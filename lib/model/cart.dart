import "package:hive/hive.dart";
import "package:my_grocery/model/product.dart";

part "cart.g.dart";

@HiveType(typeId: 5)
class CartItem {
  @HiveField(0)
  final String userID;
  @HiveField(1)
  final Product product;

  CartItem({
    required this.userID,
    required this.product,
  });
}
