import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:wiakum/screens/account/checkout/checkout_cart_items.dart';
import 'package:wiakum/services/cart.dart';

class CheckoutCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart=Provider.of<Cart>(context);
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
        itemCount: cart.items.length,
        itemBuilder: (context,index)=>CheckOutCartItem(
          total: cart.items.values.toList()[index].price,
          quantity:cart.items.values.toList()[index].qty,
          image: cart.items.values.toList()[index].image,
          title: cart.items.values.toList()[index].title,
        ));
  }
}
