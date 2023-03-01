import 'package:get/get.dart';
import 'package:my_grocery/service/local_service/local_cart_service.dart';

import '../model/cart.dart';
import '../model/product.dart';

class CartController extends GetxController {
  static CartController instance = Get.find();
  RxList<CartItem> cartItemList = List<CartItem>.empty(growable: true).obs;
  RxBool isCartLoading = false.obs;

  void addCart({
    required Product product,
  }) async {
    try {
      LocalCartService().addToCart(
        cartItem: CartItem(
          product: product,
          userID: "1234",
        ),
      );
    } finally {}
  }

  double getCartTotal() {
    double total = 0;
    try {
      for (var item in cartItemList) {
        total = total + (item.product.items.length * item.product.price);
      }
    } finally {}
    return total;
  }

  void removeCart({required Product product}) {
    try {
      LocalCartService()
          .removeFromCart(cartItem: CartItem(userID: "1234", product: product));
    } finally {}
  }
}
