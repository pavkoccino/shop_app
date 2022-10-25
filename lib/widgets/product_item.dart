import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/screens/product_detail_screen.dart';

import '../providers/cart.dart';
import '../providers/product.dart';

class ProductItem extends StatelessWidget {
  // const ProductItem(
  //     {Key? key, required this.id, required this.title, required this.imageUrl})
  //     : super(key: key);

  // final String id;
  // final String title;
  // final String imageUrl;

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          child: Image.network(product.imageUrl, fit: BoxFit.cover),
          onTap: () {
            Navigator.of(context).pushNamed(ProductDetailScreen.routeName,
                arguments: product.id);
          },
        ),
        footer: GridTileBar(
            leading: Consumer<Product>(
                builder: ((context, product, child) => IconButton(
                      icon: Icon(product.isFavorite
                          ? Icons.favorite
                          : Icons.favorite_border),
                      onPressed: () {
                        product.toggleFavoriteStatus();
                      },
                      color: Theme.of(context).accentColor,
                    ))),
            backgroundColor: Colors.black87,
            title: Text(
              product.title,
              textAlign: TextAlign.center,
            ),
            trailing: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                cart.addItem(product.id, product.price, product.title);
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    duration: Duration(seconds: 2),
                    action: SnackBarAction(
                      label: 'UNDO',
                      onPressed: (() {
                        cart.removeSingleItem(product.id);
                      }),
                    ),
                    content: Text('Added item to cart!')));
              },
              color: Theme.of(context).accentColor,
            )),
      ),
    );
  }
}
