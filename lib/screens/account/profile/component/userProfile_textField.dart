import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wiakum/size_config.dart';

class UserProfileTextField extends StatelessWidget {
  final String label;
  final String initialValue;
  final Function onFieldSubmitting;
  final FocusNode focusNode;
  final TextInputType inputType;
  final Function onSave;

  UserProfileTextField({this.onSave,this.label, this.initialValue, this.onFieldSubmitting,
      this.focusNode, this.inputType});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(SizeConfig.defaultSize*2),
      child: TextFormField(
        initialValue:initialValue,style: TextStyle(fontWeight: FontWeight.bold,fontSize: SizeConfig.defaultSize*2),
        decoration: InputDecoration(
            labelText: label
        ),
        keyboardType: inputType,
        textInputAction: TextInputAction.next,
        onFieldSubmitted:onFieldSubmitting ,
        validator: (value){
          if(value.isEmpty){return 'Please provide a value,';}
          return null;
        },
        onSaved:onSave ,
      ),
    );
  }
}
