import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wiakum/cosntants.dart';
import 'package:wiakum/screens/account/checkout/checkout_screen.dart';
import 'package:wiakum/screens/cart/components/cart_card.dart';
import 'package:wiakum/services/cart.dart';
import 'package:wiakum/services/orders.dart';
import 'package:wiakum/size_config.dart';
import 'components/empty_cart.dart';

class CartScreen extends StatelessWidget {
  static const routeName = 'cart';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: cart.items.length==0?null:AppBar(title: Text('Cart'),backgroundColor: primaryColor,),
        body: cart.items.length==0?EmptyCart(): SafeArea(
            child: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            height: SizeConfig.screenHeight*.65,

            child: ListView.builder(
                itemCount: cart.items.length,
                itemBuilder: (context,index)=>CartCard(
                  title: cart.items.values.toList()[index].title,
                  image: cart.items.values.toList()[index].image,
                  id: cart.items.values.toList()[index].id,
                  productId: cart.items.keys.toList()[index],
                  price: cart.items.values.toList()[index].price,
                  qty: cart.items.values.toList()[index].qty,
                )
            ),
          ),

          Column(),
          Card(
            child: Column(
              children: [
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize),
                  child: Row(
                    children: [
                      Text(
                        'Total'.toUpperCase(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: SizeConfig.defaultSize * 2,
                        ),
                      ),
                      Spacer(),
                      Chip(
                        label: Text(
                          'SAR  ${cart.totalAmount.toString()}',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        backgroundColor: Colors.orange[200],
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(SizeConfig.defaultSize),
                  child: SizedBox(
                    width: double.infinity,
                    child: FlatButton(
                        color: primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        onPressed: () {
                          Navigator.pushNamed(context, CheckoutScreen.routeName);
//                          Provider.of<Orders>(context,listen: false).addOrder(cart.items.values.toList(), cart.totalAmount);

                        },
                        child: Text(
                          'Proceed to checkout'.toUpperCase(),
                          style: TextStyle(color: Colors.white),
                        )),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    )));
  }
}
