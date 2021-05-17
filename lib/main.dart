import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wiakum/models/user.dart';
import 'package:wiakum/screens/account/checkout/checkout_screen.dart';
import 'package:wiakum/screens/account/favorites/favorite_screen.dart';
import 'package:wiakum/screens/account/orders/orders_screen.dart';
import 'package:wiakum/screens/account/phone_verification/phone_verification_screen.dart';
import 'package:wiakum/screens/account/profile/profile_screen.dart';
import 'package:wiakum/screens/account/profile/update_user_info.dart';
import 'package:wiakum/screens/account/returns/return_screen.dart';
import 'package:wiakum/screens/admin/manage_products/admin_manage_products.dart';
import 'package:wiakum/screens/authentication/login_screen.dart';
import 'package:wiakum/screens/authentication/signup_screen.dart';
import 'package:wiakum/screens/cart/cart_screen.dart';
import 'package:wiakum/screens/categories/categories_screen.dart';
import 'package:wiakum/screens/product_detail/product_detail_screen.dart';
import 'package:wiakum/screens/search_screen.dart';
import 'package:wiakum/screens/splash_screen.dart';
import 'package:wiakum/services/auth.dart';
import 'package:wiakum/services/cart.dart';
import 'package:wiakum/services/categories.dart';
import 'package:wiakum/services/orders.dart';
import 'package:wiakum/services/products.dart';
import 'models/category.dart';
import 'models/product.dart';
import 'screens/home/home_screen.dart';
import 'screens/navigation_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Auth()),
        ChangeNotifierProvider.value(value: Product()),
        ChangeNotifierProvider.value(value: Cart()),
        ChangeNotifierProvider.value(value: Products()),
        ChangeNotifierProvider.value(value: Categories()),
        ChangeNotifierProvider.value(value: MainCategory()),
        ChangeNotifierProxyProvider<Auth, User>(
            update: (context, auth, user) => User(
                  userId: auth.userId,
                  authToken: auth.token,

                )),
        ChangeNotifierProxyProvider<Auth, Orders>(
          update: (context, auth, previousOrders) => Orders(auth.token,
              auth.userId, previousOrders == null ? [] : previousOrders.orders),
        )
      ],
      child: Consumer<Auth>(
        builder: (context, auth, _) => MaterialApp(
          title: 'Wiakum',
          debugShowCheckedModeBanner: false,
          routes: {
            PhoneVerificationScreen.routeName:(context)=>PhoneVerificationScreen(),
            UpdateUserInfo.routeName:(context)=>UpdateUserInfo(),
            ProfileScreen.routeName:(context)=>ProfileScreen(),
            CategoriesScreen.routeName: (context) => CategoriesScreen(),
            SearchScreen.routeName: (context) => SearchScreen(),
            LoginScreen.routeName: (context) => LoginScreen(),
            SignUpScreen.routeName: (context) => SignUpScreen(),
            OrdersScreen.routeName: (context) => OrdersScreen(),
            ReturnScreen.routeName: (context) => ReturnScreen(),
            FavoriteScreen.routeName: (context) => FavoriteScreen(),
            CheckoutScreen.routeName: (context) => CheckoutScreen(),
            AdminManageProducts.routeName: (context) => AdminManageProducts(),
            CartScreen.routeName: (context) => CartScreen(),
            HomeScreen.routeName: (context) => HomeScreen(),
            ProductDetailScreen.routeName: (context) => ProductDetailScreen(),
          },
          theme: ThemeData(
            primarySwatch: Colors.orange,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: auth.isAuth
              ? NavigationScreen()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (context, authResultSnapshot) =>
                      authResultSnapshot.connectionState ==
                              ConnectionState.waiting
                          ? SplashScreen()
                          : LoginScreen()),
        ),
      ),
    );
  }
}
