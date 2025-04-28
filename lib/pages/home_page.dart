import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product/api_handling_class/product.dart';
import 'package:product/get/get_state_api.dart';
import 'package:product/pages/product_detail_page.dart';

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
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/cart');
            },
            icon: const Row(
              children: [
                Text(
                  "Cart",
                  style: TextStyle(color: Colors.blue),
                ),
                Icon(
                  Icons.shopping_cart_checkout,
                  color: Colors.blue,
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () {
              getState.isLogin = false;
              Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
            },
            child: const Row(
              children: [
                Text(
                  "Logout",
                  style: TextStyle(color: Colors.blue),
                ),
                Icon(
                  Icons.logout,
                  color: Colors.blue,
                ),
              ],
            ),
          )
        ],
      ),
      backgroundColor: Colors.blueGrey,
      body: FutureBuilder<List<Product>>(
        future: getStateApi.fetchProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else {
            final products = snapshot.data!;
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.65,
              ),
              padding: const EdgeInsets.all(20),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ProductDetailPage(product: product)),
                    );
                  },
                  child: Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(10)),
                    child: Container(
                      height: double.infinity,
                      width: double.infinity,
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Center(
                            child: Image.network(
                              product.image,
                              fit: BoxFit.contain,
                              height: 100,
                              width: 100,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            maxLines: 2,
                            product.title,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text("\$${product.price.toString()}"),
                          const Text("Free Delivery"),
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      product.rating.rate.toString(),
                                      style: const TextStyle(color: Colors.white),
                                    ),
                                    const Icon(
                                      Icons.star,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text("( ${product.rating.count} )"),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
