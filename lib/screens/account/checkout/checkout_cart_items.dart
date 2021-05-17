import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wiakum/size_config.dart';

class CheckOutCartItem extends StatelessWidget {
  final String image, title;
  final double total;
  final int quantity;

  CheckOutCartItem({this.image, this.title, this.total, this.quantity});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(SizeConfig.defaultSize),
      height: SizeConfig.defaultSize * 15,
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]),
          borderRadius: BorderRadius.circular(5)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            height: SizeConfig.defaultSize * 10,
            width: SizeConfig.defaultSize * 8,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(image), fit: BoxFit.cover),
            ),
          ),
          Container(
            padding: EdgeInsets.all(SizeConfig.defaultSize),
            height: SizeConfig.defaultSize * 15,
            width: SizeConfig.defaultSize * 25,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 2,
                ),
                SizedBox(
                  height: SizeConfig.defaultSize,
                ),
                Text.rich(TextSpan(
                  text: 'Quantity: ',
                  children: <TextSpan>[
                    TextSpan(
                        text: '$quantity',
                        style: TextStyle(fontWeight: FontWeight.bold))
                  ],
                )),
                Spacer(),
                Text.rich(
                  TextSpan(text: 'Total: ', children: [
                    TextSpan(
                        text: '$total',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: ' SAR',style: GoogleFonts.lato())
                  ]),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
