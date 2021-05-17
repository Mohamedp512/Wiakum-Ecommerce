import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wiakum/cosntants.dart';
import 'package:wiakum/models/http_exception.dart';
import 'package:wiakum/screens/authentication/signup_screen.dart';
import 'package:wiakum/services/auth.dart';
import 'package:wiakum/size_config.dart';

import 'component/custom_textField.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = 'login';
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  String _email, _password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Form(
        key: _globalKey,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * .3,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                        top: 100,
                        left: 40,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Login',
                              style:
                              TextStyle(color: Colors.white, fontSize: 50),
                            ),
                            Text(
                              'Welcome Back',
                              style:
                              TextStyle(color: Colors.white, fontSize: 20),
                            )
                          ],
                        )),
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * .7,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    )),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .05,
                    ),
                    CustomTextField(onClick: (value){
                      _email=value;
                    },
                      icon: Icons.email,
                      hint: 'Enter your Email',
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .001,
                    ),
                    CustomTextField(
                        onClick: (value){_password=value;},
                        hint: 'Enter Your Password', icon: Icons.lock),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .09,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 100),
                      child: Row(
                        children: [
                          Expanded(
                            child: Builder(
                              builder:(context)=> FlatButton(
                                onPressed: () async{
                                  if(_globalKey.currentState.validate()){
                                    _globalKey.currentState.save();
                                    try{
                                      await Provider.of<Auth>(context,listen: false).login(_email, _password);
                                    } on HttpException catch(e){
                                      Scaffold.of(context).showSnackBar(SnackBar(

                                        content: Text(e.message),
                                      ));
                                    }
                                  }
                                },
                                child: Text(
                                  'Log in',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                                color: primaryColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('Don\'t have account?'),
                        FlatButton(
                          child: Text('Sign up'),
                          onPressed: () {
                            Navigator.pushNamed(context, SignUpScreen.routeName);
                          },
                          textColor: primaryColor,
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
