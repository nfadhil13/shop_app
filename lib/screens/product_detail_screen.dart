import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/product_list_provider.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = "/product-detail";

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)!.settings.arguments as String;
    final product = Provider.of<ProductListProvider>(context, listen: false)
        .findById(productId);
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
      body: Container(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            Image.network(
              product.imageUrl,
              fit: BoxFit.contain,
              height: 300,
              width: double.infinity,
            ),
            SizedBox(height: 10),
            Text(product.title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            SizedBox(height: 10),
            Text("\$${product.price}"),
            SizedBox(height: 10),
            Text("Description" , style: TextStyle(fontWeight: FontWeight.w500),),
            SizedBox(height: 10),
            Expanded(child: SingleChildScrollView(
              child: Text("${product.description}", textAlign: TextAlign.center,)
            ))
          ],
        ),
      ),
    );
  }
}
