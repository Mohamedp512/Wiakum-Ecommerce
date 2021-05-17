import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:wiakum/cosntants.dart';
import 'package:wiakum/models/product.dart';

class Products with ChangeNotifier {
  List<Product> _products = [
//    Product(
//        id: 'pro1',
//        title: 'Beurer IPL Velvet Skin Pro In White',
//        description:
//            'Get a perfectly smooth skin with Beurer IPL Velvet Skin Pro For Long-lasting Hair Removal. Made using German Technology, its simple and safe operation makes it convenient to use at home.',
//        category: 'Beauty & Personal Care',
//        subCategory: 'Body Care',
//        imgUrl:
//            'https://d192mn8i0m09h7.cloudfront.net/catalog/product/cache/63e6ff9bcc68045c81e87ed37f458421/i/p/ipl-velvet-skin-primary_2.jpg',
//        brand: 'beurer',
//        price: 2499),
//    Product(
//        id: 'pro2',
//        title: 'Beurer FC 65 Pureo Deep Clear Facial Brush',
//        description:
//            'Beurer FC 65 Pureo Deep Clear Facial Brush, crafted using German Technology, gives a flawless complexion. The facial brush cleans gently and thoroughly for a noticeably soft and radiant complexion.',
//        category: 'Beauty & Personal Care',
//        subCategory: 'Face Care',
//        imgUrl:
//            'https://d192mn8i0m09h7.cloudfront.net/catalog/product/cache/63e6ff9bcc68045c81e87ed37f458421/f/c/fc65-primary.jpg',
//        brand: 'beurer',
//        price: 299),
//    Product(
//        id: 'pro3',
//        title: 'Beurer IPL Velvet Skin Pro In White',
//        description:
//            'Get a perfectly smooth skin with Beurer IPL Velvet Skin Pro For Long-lasting Hair Removal. Made using German Technology, its simple and safe operation makes it convenient to use at home.',
//        category: 'Beauty & Personal Care',
//        subCategory: 'Body Care',
//        imgUrl:
//            'https://d192mn8i0m09h7.cloudfront.net/catalog/product/cache/63e6ff9bcc68045c81e87ed37f458421/f/c/fc65-primary.jpg',
//        brand: 'beurer',
//        price: 2499),
  ];

  List<Product> get products {
    return _products;
  }

  List<Product> get favoriteProducts{
    return _products.where((prod) => prod.isFavorite).toList();
  }
  // Future<void> favoriteProducts(String authToken, String userId)async{
  //
  //   }catch(e){}
  //
  // }

  List<Product> findByCat(String cat){
    return _products.where((prod) => prod.category==cat).toList();
  }

  List<Product> search(String text){
    return _products.where((prod) => (prod.title+prod.description+prod.category).toLowerCase().contains(text.toLowerCase())).toList();
  }

  Product findById(String id) {
    return _products.firstWhere((prod) => prod.id == id);
    notifyListeners();
  }

  Future<void> toggleFavoriteStatus(String id,String userId,String token)async{
    final product=_products.firstWhere((prod) => prod.id == id);
    final oldStatus=product.isFavorite;
    product.isFavorite=!product.isFavorite;
    notifyListeners();
    final url = 'https://wiakum-449c6.firebaseio.com/userFavorites/$userId/$id.json?auth=$token';
    try {
      await http.patch(url, body: json.encode(
          product.isFavorite
      ));
      notifyListeners();
    }catch(error){
      product.isFavorite=oldStatus;
      print('Error');
    }
    notifyListeners();
  }

  Future<void> addProduct(Product product) async{
    const url = 'https://wiakum-449c6.firebaseio.com/products.json';
     try{final response = await http
        .post(
      url,
      body: json.encode({
        'title': product.title,
        'price': product.price,
        'category': product.category,
        'description': product.description,
        'imageUrl': product.imgUrl,
      }),

    );final newProduct = Product(
         title: product.title,
         category: product.category,
         imgUrl: product.imgUrl,
         price: product.price,
         description: product.description,
         id: DateTime.now().toString());
     _products.add(newProduct);
     notifyListeners();
     }catch(error){print('Error is :'+error);
     throw error;}

  }

  Future<void> fetchProducts(String userId, String authToken)async {
    final url = 'https://wiakum-449c6.firebaseio.com/products.json';
    final urlFav = 'https://wiakum-449c6.firebaseio.com/userFavorites/$userId.json?auth=$authToken';
    try{
      final response = await http.get(url);
      final data = json.decode(response.body) as Map<String, dynamic>;
      final favoriteResponse=await http.get(urlFav);
      final favoriteData=json.decode(favoriteResponse.body);
      final List<Product> loadedProducts = [];
      data.forEach((prodId, prodData) {
      loadedProducts.add(Product(
        id: prodId,
        title: prodData['title'],
        description: prodData['description'],
        price: double.parse(prodData['price'].toString()),
        category: prodData['category'],
        imgUrl: prodData['imageUrl'],
        isFavorite: favoriteData==null?false:favoriteData[prodId]??false,
      ));
    });
    _products = loadedProducts;
    notifyListeners();
  }catch(error){print(error);}
  //print('Length:${_products.length}');
  }

}
