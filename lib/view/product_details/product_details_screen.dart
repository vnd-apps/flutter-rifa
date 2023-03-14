import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my_grocery/view/product_details/components/product_details_loading.dart';
import 'package:my_grocery/view/product_details/components/product_selectable_item.dart';

import '../../controller/controllers.dart';
import '../account/auth/sign_in_screen.dart';
import 'components/product_carousel_slider.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({Key? key}) : super(key: key);

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  NumberFormat formatter = NumberFormat('00');
  Map<int, bool> _itemSelectedMap = {};

  @override
  void initState() {
    super.initState();
    _itemSelectedMap = {
      for (var item in productController.product.value.items) item.number: false
    };
  }

  void _onItemSelected(int id, bool selected) {
    setState(() {
      _itemSelectedMap[id] = selected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => productController.isProductDetailLoading.isTrue
          ? const ProductDetailsLoading()
          : Scaffold(
              body: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProductCarouselSlider(
                      images: productController.product.value.images,
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        productController.product.value.name,
                        style: TextStyle(
                            fontSize: 24,
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        '\$${productController.product.value.price.toStringAsFixed(2)}',
                        style: TextStyle(
                            fontSize: 18,
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Wrap(
                        spacing: 4,
                        runSpacing: 4,
                        children: productController.product.value.items
                            .map(
                              (item) => SizedBox(
                                width:
                                    MediaQuery.of(context).size.width / 5 - 20,
                                child: ProductSelectableItem(
                                  item: item,
                                  selected:
                                      _itemSelectedMap[item.number] ?? false,
                                  onSelected: (selected) =>
                                      _onItemSelected(item.number, selected),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        'About this product:',
                        style: TextStyle(
                            fontSize: 16,
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        productController.product.value.description,
                        style: TextStyle(
                            fontSize: 16, color: Colors.grey.shade700),
                      ),
                    )
                  ],
                ),
              ),
              bottomNavigationBar: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Theme.of(context).primaryColor),
                  ),
                  onPressed: () {
                    try {
                      if (authController.getUser() != null) {
                        cartController.addCart(
                            product: productController.product.value,
                            selectedItems: _itemSelectedMap,
                            userID: authController.user.value!.id);
                        Navigator.of(context).pop();
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignInScreen()));
                      }
                    } finally {}
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(6.0),
                    child: Text(
                      'Add to Card',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
