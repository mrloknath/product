import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product/api_handling_class/product.dart';
import '../get/get_state.dart';

class ProductDetailPage extends StatefulWidget {
  final Product product;

  const ProductDetailPage({super.key, required this.product});

  @override
  ProductDetailPageState createState() => ProductDetailPageState();
}

class ProductDetailPageState extends State<ProductDetailPage> {
  final GetState getState = Get.put(GetState()); // Moved here

  // Add to cart function
  void addToCart(Product product) {
    setState(() {
      getState.cart.add(product);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${product.title} added to cart')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.title),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.network(
                  widget.product.image,
                  fit: BoxFit.contain,
                  height: 400,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                widget.product.title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '\$${widget.product.price.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.star, color: Colors.orangeAccent),
                  Text(
                    widget.product.rating.rate.toString(),
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '(${widget.product.rating.count} reviews)',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                'Product ID: ${widget.product.id}',
                style: const TextStyle(fontSize: 16),
              ),
              SizedBox(height: 50)
            ],
          ),
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                addToCart(widget.product);
              },
              child: Container(
                height: 50,
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 12),
                color: Colors.blue,
                child: const Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.shopping_cart, color: Colors.white),
                      SizedBox(width: 8),
                      Text("Add to Cart", style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Proceed to Checkout!')),
                );
              },
              child: Container(
                height: 50,
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 12),
                color: Colors.green,
                child: const Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.payment, color: Colors.white),
                      SizedBox(width: 8),
                      Text("Buy Now", style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),


    );
  }
}
