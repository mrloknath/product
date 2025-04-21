import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GetState extends GetxController{

  var isLogin = false;
  
  void message(BuildContext context,String message,) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

}