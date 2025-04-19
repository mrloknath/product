import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:product/api_handling_class/product.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse('https://fakestoreapi.com/products'));

    if (response.statusCode == 200) {
      List jsonData = json.decode(response.body);
      return jsonData.map((item) => Product.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load products');
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product"),
        actions: [
          TextButton(onPressed: (){
            //GetStorage().remove("userDetails");
            //GetStorage().write("userDetails", {"loggedIn": "No"});
            Map<String, dynamic> userDetails = GetStorage().read("userDetails") ?? {};
            userDetails["loggedIn"] = "No";
            GetStorage().write("userDetails", userDetails);
            print(GetStorage().read("userDetails"));
            Navigator.pushReplacementNamed(context, '/');
            },
            child: const Row(children: [Text("Logout",style: TextStyle(color: Colors.blue),), Icon(Icons.logout,color: Colors.blue,)],),  )
        ],
        //centerTitle: true,
      ),


      body: FutureBuilder<List<Product>>(
        future: fetchProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else {
            final products = snapshot.data!;
            return GridView.count(
              crossAxisCount: 2,
              padding: const EdgeInsets.all(20),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              children: products.map((product) {
                return Card(
                  elevation: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: Center(child: Image.network(product.image, fit: BoxFit.contain,)),),
                      Text(product.title,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text("\$${product.price.toString()}"),
                      Text("Free Delivery"),
                      Row(
                        children: [
                          ElevatedButton(onPressed: (){}, style:ButtonStyle(backgroundColor: WidgetStateProperty.all(Colors.green)),child: Row(spacing: 5,children: [Text(product.rating.rate.toString()),Icon(Icons.star,color: Colors.white,)])),
                          Text("(${product.rating.count})")
                        ],
                      )

                    ],
                  ),
                );
              }).toList(),
            );
          }
        },
      ),
    );
  }
}
