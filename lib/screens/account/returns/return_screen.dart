import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wiakum/size_config.dart';

class ReturnScreen extends StatelessWidget {
  static const routeName = 'returnsScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(SizeConfig.defaultSize),
        child: Column(
            //crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/returns.png'),
              SizedBox(
                height: SizeConfig.defaultSize,
              ),
              Center(
                child: Text(
                  'You don\'t have any return requests',
                  style: GoogleFonts.lato(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: SizeConfig.defaultSize * 20,
              ),
              FlatButton(
                color: Colors.blue[700],
                  onPressed: () {},
                  child: Text('submit a request'.toUpperCase(),style: GoogleFonts.lato(color: Colors.white,fontSize: 17),))
              // Text('Need to submit a return request?  just click the button below',textAlign: TextAlign.center,)
            ]),
      ),
    );
  }
}
