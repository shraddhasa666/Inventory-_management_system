import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditProductScreen extends StatefulWidget {
  final String productId;
  final Map <String , dynamic> productData;
  
  const EditProductScreen({
    super.key,
    required this.productData,
    required this.productId,
    });

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
late TextEditingController _nameController;
late TextEditingController _quantityController;
late TextEditingController _priceController;
String? _selectedCategory;

final List<String> _categories=[
  'Tops',
  'Bottoms',
  'Shoes',
  'Bags',
  'Jewelry',
  'Accessories',
  ];


  @override
  void initState(){
    super.initState();
    _nameController = TextEditingController(text: widget.productData['name']);
    _quantityController = TextEditingController(text: widget.productData['quantity'].toString());
    _priceController = TextEditingController(text: widget.productData['price'].toString());
    _selectedCategory = widget.productData['category'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit product"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: "Product name",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 12),
            TextField(
              controller: _quantityController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Quantity",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 12),
            TextField(
              controller: _priceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "price",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 12),
            DropdownButtonFormField <String> (
              value: _selectedCategory,
              items: _categories.map((category){
                return DropdownMenuItem <String> (
                  value: category,
                  child: Text(category),
                  );
              }).toList(),
               onChanged: (value){
                setState(() {
                  _selectedCategory = value;
                });
               },
               decoration: InputDecoration(
                labelText: "Category",
                border: OutlineInputBorder(),
               ),
               ),
               SizedBox(height: 24),
               ElevatedButton(
                onPressed: _updateProduct, 
                child: Text("Update product"),
                )
          ],
        ),
        ),
    );
  }
  void _updateProduct() async {
    try{
      await FirebaseFirestore.instance.collection('products').doc(widget.productId).update({
        'name': _nameController.text.trim(),
        'quantity': int.parse(_quantityController.text.trim()),
        'price': double.parse(_priceController.text.trim()),
        'category': _selectedCategory,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Product updated sccessfully")),
        );
        Navigator.pop(context);
    }
    catch(e){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to update product: $e")),
        );
    }
  }
}