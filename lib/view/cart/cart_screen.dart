import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_grocery/component/input_text_button.dart';
import 'package:my_grocery/controller/controllers.dart';
import 'package:my_grocery/model/checkout.dart';
import 'package:shimmer/shimmer.dart';

import './components/cart_card.dart';
import 'components/cart_loading.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Cart"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        centerTitle: true,
        elevation: 1,
      ),
      body: Obx(() {
        if (cartController.isCartLoading.isTrue) {
          return const CartLoading();
        } else {
          return RefreshIndicator(
            color: Theme.of(context).primaryColor,
            onRefresh: () async {
              cartController.getCart();
              return Future.delayed(const Duration(seconds: 1));
            },
            child: ListView.separated(
              separatorBuilder: (context, index) => const Divider(
                height: 2,
                color: Colors.orange,
              ),
              itemCount: cartController.cartItemList.length,
              physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics()),
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
                child: Dismissible(
                  key: ValueKey(cartController.cartItemList[index].product),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    cartController.removeCart(
                        product: cartController.cartItemList[index].product);
                  },
                  background: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFE6E6),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      children: [
                        const Spacer(),
                        Icon(
                          Icons.delete_outline,
                          color: Theme.of(context).primaryColor,
                        ),
                      ],
                    ),
                  ),
                  child: CartCard(
                    cartItem: cartController.cartItemList[index],
                  ),
                ),
              ),
            ),
          );
        }
      }),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        height: 70,
        decoration: const BoxDecoration(
            border: Border(top: BorderSide(color: Colors.black87, width: 0.5))),
        child: Obx(
          () => Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              (cartController.isCartLoading.value)
                  ? Shimmer.fromColors(
                      highlightColor: Colors.white,
                      baseColor: Colors.grey.shade300,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 20,
                            width: 100,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Container(
                            height: 16,
                            width: 40,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Total: \$ ${cartController.getCartTotal().toStringAsFixed(2)}",
                          style: const TextStyle(fontSize: 18),
                        ),
                        Text(
                          "Items: ${cartController.cartItemList.length}",
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
              const Spacer(),
              SizedBox(
                  height: 50,
                  width: 140,
                  child: InputTextButton(
                      title: "Checkout", onClick: () => generateOrder()))
            ],
          ),
        ),
      ),
    );
  }

  void generateOrder() {
    if (cartController.cartItemList.isNotEmpty) {
      Checkout checkout = Checkout(
        checkoutItems: cartController.cartItemList
            .map(
              (e) => CheckoutItem(
                productID: e.product.id,
                numbers: e.selectedItems
                    .map((entry) => Number(number: entry))
                    .toList(),
              ),
            )
            .toList(),
      );
      orderController.createOrder(
          token: authController.getToken()!, checkout: checkout);
    } else {
      Get.snackbar("Cart is empty", "Please add some items to cart");
    }
  }
}
