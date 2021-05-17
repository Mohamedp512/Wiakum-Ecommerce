import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:wiakum/models/cart.dart';
import 'package:wiakum/models/order.dart';
import 'package:http/http.dart' as http;

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];
  final String authToken;
  final String userId;


  Orders(this.authToken,this.userId,this._orders, );

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> fetchOrders() async {
    final url = 'https://wiakum-449c6.firebaseio.com/orders/$userId.json?auth=$authToken';
    final response = await http.get(url);
    final List<OrderItem> loadedOrders = [];
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    if (extractedData == null) {
      return;
    }
    extractedData.forEach((orderId, orderData) {
      loadedOrders.add(
          OrderItem(id: orderId,
              address: orderData['address'],
              mobile: orderData['mobile'],
              amount: orderData['amount'],
              products: (orderData['products'] as List<dynamic>).map((item) =>
                  CartItem(id: item['id'],
                      title: item['title'],
                      image: item['image'],
                      price: item['price'],
                      qty: item['quantity'])).toList(),
              dateTime: DateTime.parse(orderData['dateTime']))
      );
    });
    _orders=loadedOrders.reversed.toList();
    notifyListeners();
  }


  Future<void> addOrder(List<CartItem> cartProducts, double total,
      String mobile, String address) async {
    final url = 'https://wiakum-449c6.firebaseio.com/orders/$userId.json?auth=$authToken';
    final timestamp = DateTime.now();
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'amount': total,
          'dateTime': timestamp.toIso8601String(),
          'address': address,
          'mobile': mobile,
          'products': cartProducts.map((cp) =>
          {
            'id': cp.id,
            'title': cp.title,
            'image': cp.image,
            'price': cp.price,
            'quantity': cp.qty
          }).toList(),
        }),
      );
      _orders.insert(
        0,
        OrderItem(
          id: json.decode(response.body)['name'],
          address: address,
          mobile: mobile,
          amount: total,
          products: cartProducts,
          dateTime: DateTime.now(),
        ),
      );
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }
}
