import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

import '../../../const.dart';
import '../../../model/cart.dart';

class CartCard extends StatelessWidget {
  final CartItem cartItem;
  const CartCard({Key? key, required this.cartItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 88,
          child: AspectRatio(
            aspectRatio: 0.88,
            child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: CachedNetworkImage(
                  imageUrl: cartItem.product.images.first,
                  errorWidget: (context, url, error) => const Center(
                    child: Icon(
                      Icons.error_outline,
                      color: Colors.grey,
                    ),
                  ),
                )),
          ),
        ),
        const SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              cartItem.product.name,
              style: const TextStyle(color: Colors.black, fontSize: 16),
              maxLines: 2,
            ),
            const SizedBox(height: 10),
            Wrap(
              children: cartItem.selectedItems
                  .mapIndexed(
                    (index, item) => Text.rich(
                      TextSpan(
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).primaryColor),
                        children: [
                          TextSpan(
                            text:
                                "${item.toString()} ${index == cartItem.selectedItems.length - 1 ? " x ${cartItem.product.price.toStringAsFixed(2)}" : "|"} ",
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        )
      ],
    );
  }
}
