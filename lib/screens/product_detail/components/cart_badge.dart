import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wiakum/badge.dart';
import 'package:wiakum/services/cart.dart';

class CartBadge extends StatelessWidget {
  final Color activeColor;
  final Color inactiveColor;

  CartBadge({this.activeColor,this.inactiveColor});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return cart.itemCount == 0 ?
    Icon(Icons.shopping_cart,color:inactiveColor ,):
    Badge(
      child: Icon(Icons.shopping_cart,color: activeColor,),
      value: cart.itemCount.toString(),
    );
  }
}
