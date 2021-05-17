import 'package:flutter/foundation.dart';

class CartItem {
  final String id, title,image;
  final double price;
  final int qty;

  CartItem({
    @required this.id,
    @required this.title,
    @required this.image,
    @required this.price,
    @required this.qty,
  });
}
