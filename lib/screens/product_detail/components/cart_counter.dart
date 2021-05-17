import 'package:flutter/material.dart';
import 'package:wiakum/size_config.dart';

class CartCounter extends StatelessWidget {
  final int num;
  final Function increasing;
  final Function decreasing;


  CartCounter({this.num, this.increasing, this.decreasing});

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        buildOutlineButton(icon: Icons.remove, press: decreasing
        // ()
    // {
    //   if (num > 1) {
    //     setState(() {
    //       num--;
    //     });
    //   }}
    ),
    Padding(
    padding: EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize),
    child: Text(
    // if our item is less  then 10 then  it shows 01 02 like that
    num.toString().padLeft(2, "0"),
    style: Theme.of(context).textTheme.headline6,
    ),
    ),
    buildOutlineButton(icon: Icons.add, press:increasing
    //     (){setState(() {
    // num++;
    // });}
    )
    ,

    ]
    ,
    );
  }
  }

  SizedBox buildOutlineButton({IconData icon, Function press}) {
    return SizedBox(
      width: SizeConfig.defaultSize * 4,
      height: SizeConfig.defaultSize * 3.2,
      child: OutlineButton(
        onPressed: press,
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
        child: Icon(icon),
      ),
    );
  }