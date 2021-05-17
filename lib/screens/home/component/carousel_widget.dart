import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:wiakum/size_config.dart';


class CarouselWidget extends StatelessWidget {
  const CarouselWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(SizeConfig.defaultSize),
      height: SizeConfig.defaultSize * 18,
      width: double.infinity,
      child: Carousel(
        dotSize: 5,
        indicatorBgPadding: 5,
        dotColor: Colors.white,
        dotIncreasedColor: Colors.orange,
        borderRadius: true,
        radius: Radius.circular(10),
        images: [
          Image.asset('assets/images/car1.jpg', fit: BoxFit.cover,),
          Image.asset('assets/images/car2.jpg', fit: BoxFit.fill,),
          Image.asset('assets/images/car3.jpg', fit: BoxFit.cover,),
          Image.asset('assets/images/car4.png', fit: BoxFit.cover,),
        ],
      ),
    );
  }
}
