import 'package:flutter/material.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Inventory app"),
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

              },
              child: Text("Add product"))
            ],
          ),
       ),
      )
    );
  }
}