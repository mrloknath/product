import 'package:flutter/material.dart';

import '../api_handling_class/product.dart';

class ProductPage extends StatelessWidget {
  final Product product;
  const ProductPage({super.key,required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
        centerTitle: true,
      ),

      body: InkWell(
        onDoubleTap: (){
          showModalBottomSheet<void>(
              context: context,
              builder: (BuildContext context) {
            return Container(
              height: 200,
              color: Colors.amber,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Text('Modal BottomSheet'),
                    ElevatedButton(
                      child: const Text('Close BottomSheet'),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
            );
          },
          );
        },
        child: Center(child: Text(product.title)),
      ),

      // bottomNavigationBar: Row(
      //     children: [
      //
      //     ]
      // ),

    );
  }

}
