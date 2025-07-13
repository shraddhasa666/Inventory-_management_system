import 'package:flutter/material.dart';
import 'package:inventory_mng_system/add_product_screen.dart';
import 'package:inventory_mng_system/product_list_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFF1E6),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 124, 59, 80),
        title: Text("Inventory Manager",
        style: TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.5,
          fontFamily: 'Georgia',
          color: Colors.white,
        ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Welcome to Inventory App",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Georgia',
                  color: const Color.fromARGB(255, 126, 57, 79),
                ),
                ),
              SizedBox(height: 20,),
              SizedBox(
                width: MediaQuery.of(context).size.width*0.25,
                child: ElevatedButton(
                onPressed: (){
                 Navigator.push(context, 
                 MaterialPageRoute(
                  builder: (context)=>AddProductScreen(),
                  ),
                 );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 251, 154, 124),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(12),
                  )
                ),
                child: Text("Add product")),
              ),

              SizedBox(height: 20),
              SizedBox(
                width: MediaQuery.of(context).size.width*0.25,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context, 
                      MaterialPageRoute(builder: (context) => const ProductListScreen()),
                      );
                  }, 
                  style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 251, 154, 124),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(12),
                  )
                  ),
                  child: Text("View products")),
              )
            ],
        ),
      ),
    );
  }
}