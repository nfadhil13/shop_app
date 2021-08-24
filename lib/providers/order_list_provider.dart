import 'package:flutter/material.dart';
import 'package:shop_app/models/cart_item.dart';
import 'package:shop_app/models/order_item.dart';
import 'package:shop_app/providers/cart_provider.dart';

class OrderListProvider with ChangeNotifier {

  List<OrderItem> _items = [];


  List<OrderItem> get item {
    return [..._items];
  }

  void addNewOrder(List<CartItem> cartItemList, double totalAmount){
    final newOrder = OrderItem(
      id: DateTime.now().toIso8601String(),
      dateTime: DateTime.now(),
      amount: totalAmount,
      cartItems: cartItemList
    );
    _items.insert(0, newOrder);
    notifyListeners();
  }

}