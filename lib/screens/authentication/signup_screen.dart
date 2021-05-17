import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import 'package:wiakum/cosntants.dart';
import 'package:wiakum/models/http_exception.dart';
import 'package:wiakum/models/user.dart';
import 'package:wiakum/screens/authentication/login_screen.dart';
import 'package:wiakum/services/auth.dart';
import 'component/custom_textField.dart';

class SignUpScreen extends StatelessWidget {
  static const routeName = 'signUpScreen';
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  String _name, _email, _password;

  @override
  Widget build(BuildContext context) {
    final authData = Provider.of<Auth>(context, listen: false);
    return Scaffold(
      backgroundColor: primaryColor,
      body: SingleChildScrollView(
        child: Form(
          key: _globalKey,
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
                              'Sign Up',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 50),
                            ),
                            Text(
                              'Welcome',
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
                child: ListView(
                  children: <Widget>[
                    CustomTextField(
                      onClick: (value) {
                        _name = value;
                      },
                      icon: Icons.person,
                      hint: 'Enter your Name',
                    ),
                    CustomTextField(
                      onClick: (value) {
                        _email = value;
                      },
                      icon: Icons.email,
                      hint: 'Enter your Email',
                    ),
                    CustomTextField(
                        onClick: (value) {
                          _password = value;
                        },
                        hint: 'Enter Your Password',
                        icon: Icons.lock),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .01,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 100),
                      child: Row(
                        children: [
                          Expanded(
                            child: Builder(
                              builder: (context) => FlatButton(
                                onPressed: () async {
                                  if (_globalKey.currentState.validate()) {
                                    _globalKey.currentState.save();
                                    print(_name);
                                    try {
                                      await Provider.of<Auth>(context,
                                              listen: false)
                                          .signUp(_email, _password);
                                      print (authData.userId);
                                      await Provider.of<User>(context,
                                              listen: false)
                                          .addUserName(
                                              userName: _name);
                                      print('done');
                                      await Provider.of<Auth>(context,
                                              listen: false)
                                          .login(_email, _password);

                                      // final authResult = await _auth.signUp(
                                      //     _email, _password);
                                    } on HttpException catch (e) {
                                      Scaffold.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text(e.message),
                                      ));
                                    }
                                  }
                                },
                                child: Text(
                                  'Sign up',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                                color: Colors.orange[700],
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
                        Text('Have an account?'),
                        FlatButton(
                          child: Text('Log in'),
                          onPressed: () {
                            Navigator.pushNamed(context, LoginScreen.routeName);
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
