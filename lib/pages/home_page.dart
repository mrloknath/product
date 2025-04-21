import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product/api_handling_class/product.dart';
import 'package:product/get/get_state_api.dart';
import 'package:product/pages/product_page.dart';

import '../get/get_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  @override
  Widget build(BuildContext context) {

    final GetState getState = Get.put(GetState());
    final GetStateApi getStateApi = Get.put(GetStateApi());

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Product"),
        actions: [
          TextButton(onPressed: (){
            getState.isLogin = false;
            Navigator.of(context).pushNamedAndRemoveUntil('/login',(route) => false);
            },
            child: const Row(children: [Text("Logout",style: TextStyle(color: Colors.blue),), Icon(Icons.logout,color: Colors.blue,)],),  )
        ],
        //centerTitle: true,
      ),


      body: FutureBuilder<List<Product>>(
        future: getStateApi.fetchProducts(),
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
                return InkWell(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductPage(product: product)));
                  },
                  child: Card(
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
