import 'dart:convert';

import 'package:http/http.dart'as http;
import 'package:flutter/material.dart';
import 'package:wiakum/models/user.dart';

class Users with ChangeNotifier{
  List<User> users=[];
  final String userId;
  final String authToken;


  Users(this.users, this.userId, this.authToken);

  Future<void> addUser(String name, String mobile, String image, String address)async{
    final url ='https://wiakum-449c6.firebaseio.com/usersProfile/$userId.json?auth=$authToken';
    try{
      final response = await http.post(url,
          body:json.encode({
            'name':name,
            'mobile':mobile,
            'address':address,
            'image':image
          })
      );
      notifyListeners();
    }catch(error){
      print(error);
      throw(error);
    }
  }
}