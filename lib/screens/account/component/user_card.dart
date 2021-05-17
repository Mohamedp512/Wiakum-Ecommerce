import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:wiakum/screens/account/favorites/favorite_screen.dart';
import 'package:wiakum/screens/account/orders/orders_screen.dart';
import 'package:wiakum/screens/account/returns/return_screen.dart';
import 'package:wiakum/size_config.dart';

class UserCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.defaultSize * 12,
      width: double.infinity,
      child: Card(
        elevation: 5,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(5),
                  child: CircleAvatar(
                    maxRadius: 25,
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                    child: IconButton(
                      onPressed: (){Navigator.pushNamed(context, OrdersScreen.routeName);},
                      icon: Icon(
                        AntDesign.profile,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Text('Orders', style: TextStyle(fontWeight: FontWeight.bold))
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(5),
                  child: CircleAvatar(
                    maxRadius: 25,
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                    child: IconButton(
                      onPressed: (){Navigator.pushNamed(context, ReturnScreen.routeName);},
                      icon: Icon(
                        Ionicons.ios_undo,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Text(
                  'Returns',
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(5),
                  child: CircleAvatar(
                    maxRadius: 25,
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                    child: IconButton(onPressed: (){Navigator.pushNamed(context, FavoriteScreen.routeName);},
                      icon: Icon(
                        Icons.favorite_border,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Text('Favorites', style: TextStyle(fontWeight: FontWeight.bold))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
