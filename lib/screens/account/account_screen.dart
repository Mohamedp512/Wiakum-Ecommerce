import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:wiakum/models/user.dart';
import 'package:wiakum/screens/account/component/user_card.dart';
import 'package:wiakum/screens/account/phone_verification/phone_verification_screen.dart';
import 'package:wiakum/screens/account/profile/profile_screen.dart';
import 'package:wiakum/services/auth.dart';
import 'package:wiakum/size_config.dart';

import '../../cosntants.dart';
import 'component/custom_listTile.dart';

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
  final user=Provider.of<User>(context,listen: false).user;
  final String userName=user.name;

    return SafeArea(
      child: Scaffold(
          backgroundColor: kFaintColor,
          body: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: SizeConfig.defaultSize*2),
                padding: EdgeInsets.all(SizeConfig.defaultSize * 1.5),
                height: SizeConfig.defaultSize * 9,
                child: Text(
                  'Welcome  $userName',
                  style: GoogleFonts.openSans(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              UserCard(),
              Expanded(
                child: ListView(
                  //shrinkWrap: true,
                  //physics: NeverScrollableScrollPhysics(),
                  children: [
                    Padding(
                        padding: EdgeInsets.all(SizeConfig.defaultSize * 2),
                        child: Text(
                          'My Account'.toUpperCase(),
                          style: GoogleFonts.lato(fontWeight: FontWeight.bold),
                        )),
                    Card(
                        child: Column(children: [
                      CustomListTile(
                        press: ()async{
                          //await Provider.of<User>(context,listen: false).fetchUserData();
                          Navigator.pushNamed(context, ProfileScreen.routeName);
                        },
                        title: 'Profile',
                        leadingIcon: AntDesign.profile,
                      ),
                      Divider(),
                      CustomListTile(
                        title: 'Addresses',
                        leadingIcon: Entypo.address,
                        press: (){Navigator.pushNamed(context, PhoneVerificationScreen.routeName);},
                      ),
                      Divider(),
                      CustomListTile(
                        title: 'Language',
                        leadingIcon: Entypo.language,
                        subTitle: 'English',
                      ),
                      Divider(),
                      CustomListTile(
                        title: 'Country',
                        subTitle: 'Egypt',
                        leadingIcon: MaterialIcons.language,
                      )
                    ])),
                    Padding(
                        padding: EdgeInsets.all(SizeConfig.defaultSize * 2),
                        child: Text(
                          'Reach out to us'.toUpperCase(),
                          style: GoogleFonts.lato(fontWeight: FontWeight.bold),
                        )),
                    Card(
                      child: Column(
                        children: [
                          ListTile(
                            leading:Icon(Icons.help_outline),
                            title: Text('Help',style: TextStyle(fontWeight: FontWeight.bold)),trailing: Icon(AntDesign.right),
                          ),
                          Divider(),
                          ListTile(
                            leading:Icon(Icons.call),
                            title: Text('Contact Us',style: TextStyle(fontWeight: FontWeight.bold)),trailing: Icon(AntDesign.right),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.defaultSize,
                    ),
                    FlatButton(
                        onPressed: () async{
                          await Provider.of<Auth>(context,listen: false).logOut();
                        },
                        child: Row(
                          children: [
                            Icon(Feather.log_out),
                            SizedBox(
                              width: SizeConfig.defaultSize,
                            ),
                            Text('Sign Out',style: GoogleFonts.lato(fontSize: 17),),
                            Spacer()
                          ],
                        ))
                  ],
                ),
              )
            ],
          )),
    );
  }
}
