import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart_provider.dart';
import 'package:shop_app/providers/order_list_provider.dart';
import 'package:shop_app/providers/product_list_provider.dart';
import 'package:shop_app/screens/add_or_update_product_screen.dart';
import 'package:shop_app/screens/cart_detail_screen.dart';
import 'package:shop_app/screens/order_detail_screen.dart';
import 'package:shop_app/screens/product_detail_screen.dart';
import 'package:shop_app/screens/product_overview_screen.dart';
import 'package:shop_app/screens/user_product_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => ProductListProvider()),
        ChangeNotifierProvider(create: (ctx) => CartProvider()),
        ChangeNotifierProvider(create: (ctx) => OrderListProvider())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Color.fromRGBO(255, 255, 255, 0.9)
        ),
        home: ProductOverviewScreen(),
        routes: {
          ProductDetailScreen.routeName : (ctx) => ProductDetailScreen(),
          CartDetailScreen.routeName : (ctx) => CartDetailScreen(),
          OrderDetailScreen.routeName : (ctx) => OrderDetailScreen(),
          UserProductScreen.routeName : (ctx) => UserProductScreen(),
          AddOrUpdateProductScreen.routeName : (ctx) => AddOrUpdateProductScreen()
        },
      ),
    );
  }
}


