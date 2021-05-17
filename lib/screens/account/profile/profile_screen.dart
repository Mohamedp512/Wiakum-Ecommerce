import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:wiakum/cosntants.dart';
import 'package:wiakum/models/user.dart';
import 'package:wiakum/screens/account/profile/update_user_info.dart';
import 'package:wiakum/size_config.dart';

class ProfileScreen extends StatefulWidget {
  static const routeName = 'profileScreen';

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  StorageReference storageReference = FirebaseStorage.instance.ref();
  String _imageUrl;
  File _image;
  final picker = ImagePicker();

  Future getCameraImage() async {
    final image = await picker.getImage(source: ImageSource.camera);
    setState(() {
      _image = File(image.path);
    });
  }

  Future getGalleryImage() async {
    final image = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image = File(image.path);
    });
  }

  Future uploadPic() async {
    String fileName = '${DateTime.now().toString()}_image.jpg';
    StorageReference uploadedFile =
        FirebaseStorage.instance.ref().child("$fileName images");
    StorageUploadTask uploadTask = uploadedFile.putFile(_image);
    var url = await (await uploadTask.onComplete).ref.getDownloadURL();
    _imageUrl = url.toString();
    print('Download URL:$_imageUrl');
    return _imageUrl;
  }

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<User>(context, listen: false).user;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              //alignment: Alignment.bottomCenter,
              children: [
                Column(
                  children: [
                    Container(
                      alignment: Alignment.topRight,
                      height: SizeConfig.screenHeight / 4,
                      color: primaryColor,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: SizeConfig.defaultSize * 2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                                padding: EdgeInsets.all(SizeConfig.defaultSize),
                                child: CircleAvatar(
                                    child: IconButton(
                                  icon: Icon(
                                    Icons.done,
                                    color: Colors.white,
                                  ),
                                  onPressed: ()async {
                                    print('Start');
                                    if (_image != null) await uploadPic();
                                    print('done upload');
                                    await Provider.of<User>(context,listen: false).updateUserPhoto(_imageUrl);
                                    Navigator.pop(context);
                                    setState(() {
                                      _image=null;
                                    });
                                  },
                                )))
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.defaultSize * 9,
                    ),
                    Consumer<User>(
                      builder: (ctx, user, _) => Text(
                        user.user.name,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue),
                      ),
                    ),
                    Text(
                      'Email',
                      style: TextStyle(height: 2),
                    ),
                    SizedBox(
                      height: SizeConfig.defaultSize * 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: SizeConfig.defaultSize),
                          child: FlatButton(
                            child: Text(
                              'Edit',
                              style: TextStyle(
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline),
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, UpdateUserInfo.routeName);
                            },
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.defaultSize * 2,
                      ),
                      child: Container(
                        //height: SizeConfig.screenHeight / 2,
                        decoration:
                            BoxDecoration(color: Colors.white, boxShadow: [
                          BoxShadow(
                              color: primaryColor,
                              blurRadius: 10,
                              spreadRadius: 1,
                              offset: Offset(2, 3))
                        ]),
                        child: Column(
                          children: [
                            ListTile(
                              leading: Icon(
                                Icons.phone,
                                color: primaryColor,
                              ),
                              title: Text('Mobile'),
                              subtitle: Consumer<User>(
                                builder: (ctx, user, _) => Text(
                                  user.user.mobile == null
                                      ? ''
                                      : user.user.mobile,
                                  style: TextStyle(
                                      fontSize: SizeConfig.defaultSize*1.8,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue),
                                ),
                              ),
                            ),
                            Divider(),
                            ListTile(
                              leading: Icon(
                                Icons.location_on,
                                color: primaryColor,
                              ),
                              title: Text('Address'),
                              subtitle: Consumer<User>(
                                builder: (ctx, user, _) => Text(
                                  user.user.address == null
                                      ? ''
                                      : user.user.address,
                                  style: TextStyle(
                                      fontSize: SizeConfig.defaultSize*1.8,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue),
                                ),
                              ),
                            ),
                            Divider(),
                            ListTile(
                              leading: Icon(
                                Icons.location_city,
                                color: primaryColor,
                              ),
                              title: Text('City'),
                              subtitle: Consumer<User>(
                                builder: (ctx, user, _) => Text(
                                  user.user.city == null ? '' : user.user.city,
                                  style: TextStyle(
                                      fontSize: SizeConfig.defaultSize*1.8,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.defaultSize * 3,
                    ),
                  ],
                ),
                Positioned(
                  top: SizeConfig.defaultSize * 12,
                  left: SizeConfig.screenWidth / 3.2,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100)),
                        color: Colors.grey,
                        child: Container(
                          height: SizeConfig.defaultSize * 15,
                          width: SizeConfig.defaultSize * 15,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              border:
                                  Border.all(color: Colors.white, width: 6)),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(80),
                              child: _image == null
                                  ? (userData.imageUrl == null
                                      ? Icon(
                                          Icons.person,
                                          color: Colors.white,
                                          size: SizeConfig.defaultSize * 10,
                                        )
                                      : Consumer<User>(
                                          builder: (ctx, user, _) =>
                                              Image.network(
                                                  user.user.imageUrl,fit: BoxFit.cover,)))
                                  : Image.file(
                                      _image,
                                      fit: BoxFit.cover,
                                    )
                              // _image == null
                              //     ? Icon(Icons.person,color: Colors.white,size: SizeConfig.defaultSize*10,)
                              //    :Image.network(_imageUrl,fit: BoxFit.fill,),
                              ),
                        ),
                      ),
                      Positioned(
                        bottom: 20,
                        right: 5,
                        child: CircleAvatar(
                          radius: SizeConfig.defaultSize * 1.7,
                          backgroundColor: Colors.black54,
                          child: IconButton(
                              icon: Icon(
                                Icons.edit,
                                color: Colors.white,
                                size: SizeConfig.defaultSize * 1.8,
                              ),
                              onPressed: () {
                                showCameraDialog(context);
                              }),
                        ),
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  showCameraDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Text(
              'Add Picture',
              textAlign: TextAlign.center,
            ),
            children: <Widget>[
              Divider(
                color: Colors.orange,
                thickness: 1,
              ),
              SimpleDialogOption(
                child: Text('From Camera'),
                onPressed: () {
                  Navigator.pop(context);
                  getCameraImage();
                },
              ),
              Divider(
                color: Colors.blue,
              ),
              SimpleDialogOption(
                  child: Text('From Gallery'),
                  onPressed: () {
                    Navigator.pop(context);
                    getGalleryImage();
                  }),
              Divider(
                color: Colors.blue,
              ),
              SimpleDialogOption(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }
}
