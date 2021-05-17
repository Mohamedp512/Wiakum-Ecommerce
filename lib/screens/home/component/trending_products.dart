import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wiakum/screens/home/component/product_card.dart';
import 'package:wiakum/services/products.dart';
import 'package:wiakum/size_config.dart';

class TrendingProducts extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final products=Provider.of<Products>(context).products;
    return Padding(
      padding: EdgeInsets.all(SizeConfig.defaultSize*2),
      child: GridView.builder(
        shrinkWrap:true ,
        physics: NeverScrollableScrollPhysics(),
        itemCount: products.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: .693,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10),
        itemBuilder: (context, index) => ChangeNotifierProvider.value(value: products[index],
        child: ProductCard(),
//          id: products[index].id,
//          image: products[index].imgUrl,
//          price: products[index].price.toString(),
//          title: products[index].title,
        ),
      ),
    );
  }
}
