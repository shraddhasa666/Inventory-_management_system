import 'package:flutter/material.dart';
import 'package:inventory_mng_system/home_page.dart';
import 'package:firebase_core/firebase_core.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyBCMXZWDyghMHybVcBFG3c3dCJmmcevXMo",
      authDomain: "inventorymanagement-a93f7.firebaseapp.com",
      projectId: "inventorymanagement-a93f7",
      storageBucket: "inventorymanagement-a93f7.appspot.com",
      messagingSenderId: "387845071992",
      appId: "1:387845071992:web:fa7533871c5369677b798d",
    ),
  );
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Inventory App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}