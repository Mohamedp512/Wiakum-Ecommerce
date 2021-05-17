import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wiakum/cosntants.dart';
import 'package:wiakum/size_config.dart';

class PhoneVerificationScreen extends StatefulWidget {
  static const routeName = 'phoneVerification';

  @override
  _PhoneVerificationScreenState createState() =>
      _PhoneVerificationScreenState();
}

class _PhoneVerificationScreenState extends State<PhoneVerificationScreen> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  String phoneNo, verificationId, smsCode;
  bool codeSent=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Phone Verification'),
        backgroundColor: primaryColor,
      ),
      body: Form(
        key: _globalKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
                padding: EdgeInsets.all(SizeConfig.defaultSize * 2),
                child: TextFormField(
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: 'Enter your phone',
                  ),
                  onChanged: (val) {
                    setState(() {
                      this.phoneNo = val;
                    });
                  },
                )),
            SizedBox(
              height: SizeConfig.defaultSize * 3,
            ),
            RaisedButton(
              onPressed: () {verifyPhone(phoneNo);
              print(smsCode); },
              child: Text('Verify'),
            )
          ],
        ),
      ),
    );
  }

  Future<void> verifyPhone(phoneNo) async {
    final PhoneVerificationCompleted verified= (AuthCredential authResult){
      print('Sent');
    };
    final PhoneVerificationFailed verificationFailed= (FirebaseAuthException authException){
      print('Failed');
    };
    final PhoneCodeSent smsSent=(String verId,[int forceResend]){
      this.verificationId=verId;
      setState(() {
        this.codeSent=true;
      });
    };
    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
      this.verificationId = verId;
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNo,
      timeout: const Duration(seconds: 10),
      verificationCompleted: verified,
      verificationFailed: verificationFailed,
      codeSent: smsSent,
      codeAutoRetrievalTimeout: autoTimeout,
    );
  }
}
