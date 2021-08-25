import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart_provider.dart';


import 'package:shop_app/providers/product_list_provider.dart';
import 'package:shop_app/screens/cart_detail_screen.dart';
import 'package:shop_app/widgets/app_drawer.dart';
import 'package:shop_app/widgets/product_item.dart';


enum  Filter {
  ShowAll,
  FavoriteOnly
}

class ProductOverviewScreen extends StatefulWidget {

  static final routeName = "/";


  @override
  _ProductOverviewScreenState createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {


  var _showFavorite = false;

  var _isLoading = false;


  @override
  void initState() {
    fetchProductData();
    super.initState();
  }

  void fetchProductData() async{
    _isLoading = true;
    Provider.of<ProductListProvider>(context, listen: false).fetchAndSetProduct();
    _isLoading = false;
  }

  @override
  Widget build(BuildContext context)  {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Overview"),
        actions: [
          Badge(
            badgeContent: Consumer<CartProvider>(
              builder: (context, cart, child) => Text(
                  cart.cartLength.toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10
                  ),
              ),
            ),
            child: GestureDetector(
                onTap: () => Navigator.of(context).pushNamed(CartDetailScreen.routeName),
                child: Icon(Icons.shopping_cart)
            ),
            position: BadgePosition.topStart(top: 1),
          ),
          PopupMenuButton(
              onSelected: (Filter selectedIitem) {
                setState(() {
                  _showFavorite = selectedIitem == Filter.FavoriteOnly;
                });
              },
              itemBuilder: (_) => [
                PopupMenuItem(child: Text("Only Favorite"), value: Filter.FavoriteOnly),
                PopupMenuItem(child: Text("Show All"), value: Filter.ShowAll)
              ]
          )
        ],
      ),
      drawer: AppDrawer(),
      body: Stack(children : [
          RefreshIndicator(
              onRefresh: () async {
                fetchProductData();
              },
              child: ProductGrid(_showFavorite)
          ),
          if(_isLoading) Center(
            child: CircularProgressIndicator(),
          )
      ]),
    );
  }
}

class ProductGrid extends StatelessWidget {

  final _showFavoriteOnly;

  ProductGrid(this._showFavoriteOnly);

  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<ProductListProvider>(context);
    final products = _showFavoriteOnly ? productsProvider.favoriteProducts : productsProvider.products;
    return GridView.builder(
        padding: EdgeInsets.all(10),
        itemCount: products.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3/2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 20
        ),
        itemBuilder: (ctx , index ) => ChangeNotifierProvider.value(
            value: products[index],
            child: ProductItem()
        )
    );
  }
}
