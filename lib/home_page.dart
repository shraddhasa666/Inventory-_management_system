import 'package:flutter/material.dart';
import 'package:inventory_mng_system/add_product_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("INventory app"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Welcome to inventory app"),
              SizedBox(height: 20,),
              ElevatedButton(
              onPressed: (){
               Navigator.push(context, 
               MaterialPageRoute(
                builder: (context)=>AddProductScreen(),
                ),
               );
              },
              child: Text("Add product"))
            ],
        ),
      ),
    );
  }
}