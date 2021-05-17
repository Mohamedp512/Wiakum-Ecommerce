import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:wiakum/size_config.dart';

class CategoryPage extends StatelessWidget {
  final int length;
  final String catName;
  final Function products;

  CategoryPage({this.length, this.catName, this.products});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(SizeConfig.defaultSize),
            padding: EdgeInsets.all(SizeConfig.defaultSize * 1),
            height: SizeConfig.defaultSize * 5,
            child: Chip(backgroundColor: Colors.lightBlue[100],
                label: Text(
                  catName,
                  style: GoogleFonts.lato(fontSize: 20,fontWeight: FontWeight.bold),
                )),
          ),
          GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.8 / 3,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10),
              itemCount: length,
              itemBuilder:products ),
        ],
      ),
    );
  }
}
