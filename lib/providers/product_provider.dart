
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductProvider with ChangeNotifier {

  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;


  ProductProvider({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false
  });

  factory ProductProvider.fromJson(Map<String, dynamic> json , String id) {
    return ProductProvider(
        id: id,
        title: json["title"],
        description: json["description"],
        price: json["price"],
        imageUrl: json["imageUrl"],
        isFavorite: json["isFavorite"]
    );
  }


  String toJson({
    String? id,
    String? title,
    String? description,
    double? price,
    String? imageUrl,
    bool? isFavorite
  }) => jsonEncode({
    "title": title ?? this.title,
    "description": description ?? this.description,
    "price": price ?? this.price,
    "imageUrl": imageUrl ?? this.imageUrl,
    "isFavorite": isFavorite ?? this.isFavorite
  });




  Future<void> toggleFavorite() async{
    try{
      final endPoint = Uri.parse("https://shop-app-f42ef-default-rtdb.asia-southeast1.firebasedatabase.app/products/$id.json");
      this.isFavorite = !this.isFavorite;
      notifyListeners();
      final result = await http.patch(endPoint, body: this.toJson(isFavorite: this.isFavorite));
      if(result.statusCode != 200){
        this.isFavorite = !this.isFavorite;
        notifyListeners();
        throw Exception("");
      }
    }catch(error) {
      print(error);
      throw error;
    }
  }


}