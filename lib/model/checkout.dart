class Checkout {
  final List<CheckoutItem> checkoutItems;

  Map toJson() => {
        "products": checkoutItems.map((e) => e.toJson()).toList(),
      };

  Checkout({
    required this.checkoutItems,
  });
}

class CheckoutItem {
  final int productID;
  final List<Number> numbers;

  CheckoutItem({
    required this.productID,
    required this.numbers,
  });

  Map toJson() => {
        "id": productID,
        "items": numbers,
      };
}

class Number {
  final int number;

  Number({
    required this.number,
  });

  Map toJson() => {
        "number": number,
      };
}
