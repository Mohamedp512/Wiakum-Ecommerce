import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String labelText;
  final String hintText;
  int maxLines =1;
  TextInputType keyboardType;
  Function onClick;


  CustomTextFormField({this.onClick,this.labelText, this.hintText, this.maxLines,
    this.keyboardType});
  _errorMsg(String str){
    switch (hintText){
      case 'Product Name':return 'Name is Empty';
      case 'Name':return 'Name is empty';
      case 'Mobile': return 'Mobile is empty';
      case 'Address':return "Address is empty";
      case 'City': return 'City is empty';
      case 'Product Price': return 'Price is Empty';
      case 'Product Description': return 'Description is empty';
    }}
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: TextFormField(
        onSaved: onClick,
        validator: (value){if(value.isEmpty){return _errorMsg(hintText);}},
        maxLines: maxLines,
        keyboardType: keyboardType,
        decoration: InputDecoration(
            isDense: true,
            labelText: labelText,
            hintText: hintText,
            labelStyle: TextStyle(
              color: Colors.orange,
            ),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.orange)),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.orange)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.orange)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.orange))),
      ),
    );
  }
}
