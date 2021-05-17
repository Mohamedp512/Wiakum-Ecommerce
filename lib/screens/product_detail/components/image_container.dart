
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wiakum/models/product.dart';
import 'package:wiakum/size_config.dart';

class ImageContainer extends StatelessWidget {
  final String image;
  final String id;
  final Widget positionedWidget;

  ImageContainer({@required this.image, @required this.id, this.positionedWidget});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        height: SizeConfig.screenHeight * .4,
        width: double.infinity,
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
          color: Colors.grey,
        ))),
        child: Hero(
          tag:id,
          child: Image.network(
            image,
            fit: BoxFit.fill,
          ),
        ),
      ),
      Positioned(
        child: positionedWidget)

    ]);
  }
}
