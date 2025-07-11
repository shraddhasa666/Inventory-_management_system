import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product list"),
      ),

      body: StreamBuilder <QuerySnapshot> (
        stream: FirebaseFirestore.instance.collection('products').orderBy('timestamp', descending: true).snapshots(), 
        builder: (context, snapshot) {
          if(snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'));
          }
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator());
          }
          final products=snapshot.data!.docs;
          if(products.isEmpty){
            return Center(
              child: Text("No products added yet"));
          }
          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index){
              final product =products[index].data() as Map<String , dynamic>;

              return Card(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  leading: Image.network(
                    product['imageUrl'],
                    height: 50,
                    width: 50,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, StackTrace) =>
                    Icon(Icons.image_not_supported),
                  ),
                  title: Text(product['name']),
                  subtitle: Text("${product['category']} • ₹${product['price']}"),

                  trailing: IconButton(
                    onPressed: (){
                      _deleteProduct(products[index].id);
                    }, 
                    icon: Icon(Icons.delete, color: Colors.red,)),
                ),
              );
            },
            );
        }
        ),
    );
  }
  void _deleteProduct(String id) async {
    try{
      await FirebaseFirestore.instance.collection('products').doc(id).delete();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Product deleted")),
        );
    } catch (e){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to delete product: $e")),
        );
    }
  }
}