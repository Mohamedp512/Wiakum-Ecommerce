import 'package:flutter/material.dart';
import 'package:wiakum/size_config.dart';

class CatTab extends StatelessWidget {
  final String title;
  final String image;
  CatTab({this.title, this.image});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.defaultSize * 15,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
            // padding: EdgeInsets.all(SizeConfig.defaultSize*5),
            height: SizeConfig.defaultSize * 8,
            width: double.maxFinite,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                     image))),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}

