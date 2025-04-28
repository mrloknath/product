import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../api_handling_class/product.dart';

class GetState extends GetxController{

  var isLogin = false;
  List<Product> cart = [];
  
  void message(BuildContext context,String message,) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

}