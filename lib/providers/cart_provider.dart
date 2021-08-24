import 'package:flutter/material.dart';
import 'package:shop_app/models/cart_item.dart';
import 'package:shop_app/providers/product_provider.dart';

class CartProvider with ChangeNotifier {

  Map<String, CartItem> _items = {};


  Map<String, CartItem> get cartList {
    return {..._items} ;
  }

  List<CartItem> get cartItemInList {
    return _items.values.toList();
}

  double get totalAmount {
    var totalAmount = 0.0;
    _items.forEach((key, value) {
      totalAmount += value.price;
    });
    return totalAmount;
  }

  int get cartLength {
    var totalItem = 0;
    _items.forEach((key, value) {
      totalItem += value.qty;
    });
    return totalItem;
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void removeOneItemOrDelete(String productId){
    if(_items.containsKey(productId)){
      if(_items[productId]!.qty <= 1){
        _items.remove(productId);
      }else{
        _items.update(productId, (value) => CartItem(
            id: value.id,
            qty: value.qty - 1,
            price: value.price * (value.qty + -1),
            product: value.product)
        );
      }
      notifyListeners();
    }
  }

  void addProduct(ProductProvider productProvider) {
    if(_items.containsKey(productProvider.id)){
      _items.update(productProvider.id, (value) => CartItem(
          id: value.id,
          qty: value.qty + 1,
          price: productProvider.price * (value.qty + 1),
          product: value.product)
      );
    }else{
      _items.putIfAbsent(productProvider.id, () => CartItem(
          id: DateTime.now().toIso8601String(),
          qty: 1,
          price: productProvider.price,
          product: productProvider
      ));
    }
    notifyListeners();
  }

  void clearProduct() {
    _items = {};
    notifyListeners();
  }

}