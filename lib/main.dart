import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:product/auth/login_page.dart';
import 'package:product/auth/signup_page.dart';
import 'package:product/pages/cart_page.dart';

import 'get/get_state.dart';
import 'pages/home_page.dart';

void main() async{
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {

    final GetState getState = Get.put(GetState());

    return Center(
      child: SizedBox(
        width: 400,
        child: GetMaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          home: getState.isLogin ? HomePage() : LoginPage(),
          // initialRoute: LoginPage(),
          routes: {
            '/login': (context) => LoginPage(),
            '/signup': (context) => SignupPage(),
            '/home': (context) => HomePage(),
            '/cart': (context) => CartPage(),
          },

        ),
      ),
    );
  }
}

