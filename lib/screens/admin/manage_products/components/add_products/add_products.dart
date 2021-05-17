import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:wiakum/models/product.dart';
import 'package:wiakum/services/categories.dart';
import 'package:wiakum/services/products.dart';
import 'package:wiakum/size_config.dart';
import 'component/custom_text_field.dart';

class AddProducts extends StatefulWidget {
  @override
  _AddProductsState createState() => _AddProductsState();
}

class _AddProductsState extends State<AddProducts> {
  StorageReference storageRef = FirebaseStorage.instance.ref();
  String _title, _category, _description, _imgUrl;
  double _price;
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  File _image;
  final picker = ImagePicker();
  bool _isLoading = false;

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
    String fileName = '${_title}_image.jpg';
    StorageReference uploadedFile =
        FirebaseStorage.instance.ref().child("$fileName images");
    StorageUploadTask uploadTask = uploadedFile.putFile(_image);
    var url = await (await uploadTask.onComplete).ref.getDownloadURL();
    _imgUrl = url.toString();
    print('Download URL:$_imgUrl');
    return _imgUrl;
  }

  void resetFields() {
    _globalKey.currentState.reset();
    setState(() {
      _image = null;
      _category = null;
    });
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


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Container(
                height: SizeConfig.screenHeight * .8,
                child: Form(
                  key: _globalKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: SizeConfig.defaultSize * 1.2,
                          ),
                          Center(
                            child: Container(
                              height: SizeConfig.defaultSize * 12,
                              width: SizeConfig.defaultSize * 12,
                              decoration: BoxDecoration(
                                  image: _image == null
                                      ? null
                                      : DecorationImage(
                                          image: FileImage(_image),
                                          fit: BoxFit.fill),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.orange)),
                              child: _image == null
                                  ? IconButton(
                                      icon: Icon(Icons.camera_enhance),
                                      onPressed: () {
                                        showCameraDialog(context);
                                      })
                                  : Stack(
                                      children: <Widget>[
                                        Positioned(
                                          top: -10,
                                          right: -10,
                                          child: IconButton(
                                              icon: Icon(
                                                Icons.delete,
                                                color: Colors.red,
                                                size: 15,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  _image = null;
                                                });
                                              }),
                                        )
                                      ],
                                    ),
                            ),
                          ),
                          CustomTextFormField(
                            onClick: (value) {
                              _title = value;
                            },
                            labelText: 'Name',
                            hintText: 'Product Name',
                          ),
                          CustomTextFormField(
                            onClick: (value) {
                              _price = double.parse(value);
                            },
                            hintText: 'Product Price',
                            labelText: 'Price',
                            keyboardType: TextInputType.numberWithOptions(),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.orange),
                                borderRadius: BorderRadius.circular(10)),
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            child: DropdownButton<String>(
                                icon: Icon(Icons.keyboard_arrow_down),
                                underline: Container(
                                  color: Colors.transparent,
                                ),
                                value: _category,
                                hint: const Text(' Select Category'),
                                items: Provider.of<Categories>(context)
                                    .categories
                                    .map((cat) => cat.title)
                                    .map<DropdownMenuItem<String>>((String
                                            value) =>
                                        DropdownMenuItem<String>(
                                            value: value,
                                            child: Container(
                                              margin: EdgeInsets.only(
                                                  left: SizeConfig.defaultSize,
                                                  right:
                                                      SizeConfig.defaultSize),
                                              child: Text(
                                                value,
                                                style: TextStyle(
                                                    color: Colors.blueGrey),
                                              ),
                                            )))
                                    .toList(),
                                onChanged: (String newValue) {
                                  setState(() {
                                    _category = newValue;
                                  });
                                }),
                          ),
                          CustomTextFormField(
                            onClick: (value) {
                              _description = value;
                            },
                            maxLines: 4,
                            hintText: 'Product Description',
                            labelText: 'Description',
                          ),
                          SizedBox(height: SizeConfig.defaultSize * 2),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Builder(
                            builder: (context) => Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              width: SizeConfig.screenWidth * .4,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.orange),
                              child: FlatButton(
                                onPressed: () async {
                                  if (_globalKey.currentState.validate()) {
                                    _globalKey.currentState.save();
                                    setState(() {
                                      _isLoading = true;
                                    });
                                    if (_image != null) await uploadPic();
                                    Provider.of<Products>(context,
                                            listen: false)
                                        .addProduct(Product(
                                            title: _title,
                                            description: _description,
                                            category: _category,
                                            imgUrl: _imgUrl,
                                            price: _price));
//                                        .catchError((error) {
//                                      return showDialog(
//                                        context: context,
//                                        builder: (context) => AlertDialog(
//                                          title: Text('Error!'),
//                                          content: Text(error.toString()),
//                                          actions: [
//                                            FlatButton(
//                                                onPressed: () {
//                                                  Navigator.pop(context);
//                                                },
//                                                child: Text('Ok'))
//                                          ],
//                                        ),
//                                      );
//                                    })

                                      setState(() {
                                        _isLoading = false;
                                      });



                                  }
                                  setState(() {
                                    _image = null;
                                    _imgUrl = null;
                                  });
                                },
                                child: Text(
                                  'Add Product',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                                //color: Colors.orange,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            width: SizeConfig.screenWidth * .4,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.orange),
                            child: FlatButton(
                              onPressed: resetFields,
                              child: Text(
                                'Clear',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                              //color: Colors.orange,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
