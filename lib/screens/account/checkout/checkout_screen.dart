import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:wiakum/cosntants.dart';
import 'package:wiakum/models/user.dart';
import 'package:wiakum/screens/account/checkout/checkout_cart.dart';
import 'package:wiakum/screens/account/orders/orders_screen.dart';
import 'package:wiakum/screens/account/profile/update_user_info.dart';
import 'package:wiakum/screens/admin/manage_products/components/add_products/component/custom_text_field.dart';
import 'package:wiakum/services/cart.dart';
import 'package:wiakum/services/orders.dart';
import 'package:wiakum/size_config.dart';

class CheckoutScreen extends StatelessWidget {
  static const routeName = 'checkoutScreen';
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  String _address, _name, _city;
  String _mobile;

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final userData = Provider.of<User>(context).user;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            'Checkout'.toUpperCase(),
            style: TextStyle(color: Colors.black),
          ),
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _globalKey,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: SizeConfig.defaultSize * 2),
                  height: SizeConfig.screenHeight * .7,
                  width: double.infinity,
                  child: ListView(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: SizeConfig.defaultSize),
                        child: Text(
                          'Shipping Info',
                          style: GoogleFonts.lato(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(SizeConfig.defaultSize * 2),
                        margin: EdgeInsets.symmetric(
                            vertical: SizeConfig.defaultSize * 1),
                        //  height: SizeConfig.defaultSize * 35,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.grey[300]),
                            borderRadius: BorderRadius.circular(5)),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Container(
                                //height: SizeConfig.defaultSize * 10,
                                child: Row(
                                  children: [
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            Icon(Entypo.location),
                                            Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal:
                                                        SizeConfig.defaultSize *
                                                            2),
                                                child: Text.rich(TextSpan(
                                                    text: userData.name,
                                                    style: GoogleFonts.lato(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: SizeConfig
                                                              .defaultSize *
                                                          1.8,
                                                    ),
                                                    children: [
                                                      TextSpan(
                                                          text:
                                                              '\n${userData.mobile}\n${userData.address}\n${userData.city}',
                                                          style: TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: SizeConfig
                                                                    .defaultSize *
                                                                1.6,
                                                          ))
                                                    ])))
                                          ],
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding:EdgeInsets.only(left:SizeConfig.defaultSize*2.5),
                                          child: FlatButton(
                                              onPressed: () {
                                                Navigator.pushNamed(context,
                                                    UpdateUserInfo.routeName);
                                              },
                                              child: Text(
                                                'change'.toUpperCase(),
                                                style:
                                                    TextStyle(color: Colors.blue),
                                              )),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.defaultSize * 2,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: SizeConfig.defaultSize),
                        child: Row(
                          children: [
                            Text(
                              'Cart Items',
                              style: GoogleFonts.lato(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            Spacer(),
                            FlatButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'Edit Cart',
                                  style: TextStyle(color: primaryColor),
                                ))
                          ],
                        ),
                      ),
                      CheckoutCart(),
                      SizedBox(
                        height: SizeConfig.defaultSize * 2,
                      ),
                      Container(
                        padding: EdgeInsets.all(SizeConfig.defaultSize),
                        height: SizeConfig.defaultSize * 15,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey[300]),
                            borderRadius: BorderRadius.circular(5)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Order Summary',
                              style: GoogleFonts.lato(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            SizedBox(
                              height: SizeConfig.defaultSize * 1.1,
                            ),
                            Row(
                              children: [
                                Text('Items total'),
                                Spacer(),
                                Text('${cart.totalAmount.toString()} SAR')
                              ],
                            ),
                            SizedBox(
                              height: SizeConfig.defaultSize,
                            ),
                            Row(
                              children: [
                                Text('Discount'),
                                Spacer(),
                                Text('0.0 SAR')
                              ],
                            ),
                            SizedBox(
                              height: SizeConfig.defaultSize,
                            ),
                            Row(
                              children: [
                                Text(
                                  'Total',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Spacer(),
                                Text('${cart.totalAmount.toString()} SAR',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold))
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.defaultSize * 2,
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(SizeConfig.defaultSize * 2),
                  margin: EdgeInsets.symmetric(
                      horizontal: SizeConfig.defaultSize * 2),
                  height: SizeConfig.defaultSize * 9,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey[300]),
                      borderRadius: BorderRadius.circular(5)),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Total price',
                                style: TextStyle(fontSize: 16),
                              ),
                              Text(
                                '${cart.totalAmount.toString()} SAR',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 17),
                              )
                            ]),
                        SizedBox(
                            child: FlatButton(
                                onPressed: () async {
                                  if (_globalKey.currentState.validate()) {
                                    _globalKey.currentState.save();
                                    await Provider.of<Orders>(context,
                                            listen: false)
                                        .addOrder(
                                            cart.items.values.toList(),
                                            cart.totalAmount,
                                            userData.mobile,
                                            userData.address);
                                    cart.clear();
                                    Navigator.pop(context);
                                    Navigator.pushNamed(
                                        context, OrdersScreen.routeName);
                                  }
                                },
                                child: Text(
                                  'Place Order',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                                color: Color(0xFF259402)))
                      ]),
                ),
              ],
            ),
          ),
        ));
  }
}
