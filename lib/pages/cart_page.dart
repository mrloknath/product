import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../get/get_state.dart';

class CartPage extends StatefulWidget {

  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final GetState getState = Get.find<GetState>();

  @override
  Widget build(BuildContext context) {
    final cartItems = getState.cart;

    double totalPrice = cartItems.fold(0, (sum, item) => sum + item.price,);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Cart"),
      ),
      body: cartItems.isEmpty
          ? const Center(
        child: Text("Your cart is empty."),
      )
          : ListView.builder(
        itemCount: cartItems.length,
        itemBuilder: (context, index) {
          final product = cartItems[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              leading: Image.network(
                product.image,
                width: 50,
                height: 50,
                fit: BoxFit.contain,
              ),
              title: Text(product.title),
              subtitle: Text("\$${product.price.toStringAsFixed(2)}"),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  setState(() {
                    getState.cart.removeAt(index);
                    Get.snackbar("Removed", "${product.title} removed from cart",
                        snackPosition: SnackPosition.BOTTOM);
                    // Refresh UI
                    (context as Element).reassemble();
                  });

                },
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: cartItems.isNotEmpty
          ? Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          "Total: \$${totalPrice.toStringAsFixed(2)}",
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      )
          : null,
    );
  }
}
