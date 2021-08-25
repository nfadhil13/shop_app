
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/providers/product_provider.dart';

class ProductListProvider with ChangeNotifier {

  List<ProductProvider> _products = [];

  List<ProductProvider> get products {
    return [..._products];
  }


  ProductProvider findById(String id) {
    return _products.firstWhere((element) => element.id == id);
  }

  List<ProductProvider> get favoriteProducts {
    return _products.where((element) => element.isFavorite).toList();
  }

  Future<void> fetchAndSetProduct() async{
    try{
      print("Fetchin data");
      final endPoint = Uri.parse("https://shop-app-f42ef-default-rtdb.asia-southeast1.firebasedatabase.app/products.json");
      final result = await http.get(endPoint);
      final decodedResult = jsonDecode(result.body) as Map<String, dynamic>;
      _products.clear();
      decodedResult.forEach((key, value) {
        _products.add(ProductProvider.fromJson(value as Map<String, dynamic>, key));
      });
      print(_products);
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }


  Future<ProductProvider> addProduct(ProductProvider newProduct) async {
    try{
      final endPoint = Uri.parse("https://shop-app-f42ef-default-rtdb.asia-southeast1.firebasedatabase.app/products.json");
      final result = await http.post(endPoint, body: json.encode({
        "title": newProduct.title,
        "description": newProduct.description,
        "price": newProduct.price,
        "imageUrl": newProduct.imageUrl,
        "isFavorite": false
      }));
      var _newProduct = ProductProvider(
          id: json.decode(result.body)["name"],
          title: newProduct.title,
          description: newProduct.description,
          price: newProduct.price,
          imageUrl: newProduct.imageUrl
      );
      _products.insert(0, _newProduct);
      notifyListeners();
      return _newProduct;
    }catch(error){
      print(error);
      throw error;
    }
  }

  
  Future<ProductProvider> updateProduct(ProductProvider updatedProduct) async{
    try{
      final oldIndex = _products.indexWhere((element) => element.id == updatedProduct.id);
      if(oldIndex < 0) throw Exception("Invalid product id");
      final endPoint = Uri.parse("https://shop-app-f42ef-default-rtdb.asia-southeast1.firebasedatabase.app/products/${updatedProduct.id}.json");
      final result = await http.patch(endPoint, body: updatedProduct.toJson());
      if(result.statusCode == 200){
        _products[oldIndex] = updatedProduct;
        notifyListeners();
        return updatedProduct;
      }else{
        throw Exception("Failed to update data");
      }
    }catch(error) {
      print(error);
       throw error;
    }
  }

  Future<void> removeItem(String productId) async{
    try{
      //final oldIndex = _products.indexWhere((element) => element.id == updatedProduct.id);
      final endPoint = Uri.parse("https://shop-app-f42ef-default-rtdb.asia-southeast1.firebasedatabase.app/products/$productId.json");
      final result = await http.delete(endPoint);
      print(result.body);
      if(result.statusCode == 200){
        _products.removeWhere((element) => element.id == productId);
        notifyListeners();
      }else{
        throw Exception("Failed to delete");
      }
    }catch(error) {
      print(error);
      throw error;
    }

  }


}