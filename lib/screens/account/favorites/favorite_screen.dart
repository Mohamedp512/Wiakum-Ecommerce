import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wiakum/cosntants.dart';
import 'package:wiakum/screens/home/component/product_card.dart';
import 'package:wiakum/services/products.dart';
import 'package:wiakum/size_config.dart';

class FavoriteScreen extends StatelessWidget {
  static const routeName='favoriteScreen';
  @override
  Widget build(BuildContext context) {
    final favProducts = Provider.of<Products>(context).favoriteProducts;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text('Favorites'),
      ),
      body: Padding(
        padding: EdgeInsets.all(SizeConfig.defaultSize*2),
        child: GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: .693,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10
          ),
            itemCount: favProducts.length,
            itemBuilder: (context, index) => ChangeNotifierProvider.value(
                value: favProducts[index], child: ProductCard())),
      ),
    );
  }
}
