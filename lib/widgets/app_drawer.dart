import 'package:flutter/material.dart';
import 'package:shop_app/screens/order_detail_screen.dart';
import 'package:shop_app/screens/product_overview_screen.dart';
import 'package:shop_app/screens/user_product_screen.dart';


class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Column(
          children: [
            AppBar(
              title: Text("Shop App"),
              leading: null,
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacementNamed(ProductOverviewScreen.routeName);
              },
              child: ListTile(
                leading: Icon(Icons.shop, color: Theme.of(context).primaryColor),
                title: Text("Buy Product"),
              ),
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacementNamed(OrderDetailScreen.routeName);
              },
              child: ListTile(
                leading: Icon(Icons.card_membership, color: Theme.of(context).primaryColor),
                title: Text("Order List"),
              ),
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacementNamed(UserProductScreen.routeName);
              },
              child: ListTile(
                leading: Icon(Icons.edit, color: Theme.of(context).primaryColor),
                title: Text("User Products"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
