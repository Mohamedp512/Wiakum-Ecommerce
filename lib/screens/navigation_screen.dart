import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wiakum/badge.dart';
import 'package:wiakum/cosntants.dart';
import 'package:wiakum/models/user.dart';
import 'package:wiakum/screens/account/account_screen.dart';
import 'package:wiakum/screens/account/checkout/checkout_screen.dart';
import 'package:wiakum/screens/admin/manage_products/admin_manage_products.dart';
import 'package:wiakum/screens/admin/manage_products/components/add_products/add_products.dart';
import 'package:wiakum/services/auth.dart';
import 'package:wiakum/services/products.dart';
import 'cart/cart_screen.dart';
import 'categories/categories_screen.dart';
import 'home/home_screen.dart';
import 'product_detail/components/cart_badge.dart';

class NavigationScreen extends StatefulWidget {
  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  bool _isLoading = false;
  bool _isInit = true;

  @override
  void didChangeDependencies() async {
    if (_isInit) {
      _isLoading = true;
      final authData=Provider.of<Auth>(context,listen: false);
      await Provider.of<Products>(context).fetchProducts(authData.userId,authData.token);
      Provider.of<User>(context,listen: false).fetchUserData();


      _isLoading = false;
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  int _page = 0;
  final List<Widget> _widgets = [
    HomeScreen(),
    CategoriesScreen(),
    CartScreen(),
    AccountScreen(),
  ];
  GlobalKey _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    //final cart = Provider.of<Cart>(context, listen: false);
    return Scaffold(
      body:_isLoading?Center(child: CircularProgressIndicator()): _widgets[_page],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: primaryColor,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home')),
          BottomNavigationBarItem(
              icon: Icon(Icons.apps), title: Text('Categories')),
          BottomNavigationBarItem(
            icon: CartBadge(),
            title: Text('Cart'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('Account'),
          )
        ],
        key: _bottomNavigationKey,
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
        currentIndex: _page,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}

