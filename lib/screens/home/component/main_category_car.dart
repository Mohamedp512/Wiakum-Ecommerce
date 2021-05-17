import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wiakum/screens/categories/categories_screen.dart';
import 'package:wiakum/size_config.dart';

class MainCategoryCard extends StatelessWidget {
  final String title, image;

  MainCategoryCard({
    @required this.title,
    @required this.image,

  });

  @override
  Widget build(BuildContext context) {
    //final categories=Provider.of<Category>(context,listen: false);
    return Container(
      decoration: BoxDecoration(
          ),
      padding: EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize),
      height: SizeConfig.defaultSize*15,
      width: SizeConfig.defaultSize * 10.4,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, CategoriesScreen.routeName);
            },
            child: Container(
              margin: EdgeInsets.all(SizeConfig.defaultSize),
              height: SizeConfig.defaultSize * 6,
              width: SizeConfig.defaultSize * 7,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue, width: 2),
                  borderRadius: BorderRadius.circular(SizeConfig.defaultSize*10)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(SizeConfig.defaultSize*10),
                child: Image.network(
                  image,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: SizeConfig.defaultSize * 1.6),
          )
        ],
      ),
    );
  }
}
