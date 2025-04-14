import 'package:flutter/material.dart';

class ProductCell extends StatelessWidget {
  const ProductCell({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 300,
      width: 150,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.network("",height: 200,width: 150,),
          Text("Product Name"),
          Text("Product Price"),
          Text("Free Delivery"),
          Row(
            children: [
              ElevatedButton(onPressed: (){}, style:ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.green)),child: Row(children: [Text("3.8"),Icon(Icons.star,color: Colors.white,)])),
              Text("(194)")
            ],
          )
        ]
      ),
    );
  }
}
