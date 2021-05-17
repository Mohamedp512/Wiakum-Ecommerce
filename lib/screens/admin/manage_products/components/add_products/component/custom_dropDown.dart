import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wiakum/services/categories.dart';
import 'package:wiakum/size_config.dart';

class CustomDropDown extends StatelessWidget {
  final String cat;
  final Function onChange;

  CustomDropDown({this.cat, this.onChange});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.orange),
          borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: DropdownButton<String>(
          icon: Icon(Icons.keyboard_arrow_down),
          underline: Container(
            color: Colors.transparent,
          ),
          value: cat,
          hint: const Text(' Select Category'),
          items: Provider.of<Categories>(context).categories.map((cat) => cat.title)
              .map<DropdownMenuItem<String>>(
                  (String value) =>
                  DropdownMenuItem<String>(
                      value: value,
                      child: Container(
                        margin: EdgeInsets.only(
                            left: SizeConfig.defaultSize, right: SizeConfig.defaultSize),
                        child: Text(
                          value,
                          style: TextStyle(
                              color: Colors.blueGrey),
                        ),
                      )))
              .toList(),
          onChanged: onChange ),
    );
  }
}
