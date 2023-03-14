import "package:hive/hive.dart";

import "../../model/cart.dart";

class LocalCartService {
  late Box<CartItem> _cartBox;

  Future<void> init() async {
    _cartBox = await Hive.openBox<CartItem>('cart');
  }

  Future<void> addToCart({required CartItem cartItem}) async {
    await _cartBox.put(cartItem.product.id, cartItem);
  }

  Future<void> removeFromCart({required int productID}) async {
    await _cartBox.delete(productID);
  }

  List<CartItem> cartItems() => _cartBox.values.toList();

  Future<void> clear() async {
    await _cartBox.clear();
  }
}
