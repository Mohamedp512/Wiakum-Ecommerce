import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:wiakum/models/cart.dart';

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items == null ? 0 : items.length;
  }


  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.qty;
    });
    return total;
  }

  Future<void> addItem(String productId, String title, double price,
      String image, int quantity) async {

    if (_items.containsKey(productId)) {
      // final url = 'https://wiakum-449c6.firebaseio.com/cart$productId.json';
      // final existingCartItem = _items.values.firstWhere((cartItem) =>
      // cartItem.id == productId);
      // await http.patch(url,
      //     body: json.encode(
      //         {
      //           'title': existingCartItem.title,
      //           'image': existingCartItem.image,
      //           'price': existingCartItem..price,
      //           'quantity': existingCartItem.qty + 1
      //         }
      //     ));
      _items.update(productId, (existingCartItem) =>
          CartItem(id: existingCartItem.id,
              image: existingCartItem.image,
              title: existingCartItem.title,
              price: existingCartItem.price,
              qty: existingCartItem.qty + 1));
    } else {
      // const url = 'https://wiakum-449c6.firebaseio.com/cart.json';
      // final response = await http.post(
      //     url,
      //     body: json.encode({
      //       'title': title,
      //       'image': image,
      //       'price': price,
      //       'quantity': 1
      //     })
      // );
      _items.putIfAbsent(productId, () =>
          CartItem(id: DateTime.now().toIso8601String(),
              title: title,
              image: image,
              price: price,
              qty: quantity));
    }
    notifyListeners();
  }

  Future<void> fetchCart() async {
    const url = 'https://wiakum-449c6.firebaseio.com/cart.json';
    final response = await http.get(url);
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    if (extractedData == null) {
      return;
    }
    final List<CartItem> loadedItems = [];
    extractedData.forEach((prodId, cartData) {
      loadedItems.add(CartItem(id: prodId,
          title: cartData['title'],
          image: cartData['image'],
          price: cartData['price'],
          qty: cartData['quantity']));
    });
    // _items=loadedItems;
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}