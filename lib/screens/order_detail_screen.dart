import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/order_list_provider.dart';
import 'package:shop_app/widgets/app_drawer.dart';
import 'package:shop_app/widgets/order_item_view.dart';

class OrderDetailScreen extends StatelessWidget {

  static final routeName = "/order-detail-screen";

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderListProvider>(context);
    final orderList = orderProvider.item;
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Order"),
      ),
      body: ListView.builder(
        itemCount: orderList.length,
        itemBuilder: (ctx, index) => Padding(
            padding: EdgeInsets.all(8),
            child: OrderItemView(orderList[index])
        ),
      ),
      drawer: AppDrawer()
    );
  }
}
