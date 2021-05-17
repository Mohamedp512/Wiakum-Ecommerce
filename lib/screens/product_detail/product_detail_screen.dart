import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:wiakum/cosntants.dart';
import 'package:wiakum/screens/cart/cart_screen.dart';
import 'package:wiakum/screens/product_detail/components/cart_badge.dart';
import 'package:wiakum/services/auth.dart';
import 'package:wiakum/services/cart.dart';
import 'package:wiakum/services/products.dart';
import 'package:wiakum/size_config.dart';
import 'components/cart_counter.dart';

class ProductDetailScreen extends StatefulWidget {
  static const routeName = 'productDetailScreen';

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    final authData = Provider.of<Auth>(context, listen: false);
    final productId = ModalRoute.of(context).settings.arguments as String;
    final loadedProduct =
        Provider.of<Products>(context, listen: false).findById(productId);
    final cart = Provider.of<Cart>(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white.withOpacity(.2),
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text(
          loadedProduct.title,
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, CartScreen.routeName);
            },
            child: Padding(
                padding: EdgeInsets.all(SizeConfig.defaultSize),
                child: CartBadge(
                  activeColor: Colors.orange,
                  inactiveColor: Colors.orange,
                )),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(children: [
              Container(
                height: SizeConfig.screenHeight * .4,
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                  color: Colors.grey,
                ))),
                child: Hero(
                  tag: loadedProduct.id,
                  child: Image.network(
                    loadedProduct.imgUrl,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Positioned(
                  child: Consumer<Products>(
                      builder: (ctx, product, _) => IconButton(
                          icon: Icon(
                              loadedProduct.isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: Colors.red),
                          onPressed: () {
                            product.toggleFavoriteStatus(loadedProduct.id,
                                authData.userId, authData.token);

                            //loadedProduct.isFavorite=!loadedProduct.isFavorite;
                          })))
            ]),
//            ImageContainer(
//              id: loadedProduct.id,
//              image: loadedProduct.imgUrl,
//              positionedWidget:  Consumer<Product>(
//                builder: (ctx,product,_)=>IconButton(
//                        icon: Icon(
//                            loadedProduct.isFavorite
//                                ? Icons.favorite
//                                : Icons.favorite_border,
//                            color: Colors.red),
//                        onPressed: () {
//                          loadedProduct.toggleFavoriteStatus(loadedProduct.id);
//
//                          print(loadedProduct.id);
//                        }),
//              )),

            Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.all(SizeConfig.defaultSize),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            loadedProduct.title,
                            style: GoogleFonts.openSans(
                                fontSize: SizeConfig.defaultSize * 1.8),
                          ),
                          SizedBox(
                            height: SizeConfig.defaultSize,
                          ),
                          Row(
                            children: [
                              Text(
                                'SAR ',
                                style: GoogleFonts.openSans(
                                    fontSize: SizeConfig.defaultSize * 1.8,
                                    color: Colors.grey[700]),
                              ),
                              Text(
                                loadedProduct.price.toString(),
                                style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.bold,
                                    fontSize: SizeConfig.defaultSize * 2),
                              )
                            ],
                          ),
                          SizedBox(
                            height: SizeConfig.defaultSize * 1.5,
                          ),
                          Text(
                            loadedProduct.description,
                            style: TextStyle(
                                color: kTextColor.withOpacity(.7), height: 1.5),
                          ),
                          SizedBox(
                            height: SizeConfig.defaultSize * 3,
                          ),
                        ]),
                  ),
                  Padding(
                    padding: EdgeInsets.all(SizeConfig.defaultSize),
                    child: Column(
                      children: [
                        CartCounter(
                          num: quantity,
                          increasing: () {
                            setState(() {
                              quantity++;
                            });
                          },
                          decreasing: () {
                            if (quantity > 1) {
                              setState(() {
                                quantity--;
                              });
                            }
                          },
                        ),
                        SizedBox(
                          height: SizeConfig.defaultSize,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: FlatButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50)),
                              color: primaryColor,
                              onPressed: () {
                                Fluttertoast.showToast(
                                    msg: "Item has been added to cart",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.black87,
                                    textColor: Colors.white,
                                    fontSize: 16.0
                                );
                                cart.addItem(
                                    loadedProduct.id,
                                    loadedProduct.title,
                                    loadedProduct.price,
                                    loadedProduct.imgUrl,
                                    quantity);
                                print('done1');

                                print('done2');
                              },
                              padding:
                                  EdgeInsets.all(SizeConfig.defaultSize * 1.5),
                              child: Text(
                                'Add to cart'.toUpperCase(),
                                style: TextStyle(color: Colors.white),
                              )),
                        ),
                      ],
                    ),
                  )
                ]),
          ],
        ),
      ),
    );
  }
}
