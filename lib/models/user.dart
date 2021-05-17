import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class User with ChangeNotifier {
  final String userId;
  final String authToken;
  String address;
  String city;
  String imageUrl;
  String mobile;
  String name;


  User({this.userId,this.city, this.authToken, this.address, this.imageUrl, this.mobile,
      this.name});
  User _user;

  User get user{
    return  _user;
  }
  Future<void>updateUserPhoto(String image)async{
    final url = 'https://wiakum-449c6.firebaseio.com/userProfile/$userId.json?auth=$authToken';
    try{
      final result = http.patch(
          url,
          body:json.encode({
            'image':image,
          })
      );
      _user.imageUrl=image;
      notifyListeners();
    }catch(error){
      print(error);
      throw(error);
    }
  }

  Future<void> addUserName({String userName}) async {
    final url = 'https://wiakum-449c6.firebaseio.com/userProfile/$userId.json?auth=$authToken';
    try{
      final result = http.patch(
          url,
          body:json.encode({
            'name':userName,
          })
      );
      _user.name=userName;
      notifyListeners();
    }catch(error){
      print(error);
      throw(error);
    }
  }
  Future<void>updateUserData({String name, String mobile, String address, String city}){
    final url = 'https://wiakum-449c6.firebaseio.com/userProfile/$userId.json?auth=$authToken';
    try{
      final result = http.patch(
          url,
          body:json.encode({
            'name':name,
            'mobile':mobile,
            'address':address,
            'city':city
          })
      );
      _user.name=name;
      _user.mobile=mobile;
      _user.address=address;
      _user.city=city;
      notifyListeners();
    }catch(error){
      print(error);
      throw(error);
    }
  }


  Future<void> fetchUserData()async{
    final url='https://wiakum-449c6.firebaseio.com/userProfile/$userId.json?auth=$authToken';
    final response=await http.get(url);
    final data= json.decode(response.body) as Map<String,dynamic>;
    User currentUser=User(
        name: data['name'],
        mobile: data['mobile'],
        imageUrl: data['image'],
        address: data['address'],
        city: data['city']
    );
    _user=currentUser;
    notifyListeners();
  }
}