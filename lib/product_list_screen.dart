import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:inventory_mng_system/edit_product_screen.dart';

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
        backgroundColor: const Color.fromARGB(255, 124, 59, 80),
        title: Text("Product list",
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
          ),
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
              final timestamp = product['timestamp'] as Timestamp;
              final formattedDate = DateTime.fromMillisecondsSinceEpoch(
              timestamp.millisecondsSinceEpoch,
              );

              return Card(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  leading: Image.network(
                    product['imageUrl'],
                    height: 190,
                    width: 190,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, StackTrace) =>
                    Icon(Icons.image_not_supported, size: 50),
                  ),
                  title: Text(product['name']),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${product['category']} • ₹${product['price']}"),
                      Text(
                        "Added on: ${formattedDate.day}/${formattedDate.month}/${formattedDate.year}"
                        "${formattedDate.hour}:${formattedDate.minute.toString().padLeft(2,'0')}",
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                      if(product['quantity']<5)
                      Text("Low stock: Only ${product['quantity']} left",
                      style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),

                  trailing: IconButton(
                    onPressed: (){
                      _deleteProduct(products[index].id);
                    }, 
                    icon: Icon(Icons.delete, color: Colors.red,)),
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context)=> EditProductScreen(
                            productId: products[index].id,
                            productData: product,
                          ),
                          ),
                        );
                    },
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