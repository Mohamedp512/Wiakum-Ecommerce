import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wiakum/cosntants.dart';
import 'package:wiakum/screens/account/orders/order_item_card.dart';
import 'package:wiakum/services/orders.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = 'ordersScreen';

  @override
  Widget build(BuildContext context) {
    //final orders = Provider.of<Orders>(context).orders;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text('Orders'),
      ),
      body: FutureBuilder(
        future: Provider.of<Orders>(context, listen: false).fetchOrders(),
        builder: (context, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (dataSnapshot.error != null) {
              return Center(
                child: Text('An error occurred'),
              );
            } else {
              return Consumer<Orders>(
                builder: (context, orderData, child) => ListView.builder(
                  //physics: NeverScrollableScrollPhysics(),
                  itemCount: orderData.orders.length,
                  itemBuilder: (context, index) =>
                      OrderItemCard(orderData.orders[index]),
                ),
              );
            }
          }
        },
      ),
    );
  }
}
