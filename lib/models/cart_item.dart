import 'product.dart';

class CartItem {
  Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});

  double get total {
    final price = double.tryParse(product.price.replaceAll("\$", "")) ?? 0;

    return price * quantity;
  }
}
