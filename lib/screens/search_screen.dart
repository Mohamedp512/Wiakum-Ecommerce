import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wiakum/models/product.dart';
import 'package:wiakum/services/products.dart';
import 'package:wiakum/size_config.dart';

import 'home/component/product_card.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = 'searchScreen';

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  String _text;
  List<Product> searchedProducts = [];
  _error(bool ){
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _globalKey,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black87,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
          backgroundColor: Colors.white,
          title: Row(
            children: [
              Container(
                  //    padding: Edg,
                  height: SizeConfig.defaultSize * 4,
                  width: SizeConfig.screenWidth * .6,
                  child: TextFormField(
                    //cursorWidth: 10,
                    decoration: InputDecoration(
                      focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(width: 0,color: Colors.transparent)),
                      errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white,width: 0)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey[350])),
                      hintText: 'What are you looking for?',
                      hintStyle:
                          TextStyle(color: Colors.grey[350], height: 2.8),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2, color: Colors.red)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(),
                      ),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return _error(false);
                      }
                    },
                    onSaved: (value) {
                      setState(() {
                        _text = value;
                      });
                    },
                  )),
            ],
          ),
          actions: [
            Container(
                margin: EdgeInsets.symmetric(
                    vertical: SizeConfig.defaultSize,
                    horizontal: SizeConfig.defaultSize * .5),
                decoration: BoxDecoration(
                    color: Colors.red, borderRadius: BorderRadius.circular(20)),
                child: IconButton(
                    icon: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    onPressed: () async {
                      setState(() {
                        searchedProducts.clear();
                      });
                      if (_globalKey.currentState.validate()) {
                        _globalKey.currentState.save();
                        final result =
                            await Provider.of<Products>(context, listen: false)
                                .search(_text);
                        setState(() {
                          searchedProducts = result;
                        });
                      } else {
                        setState(() {
                          searchedProducts = [];
                        });
                      }
                    }))
          ],
        ),
        body: searchedProducts.isEmpty
            ? Container()
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: SizeConfig.defaultSize),
                        child: Chip(
                            backgroundColor: Colors.grey[200],
                            label: Text(
                              'Best match',
                              style: TextStyle(color: Colors.red),
                            ))),
                    Padding(
                      padding: EdgeInsets.all(SizeConfig.defaultSize * 2),
                      child: GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: .693,
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 10),
                          itemCount: searchedProducts.length,
                          itemBuilder: (context, index) =>
                              ChangeNotifierProvider.value(
                                  value: searchedProducts[index],
                                  child: ProductCard())),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
