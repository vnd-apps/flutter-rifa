import 'package:flutter/material.dart';

import '../../../model/item.dart';

class ProductSelectableItem extends StatelessWidget {
  final Item item;
  final bool selected;
  final ValueChanged<bool>? onSelected;

  const ProductSelectableItem(
      {Key? key, required this.item, required this.selected, this.onSelected})
      : super(key: key);

  void _handleTap(BuildContext context) {
    if (_isEnabled(item.status)) {
      onSelected?.call(!selected);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('This item cannot be selected.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  bool _isEnabled(String status) {
    return status == 'Open';
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _handleTap(context),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          border: Border.all(
            color: _isEnabled(item.status) ? Colors.grey : Colors.red,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(8.0),
          color: selected ? Colors.blue : Colors.white,
        ),
        child: Text(
          item.number.toString(),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
            color: selected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
