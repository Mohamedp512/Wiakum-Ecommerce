import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vertical_tabs/vertical_tabs.dart';
import 'package:wiakum/screens/home/component/product_card.dart';
import 'package:wiakum/screens/home/home_screen.dart';
import 'package:wiakum/screens/search_screen.dart';
import 'package:wiakum/services/products.dart';
import 'package:wiakum/size_config.dart';
import 'component/cat_tab.dart';
import 'component/category_page.dart';

class CategoriesScreen extends StatelessWidget {
  final int index;

  CategoriesScreen({this.index=0});
static const routeName='categoryScreen';
  @override
  Widget build(BuildContext context) {
    final beautyProducts =
        Provider.of<Products>(context).findByCat('Beauty & Personal Care');
    final willingProducts =
        Provider.of<Products>(context).findByCat('Wellbeing');
    final functionalFoodProducts =
        Provider.of<Products>(context).findByCat('Functional Food');
    final healthDevicesProducts =
        Provider.of<Products>(context).findByCat('Health Devices');

    return Scaffold(
      appBar: buildAppBar((){Navigator.pushNamed(context, SearchScreen.routeName);}),
      body: Column(children: [
        Container(
          height: SizeConfig.screenHeight * .8,
          child: VerticalTabs(
              initialIndex: index,
              backgroundColor: Colors.white,
              indicatorColor: Colors.white,
              selectedTabBackgroundColor: Colors.white,
              tabsWidth: SizeConfig.defaultSize * 10,
              tabs: <Tab>[
                Tab(
                    child: CatTab(
                  title: 'Beauty & Personal Care',
                  image:
                      'https://d192mn8i0m09h7.cloudfront.net/wysiwyg/magebig/layout04/personalcare-new.png',
                )),
                Tab(
                    child: CatTab(
                  image:
                      'https://d192mn8i0m09h7.cloudfront.net/wysiwyg/magebig/layout04/wellbeing-new.png',
                  title: 'Wellbeing',
                )),
                Tab(
                  child: CatTab(
                    image:
                        'https://d192mn8i0m09h7.cloudfront.net/wysiwyg/magebig/layout04/healthdevices-new.png',
                    title: 'Health Devices',
                  ),
                ),
                Tab(
                    child: CatTab(
                  image:
                      'https://d192mn8i0m09h7.cloudfront.net/wysiwyg/magebig/layout04/Category_Manuka_20200723.jpg',
                  title: 'Functional Food',
                )),
              ],
              contents: <Widget>[
                Container(
                  child: CategoryPage(
                    catName: 'Beauty & Personal Care',
                    products: (context, index) => ChangeNotifierProvider.value(
                        value: beautyProducts[index], child: ProductCard()),
                    length: beautyProducts.length,
                  ),
                ),
                Container(
                    child: CategoryPage(
                  catName: 'Wellbeing',
                  length: willingProducts.length,
                  products: (context, index) => ChangeNotifierProvider.value(
                      value: willingProducts[index], child: ProductCard()),
                )),
                Container(
                    child: CategoryPage(
                  catName: 'Health Devices',
                  length: healthDevicesProducts.length,
                  products: (context, index) => ChangeNotifierProvider.value(
                      value: willingProducts[index], child: ProductCard()),
                )),
                Container(
                    child: CategoryPage(
                  catName: 'Functional Food',
                  length: healthDevicesProducts.length,
                  products: (context, index) => ChangeNotifierProvider.value(
                      value: functionalFoodProducts[index],
                      child: ProductCard()),
                )),
              ]),
        )
      ]),
    );
  }
}
