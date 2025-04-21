import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../api_handling_class/product.dart';
import '../api_handling_class/user.dart';
import 'get_state.dart';

class GetStateApi extends GetxController{
  get getState => null;

// GET : fetch user count
  Future<int> fetchUserCount() async {
    final response = await http.get(Uri.parse('https://fakestoreapi.com/users'));

    if (response.statusCode == 200) {
      List<dynamic> users = jsonDecode(response.body);
      return users.length;
    } else {
      throw Exception('Failed to load users');
    }
  }

// POST : add user
  Future<bool> addUser(Users user) async {
    final count = await fetchUserCount();
    user.id = count + 1;

    final response = await http.post(Uri.parse('https://fakestoreapi.com/users'),
      headers: { 'Content-Type': 'application/json'},
      body: jsonEncode(user.toJson()),
    );
   GetStorage().write("userDetails", user.toJson());

    return (response.statusCode == 200 || response.statusCode == 201)?true:false;
  }

// GET : fetch all products
  Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse('https://fakestoreapi.com/products'));

    if (response.statusCode == 200) {
      List jsonData = json.decode(response.body);
      return jsonData.map((item) => Product.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load products');
    }

  }

// POST : login with username and password
  void login(BuildContext context,String username,String password) async{

    final GetState getState = Get.put(GetState());

    final response = await http.post(
      Uri.parse('https://fakestoreapi.com/auth/login'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'username': username,
        'password': password,
      }),
    );

    if(response.statusCode == 200 ||GetStorage().read("userDetails")["username"]==username
        && GetStorage().read("userDetails")["password"]==password){
      if (!context.mounted) return;
      getState.isLogin = true;
      getState.message(context,'Login Successful');
      Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
      //return jsonDecode(response.body);
    }

  }






}