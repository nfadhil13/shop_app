import 'package:flutter/material.dart';
import 'package:shop_app/models/cart_item.dart';

class CartItemView extends StatelessWidget {

  final CartItem _cartItem;
  final Function onDismiss;

  CartItemView(this._cartItem, this.onDismiss);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(this._cartItem.product.id),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        onDismiss();
      },
      confirmDismiss: (direction) {
        return showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: Text("Are you sure?"),
              content: Text("Do you wnat to delete ${_cartItem.product.title} from cart?"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                      },
                    child: Text("No", style: TextStyle(color: Colors.red),)
                ),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    child: Text("Yes", style: TextStyle(color: Colors.red))
                )
              ],
            )
        );
      },
      background: Padding(
        padding: EdgeInsets.symmetric(vertical: 5),
        child: Container(
          color: Theme.of(context).errorColor,
          child: Container(
              margin: EdgeInsets.only(right: 10),
              child: Icon(Icons.delete, color: Colors.white, size: 30)
          ),
          alignment: Alignment.centerRight,
        ),
      ),
      child: Card(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
          child: ListTile(
            title: Text(_cartItem.product.title),
          subtitle: Text("Total : \$${_cartItem.price.toString()}"),
            leading: CircleAvatar(
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: FittedBox(
                    child: Text(
                        "\$${_cartItem.product.price}",
                        style: TextStyle(
                          fontSize: 12
                        ),
                    ),
                  ),
                )
            ),
            trailing: Text(
              _cartItem.qty.toString() + " x" ,
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }
}
