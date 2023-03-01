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

  Future<void> removeFromCart({required CartItem cartItem}) async {
    await _cartBox.delete(cartItem.product.id);
  }

  List<CartItem> get cartItems => _cartBox.values.toList();
}
