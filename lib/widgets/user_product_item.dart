import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/product_list_provider.dart';
import 'package:shop_app/providers/product_provider.dart';
import 'package:shop_app/screens/add_or_update_product_screen.dart';
import 'package:shop_app/screens/user_product_screen.dart';

class UserProductItem extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    final productProvider = Provider.of<ProductProvider>(context);


    return Card(
      child: Padding(
        padding: EdgeInsets.all(5),
        child: ListTile(
          title: Text(productProvider.title),
          leading: CircleAvatar(
            backgroundImage: NetworkImage(productProvider.imageUrl),
          ),
          trailing: Container(
            width: 100,
            child: Row(
              children: [
                IconButton(onPressed: () {
                  Navigator.of(context).pushNamed(AddOrUpdateProductScreen.routeName, arguments: productProvider.id);
                }, icon: Icon(Icons.edit, color: Theme.of(context).primaryColor,)),
                IconButton(onPressed: () {
                  Provider.of<ProductListProvider>(context, listen: false).removeItem(productProvider.id);
                }, icon: Icon(Icons.delete, color: Colors.red,))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
