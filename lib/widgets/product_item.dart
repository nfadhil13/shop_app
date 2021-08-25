import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart_provider.dart';

import 'package:shop_app/providers/product_provider.dart';
import 'package:shop_app/screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context) ;
    final product = productProvider;
    final cartProvider = Provider.of<CartProvider>(context , listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              ProductDetailScreen.routeName,
              arguments: product.id
            );
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          title: Text(
              product.title,
            textAlign: TextAlign.center,
          ),
          leading: IconButton(
            icon: Icon(product.isFavorite ? Icons.favorite : Icons.favorite_border_outlined, color: Theme.of(context).primaryColor),
            onPressed: () async {
              try{
                await productProvider.toggleFavorite();
              }catch(error){
                print("Error lohh");
                print(error);
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      duration: Duration(milliseconds: 500),
                      content: Text("FailEd to update favorite"),
                    )
                );
              }
            },
          ),
          trailing: IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              cartProvider.addProduct(productProvider);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    duration: Duration(milliseconds: 500),
                    content: Text("Product added to cart"),
                    action: SnackBarAction(
                      label: "Undo",
                      onPressed: () {
                        cartProvider.removeItem(product.id);
                      },
                    ),
                )
              );
            },
          ),
        ),
      ),
      
    );
  }
}
