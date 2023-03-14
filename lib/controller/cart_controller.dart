import 'package:get/get.dart';
import 'package:my_grocery/service/local_service/local_cart_service.dart';

import '../model/cart.dart';
import '../model/product.dart';

class CartController extends GetxController {
  static CartController instance = Get.find();
  RxList<CartItem> cartItemList = List<CartItem>.empty(growable: true).obs;
  RxBool isCartLoading = false.obs;
  final LocalCartService _localCartService = LocalCartService();

  @override
  void onInit() async {
    await _localCartService.init();
    getCart();
    super.onInit();
  }

  void addCart({
    required Product product,
    required int userID,
    required Map<int, bool> selectedItems,
  }) async {
    try {
      _localCartService.addToCart(
        cartItem: CartItem(
          product: product,
          userID: userID,
          selectedItems: selectedItems.entries
              .where((element) => element.value)
              .map((e) => e.key)
              .toList(),
        ),
      );
    } finally {}
  }

  void getCart() async {
    try {
      isCartLoading(true);
      cartItemList.assignAll(_localCartService.cartItems());
    } finally {
      isCartLoading(false);
    }
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
      _localCartService.removeFromCart(productID: product.id);
    } finally {}
  }

  void clearCart() {
    _localCartService.clear();
  }
}
