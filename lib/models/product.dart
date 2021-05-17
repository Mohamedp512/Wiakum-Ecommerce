import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:convert/convert.dart';

class Product with ChangeNotifier {
  final String id, title, description, category, subCategory, imgUrl,brand;
  final double price;
  bool isFavorite;

  Product({
      @required this.id,
      @required this.title,
      @required this.description,
      @required this.category,
      @required this.subCategory,
      @required this.imgUrl,
      @required this.brand,
      @required this.price,
      this.isFavorite = false});

  void _setFavValue(bool newValue){
    isFavorite=newValue;
    notifyListeners();
  }

  Future<void> toggleFavoriteStatus(String token, String userId)async{
    final oldStatus=isFavorite;
    isFavorite=!isFavorite;
    notifyListeners();
    final url = 'https://wiakum-449c6.firebaseio.com/userFavorites/$userId/$id.json?auth=$token';
    try {
      final response= await http.put(url, body: json.encode(
          isFavorite
      ));
      notifyListeners();
    }catch(error){
      isFavorite=oldStatus;
      print('Error');
    }
    notifyListeners();
  }
}
