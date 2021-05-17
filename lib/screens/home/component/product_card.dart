import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import 'package:wiakum/cosntants.dart';
import 'package:wiakum/models/product.dart';
import 'package:wiakum/screens/home/home_screen.dart';
import 'package:wiakum/screens/product_detail/product_detail_screen.dart';
import 'package:wiakum/services/auth.dart';
import 'package:wiakum/services/products.dart';
import 'package:wiakum/size_config.dart';

class ProductCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authData=Provider.of<Auth>(context,listen: false);
    final loadedProduct = Provider.of<Product>(context, );
    //double defaultSize = SizeConfig.defaultSize;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          ProductDetailScreen.routeName,
          arguments: loadedProduct.id,
        );
      },
      child: Container(
        width: SizeConfig.defaultSize * 15, //145
        decoration: BoxDecoration(
          color: Colors.white,
          //borderRadius: BorderRadius.circular(30),
        ),
        child: AspectRatio(
          aspectRatio: 0.693,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              AspectRatio(
                aspectRatio: 1,
                child: Stack(children: [
                  Hero(
                    tag: loadedProduct.id,
                    child: FadeInImage.assetNetwork(
                      placeholder: "assets/images/spinner.gif",
                      image:loadedProduct.imgUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                      right: 0,
                      child: Consumer<Product>(
                          builder: (ctx, product, _) => IconButton(
                              icon: Icon(loadedProduct.isFavorite?
                               Icons.favorite:Icons.favorite_border,
                                color: Colors.red
                              ),
                              onPressed: () {product.toggleFavoriteStatus(authData.token,authData.userId);})))
                ]),
              ),
              Padding(
                padding: EdgeInsets.all(SizeConfig.defaultSize * .5),
                child: Text(
                  loadedProduct.title,
                  maxLines: 2,
                ),
              ),
              SizedBox(height: SizeConfig.defaultSize / 2),
              Padding(
                padding: EdgeInsets.all(SizeConfig.defaultSize * .5),
                child: Text(
                  '${loadedProduct.price.toString()} SAR',
                  //maxLines: 2,
                ),
              ),

              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
