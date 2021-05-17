import 'package:wiakum/models/category.dart';
import 'package:wiakum/screens/home/component/trending_products.dart';
import 'package:wiakum/screens/search_screen.dart';
import 'package:wiakum/services/auth.dart';
import 'package:wiakum/services/categories.dart';
import 'package:wiakum/services/products.dart';
import 'package:wiakum/size_config.dart';
import 'package:provider/provider.dart';
import './component/carousel_widget.dart';
import 'package:flutter/material.dart';
import 'component/main_category_car.dart';

class HomeScreen extends StatelessWidget {

  static const routeName = '/home';
  bool _isLoading=false;

  Future<void> _refreshProducts(BuildContext context)async{
    _isLoading=true;
    final authData =Provider.of<Auth>(context,listen: false);
    await Provider.of<Products>(context,listen: false).fetchProducts(authData.userId, authData.token);
    _isLoading=false;
  }


  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<Categories>(context, listen: false);
    final products = Provider
        .of<Products>(context)
        .products;
    SizeConfig().int(context);
    return Scaffold(
      appBar: buildAppBar((){Navigator.pushNamed(context, SearchScreen.routeName);}),
      body: RefreshIndicator(
        onRefresh:()=>_refreshProducts(context) ,
        child: Container(
          child: ListView(
            children: [
              CarouselWidget(),
              SizedBox(
                height: SizeConfig.defaultSize,
              ),
              TitleText(
                title: 'Shop by category',
              ),
              SizedBox(
                height: SizeConfig.defaultSize,
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: SizeConfig.defaultSize),
                height: SizeConfig.defaultSize * 15,
                width: double.infinity,
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //scrollDirection: Axis.horizontal,
                    children: categories.categories
                        .map((MainCategory cat) =>
                        MainCategoryCard(title: cat.title, image: cat.image,))
                        .toList()),
              ),
              TitleText(title: 'Trending products'),

              TrendingProducts()
//            Padding(
//              padding: EdgeInsets.all(SizeConfig.defaultSize * 2),
//              child: GridView.builder(
//                  shrinkWrap: true,
//                  physics: NeverScrollableScrollPhysics(),
//                  itemCount: products.length,
//                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                      crossAxisCount: 2,
//                      childAspectRatio: .693,
//                      crossAxisSpacing: 10,
//                      mainAxisSpacing: 10),
//                  itemBuilder: (context, index) =>
//              ),
//            ),
            ],
          ),
        ),
      ),
    );
  }
}


class TitleText extends StatelessWidget {
  final String title;

  TitleText({@required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize * 1.5),
      child: Text(
        title,
        style: TextStyle(
          fontSize: SizeConfig.defaultSize * 2,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

AppBar buildAppBar(Function search) {


  return AppBar(
    elevation: 0,
    backgroundColor: Colors.white,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Wiakum',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              search();
            },
            child: Container(
              margin: EdgeInsets.all(SizeConfig.defaultSize),
              padding: EdgeInsets.all(SizeConfig.defaultSize * .5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.grey[350])),
              child: Row(
                children: [
                  Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    width: SizeConfig.defaultSize,
                  ),
                  Text(
                    'What are you looking for?',
                    style: TextStyle(
                        color: Colors.grey[350],
                        fontSize: SizeConfig.defaultSize * 1.5),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    ),
  );
}
