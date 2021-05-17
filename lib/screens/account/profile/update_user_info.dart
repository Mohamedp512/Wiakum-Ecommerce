import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wiakum/models/user.dart';
import 'package:wiakum/screens/account/profile/component/userProfile_textField.dart';
import 'package:wiakum/size_config.dart';

class UpdateUserInfo extends StatelessWidget {
  static const routeName = 'updateUserInfo';
  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final _mobileFocusNode = FocusNode();
  final _addressFocusNode = FocusNode();
  final _cityFocusNode = FocusNode();
  String name, mobile, address, city;

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<User>(context, listen: false).user;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back,color: Colors.black54,), onPressed: (){Navigator.pop(context);}),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Wiakum',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
        ),
        actions: [
          FlatButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'cancel'.toUpperCase(),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: SizeConfig.defaultSize * 1.6),
              ))
        ],
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.all(SizeConfig.defaultSize),
        child: Form(
          key: _globalKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: EdgeInsets.all(SizeConfig.defaultSize),
                      child: Text(
                        'Personal Information',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: SizeConfig.defaultSize * 2.5),
                      )),
                  UserProfileTextField(
                    initialValue: userData.name,
                    label: 'Name',
                    onFieldSubmitting: (_) {
                      FocusScope.of(context).requestFocus(_mobileFocusNode);
                    },
                    onSave: (value) {
                      name = value;
                    },
                  ),
                  UserProfileTextField(
                    initialValue: userData.mobile,
                    label: 'Mobile',
                    focusNode: _mobileFocusNode,
                    inputType: TextInputType.number,
                    onFieldSubmitting: (_) {
                      FocusScope.of(context).requestFocus(_addressFocusNode);
                    },
                    onSave: (value) {
                      mobile = value;
                    },
                  ),
                  UserProfileTextField(
                    initialValue: userData.address,
                    focusNode: _addressFocusNode,
                    label: 'Address',
                    onFieldSubmitting: (_) {
                      FocusScope.of(context).requestFocus(_cityFocusNode);
                    },
                    onSave: (value) {
                      address = value;
                    },
                  ),
                  UserProfileTextField(
                    initialValue: userData.city,
                    label: 'City',
                    focusNode: _cityFocusNode,
                    onSave: (value) {
                      city = value;
                    },
                  ),
                ],
              ),
              SizedBox(
                height: SizeConfig.defaultSize * 8,
              ),
              Container(
                  margin: EdgeInsets.all(SizeConfig.defaultSize * 2),
                  width: SizeConfig.screenWidth / 1.2,
                  decoration: BoxDecoration(
                      color: Colors.blue[600],
                      borderRadius:
                          BorderRadius.circular(SizeConfig.defaultSize)),
                  child: FlatButton(
                      onPressed: ()async {
                        if(_globalKey.currentState.validate()){
                          _globalKey.currentState.save();
                          await Provider.of<User>(context,listen: false).updateUserData(city: city,mobile: mobile,name: name,address: address);
                          Navigator.pop(context);
                        }
                      },
                      child: Text(
                        'Save',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: SizeConfig.defaultSize * 1.8),
                      )))
            ],
          ),
        ),
      )),
    );
  }
}
