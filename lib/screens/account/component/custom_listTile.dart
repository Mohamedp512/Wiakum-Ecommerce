import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class CustomListTile extends StatelessWidget {
  final IconData leadingIcon;
  final String title;
  final String subTitle;
  final Function press;

  CustomListTile({this.leadingIcon, this.title,this.subTitle='',this.press});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
        leading: Icon(leadingIcon,color: Colors.black,),
        title: Text(title,style: TextStyle(fontWeight: FontWeight.bold),),
        subtitle: Text(subTitle),
        trailing:Icon(AntDesign.right));
  }
}
