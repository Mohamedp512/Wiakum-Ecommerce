import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:wiakum/models/order.dart';
import 'package:wiakum/services/orders.dart';
import 'package:wiakum/size_config.dart';

class OrderItemCard extends StatelessWidget {
  final OrderItem order;

  OrderItemCard(this.order);
  // final String id, date, image, title;
  // final int qty;
  //
  //
  // OrderItemCard({this.id, this.date, this.image, this.title, this.qty});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: SizeConfig.defaultSize),
        padding: EdgeInsets.all(SizeConfig.defaultSize),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text.rich(
              TextSpan(text: 'Order ID: ', children: [
                TextSpan(
                    text: order.id,
                    style: TextStyle(fontWeight: FontWeight.bold, height: 1.5))
              ]),
            ),
            Text.rich(TextSpan(text: 'Order Time: ', children: [
              TextSpan(
                  text: DateFormat('dd/MM/yyy hh:mm').format(order.dateTime),
                  style: TextStyle(fontWeight: FontWeight.bold, height: 1.5))
            ])),
            ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: order.products.map((prod) => Column(
                children: [
                  ListTile(
                    leading: Image.network(prod.image,fit: BoxFit.cover,),
                    title: Text(prod.title),
                  ),
                  Text.rich(TextSpan(text: 'Quantity: ',children: [TextSpan(text: prod.qty.toString(),style: TextStyle(fontWeight: FontWeight.bold))])),
                  SizedBox(height: SizeConfig.defaultSize,),
                  Padding(padding: EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize),child: Divider(color: Colors.grey,)),
                ],
              )).toList(),
            ),
            GestureDetector(
              child: Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text('View order details',style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),), Icon(Icons.chevron_right)]),
            )
          ],
        ),
      ),
    );
  }
}
