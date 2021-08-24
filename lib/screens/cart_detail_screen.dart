import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart_provider.dart';
import 'package:shop_app/providers/order_list_provider.dart';
import 'package:shop_app/providers/product_provider.dart';
import 'package:shop_app/widgets/cart_item_view.dart';

class CartDetailScreen extends StatelessWidget {

  static final routeName = "/cart-detail-screen";

  @override
  Widget build(BuildContext context) {

    final cartProvider = Provider.of<CartProvider>(context);
    final cartList  = cartProvider.cartItemInList;
    final orderProvider = Provider.of<OrderListProvider>(context , listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Cart"),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                Text("Total"),
                Spacer(),
                Chip(
                    label: Text(
                        "\$${cartProvider.totalAmount}",
                        style: TextStyle(
                          color: Colors.white
                        ),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                ),
                SizedBox(width: 3),
                TextButton(onPressed: () {
                  orderProvider.addNewOrder(cartProvider.cartItemInList, cartProvider.totalAmount);
                  cartProvider.clearProduct();
                }, child: Text("Order Now"))
              ],
            ),
            SizedBox(height: 10),
            Expanded(
                child: ListView.builder(
                  itemCount: cartList.length,
                  itemBuilder: (ctx, index) => Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: CartItemView(
                        cartList[index],
                          () {
                            cartProvider.removeItem(cartList[index].product.id);
                          }
                      )
                  ),
                )
            )
          ],
        ),
      ),
    );
  }
}
