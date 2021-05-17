import 'package:flutter/foundation.dart';
import 'package:wiakum/models/category.dart';

class Categories with ChangeNotifier{
  List<MainCategory> _categories=[
    MainCategory(id: 'cat1',title: 'Beauty & Personal Care', image: 'https://d192mn8i0m09h7.cloudfront.net/wysiwyg/magebig/layout04/personalcare-new.png',),
    MainCategory(id: 'cat2',title: 'Wellbeing', image: 'https://d192mn8i0m09h7.cloudfront.net/wysiwyg/magebig/layout04/wellbeing-new.png',),
    MainCategory(id: 'cat3',title: 'Health Devices', image: 'https://d192mn8i0m09h7.cloudfront.net/wysiwyg/magebig/layout04/healthdevices-new.png',),
    MainCategory(id: 'cat4', title: 'Functional Food', image: 'https://d192mn8i0m09h7.cloudfront.net/wysiwyg/magebig/layout04/Category_Manuka_20200723.jpg',)
  ];

  List<MainCategory> get categories{
    return [..._categories];
  }

  


}