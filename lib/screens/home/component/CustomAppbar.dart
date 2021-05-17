import 'package:flutter/material.dart';
import 'package:wiakum/size_config.dart';

class CustomAppbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Wiakum',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {

              },
              child: Container(
                margin: EdgeInsets.all(SizeConfig.defaultSize),
                padding: EdgeInsets.all(SizeConfig.defaultSize * .5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.grey[350])),
                child: Row(
                  children: [
                    Icon(
                      Icons.search,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      width: SizeConfig.defaultSize,
                    ),
                    Text(
                      'What are you looking for?',
                      style: TextStyle(
                          color: Colors.grey[350],
                          fontSize: SizeConfig.defaultSize * 1.5),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
