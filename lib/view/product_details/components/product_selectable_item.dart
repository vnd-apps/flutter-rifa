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
    return status == 'available';
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _handleTap(context),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.circular(8.0),
          color: !_isEnabled(item.status)
              ? Colors.orange[100]
              : (selected ? Colors.orange : Colors.white),
          boxShadow: selected
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10.0,
                    spreadRadius: 1.0,
                    offset: const Offset(0, 1),
                  )
                ]
              : null,
        ),
        child: Center(
          child: Text(
            item.number.toString(),
            style: TextStyle(
              fontWeight:
                  _isEnabled(item.status) ? FontWeight.bold : FontWeight.normal,
              fontSize: 16.0,
              color: !_isEnabled(item.status)
                  ? Colors.grey
                  : (selected ? Colors.white : Colors.black),
            ),
          ),
        ),
      ),
    );
  }
}
