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
                child: SingleChildScrollView(
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
                          'R\$${productController.product.value.price.toStringAsFixed(2)}',
                          style: TextStyle(
                              fontSize: 18,
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          'Exterior: Field-Tested',
                          style: TextStyle(
                              fontSize: 14, color: Colors.grey.shade700),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          'Float: 0.15',
                          style: TextStyle(
                              fontSize: 14, color: Colors.grey.shade700),
                        ),
                      ),
                      Container(
                        height: 30,
                        width: 320,
                        alignment: const Alignment((0.15 * 2) - 1, 0),
                        child: Icon(
                          Icons.arrow_drop_down,
                          size: 30,
                          color: Colors.grey.shade700,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        height: 10,
                        width: 320, // set a fixed height for the row
                        child: Row(
                          children: [
                            SizedBox(
                              width: 300 * 0.07,
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.horizontal(
                                      left: Radius.circular(10),
                                    ),
                                    color: Colors.green[800]),
                              ),
                            ),
                            SizedBox(
                              width: 300 * 0.08,
                              child: Container(
                                color: Colors.green[300],
                              ),
                            ),
                            SizedBox(
                              width: 300 * 0.23,
                              child: Container(
                                color: Colors.yellow[700],
                              ),
                            ),
                            SizedBox(
                              width: 300 * 0.07,
                              child: Container(
                                color: Colors.orange[700],
                              ),
                            ),
                            SizedBox(
                              width: 300 * 0.55,
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.horizontal(
                                      right: Radius.circular(10),
                                    ),
                                    color: Colors.red[800]),
                              ),
                            ),
                          ],
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
                                  width: MediaQuery.of(context).size.width / 5 -
                                      20,
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
                    ],
                  ),
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
