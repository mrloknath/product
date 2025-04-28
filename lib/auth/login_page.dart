import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product/get/get_state.dart';

import '../get/get_state_api.dart';


class LoginPage extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginPage({super.key});



  @override
  Widget build(BuildContext context) {

    final GetState getState = Get.put(GetState());
    final GetStateApi getStateApi = Get.put(GetStateApi());

    return Scaffold(
      //appBar: AppBar(title: Text('Login')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Login',style: TextStyle(fontSize: 50),),
              SizedBox(height: 30),
              TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  labelText: 'Username',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.grey[100],
                  contentPadding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 16.0),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  labelText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.grey[100],
                  contentPadding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 16.0),
                ),
                obscureText: true,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  String username = usernameController.text.trim();
                  String password = passwordController.text.trim();

                  if (username.isEmpty || password.isEmpty) {
                    getState.message(context,'Please fill all fields');
                  } else {
                     getStateApi.login( context,username, password);
                     if(getState.isLogin){
                       Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
                     }
                  }

                },

                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  backgroundColor: Colors.indigo,
                ),
                child: Text(
                  'Login',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
              SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don\'t have an account?',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/signup');
                    },
                    child: Text(
                      'Sign up',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
