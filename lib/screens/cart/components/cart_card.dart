import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:wiakum/services/cart.dart';
import 'package:wiakum/size_config.dart';

class CartCard extends StatelessWidget {
  final String id, productId, title, image;
  final double price;
  final int qty;

  CartCard({
    this.id,
    this.productId,
    this.title,
    this.image,
    this.price,
    this.qty,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(SizeConfig.defaultSize),
      height: SizeConfig.screenHeight * .22,
      // decoration: BoxDecoration(border: Border.all(color: Colors.red)),
      child: Card(
        child: Padding(
            padding: EdgeInsets.all(SizeConfig.defaultSize),
            child: Container(
              child: Column(
                children: [
                  ListTile(
                    leading: Container(
                      height: SizeConfig.defaultSize * 8,
                      width: SizeConfig.defaultSize * 6,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          image: DecorationImage(
                              image: NetworkImage(image), fit: BoxFit.cover)),
                    ),
                    title: Text(
                      title,
                      maxLines: 2,
                      style: GoogleFonts.lato(
                          fontSize: SizeConfig.defaultSize * 1.7),
                    ),
                    subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'SAR $price',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: SizeConfig.defaultSize * 1.7,
                                height: 1.5),
                          ),
                          //Spacer(),
                          Text(
                            'x $qty',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: SizeConfig.defaultSize * 1.7),
                          )
                        ]),
                  ),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total: SAR ${price * qty}',
                        style: GoogleFonts.lato(
                            fontWeight: FontWeight.bold,
                            fontSize: SizeConfig.defaultSize * 1.8),
                      ),
                      FlatButton(
                          onPressed: () {
                            Provider.of<Cart>(context, listen: false)
                                .removeItem(productId);
                          },
                          child: Row(children: [
                            Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                            Text('Remove'),
                          ]))
                    ],
                  )
                ],
              ),
            )),
      ),
    );
  }
}
