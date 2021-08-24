import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shop_app/models/cart_item.dart';
import 'package:shop_app/models/order_item.dart';
import 'package:shop_app/providers/product_provider.dart';

class OrderItemView extends StatefulWidget {

  final OrderItem _orderItem;

  OrderItemView(this._orderItem);

  @override
  _OrderItemViewState createState() => _OrderItemViewState();
}

class _OrderItemViewState extends State<OrderItemView> {

  var _isExpended = false;
  
  
  Widget _buildExpendedView(List<CartItem> productList) {
    return Container(
      height: productList.length < 5? productList.length * 60 : 240,
      child: ListView.builder(
        itemCount: productList.length,
        itemBuilder: (ctx, index) => ListTile(
          leading: Text(productList[index].product.title),
          trailing: Text("${productList[index].qty} x"),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            ListTile(
              title: Text("\$${widget._orderItem.amount.toString()}"),
              subtitle: Text(DateFormat.yMMMEd().format(widget._orderItem.dateTime)),
              trailing: IconButton(
                  icon: Icon(_isExpended ? Icons.expand_less : Icons.expand_more),
                  onPressed: () {
                    setState(() {
                      _isExpended = !_isExpended;
                    });
                  },
              )
            ),
            if(_isExpended) _buildExpendedView(widget._orderItem.cartItems)
          ],
        ),
      ),
    );
  }
}
