import 'package:flutter/material.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final List<String> _categories=[
  'Tops',
  'Bottoms',
  'Shoes',
  'Bags',
  'Jewelry',
  'Accessories',
  ];
  String? _selectedCategory;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Product"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Product name"),
            SizedBox(height: 8,),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter product name"
              ),
            ),
            SizedBox(height: 16),
            Text("Quantity"),
            SizedBox(height: 8,),
            TextField(
              controller: _quantityController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter Quantity",
              ),
            ),
            SizedBox(height: 16),
        Text("Price"),
        SizedBox(height: 8),
        TextField(
          controller: _priceController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: "Enter price",
           ),
          ),
          SizedBox(height: 16),
          Text("Category"),
          SizedBox(height: 8,),
          DropdownButtonFormField<String>(
            value: _selectedCategory,
            items: _categories.map((category){
              return DropdownMenuItem<String>(
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
              border: OutlineInputBorder(),
              hintText: "Select a category",
            ),
            )
          ],
        ),
        ),
    );
  }
}