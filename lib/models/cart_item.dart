import 'package:shop_app/providers/product_provider.dart';

class CartItem {

  final String id;
  final int qty;
  final ProductProvider product;
  final double price;

  CartItem({
    required this.id,
    required this.qty,
    required this.product,
    this.price = 0.0
  });

}