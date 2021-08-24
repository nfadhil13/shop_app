import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/product_list_provider.dart';
import 'package:shop_app/screens/add_or_update_product_screen.dart';
import 'package:shop_app/widgets/app_drawer.dart';
import 'package:shop_app/widgets/user_product_item.dart';

class UserProductScreen extends StatelessWidget {

  static const routeName = "/user-product-screen";

  @override
  Widget build(BuildContext context) {
    final productListProvider = Provider.of<ProductListProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("User Products"),
        actions: [
          IconButton(onPressed: () {
            Navigator.of(context).pushNamed(AddOrUpdateProductScreen.routeName);
          }, icon: Icon(Icons.add))
        ],
      ),
      drawer: AppDrawer(),
      body: Container(
        padding: EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: productListProvider.products.length,
          itemBuilder: (ctx, index) => ChangeNotifierProvider.value(
              value: productListProvider.products[index],
              child: UserProductItem(),
          ) ,
        ),
      ),
    );
  }
}
