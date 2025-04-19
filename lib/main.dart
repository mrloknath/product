import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:product/pages/login_page.dart';
import 'package:product/pages/signup_page.dart';

import 'pages/home_page.dart';

void main() async{
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  String checkLogin() {
    print(GetStorage().read("userDetails"));
    if (GetStorage().read("userDetails") != null && GetStorage().read("userDetails")["loggedIn"] == "Yes") {
      return '/home';
    } else {
      return '/';
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      initialRoute: checkLogin(),
      routes: {
        '/': (context) => LoginPage(),
        '/signup': (context) => SignupPage(),
        '/home': (context) => HomePage(),
      },

    );
  }
}

