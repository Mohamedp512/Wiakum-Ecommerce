import 'package:flutter/foundation.dart';
import 'cart.dart';

class OrderItem {
  final String id;
  final String address;
  final String mobile;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    @required this.id,
    @required this.address,
    @required this.mobile,
    @required this.amount,
    @required this.products,
    @required this.dateTime,
  });
}
