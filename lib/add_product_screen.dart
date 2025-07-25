import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';



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
  XFile? _pickedImage;
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 124, 59, 80),
        title: Text("Add Product",
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Product name"),
            SizedBox(height: 6,),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12), // 👈 Shrinks height
                hintText: "Enter product name",
                hintStyle: TextStyle(fontSize: 14),
              ),
              style: TextStyle(fontSize: 14),
            ),

            SizedBox(height: 16),
            Text("Quantity"),
            SizedBox(height: 6,),
            TextField(
              controller: _quantityController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                border: OutlineInputBorder(),
                hintText: "Enter Quantity",
                hintStyle: TextStyle(fontSize: 14),
              ),
              style: TextStyle(fontSize: 14),
            ),

            SizedBox(height: 16),
            Text("Price"),
            SizedBox(height: 8),
            TextField(
              controller: _priceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12), // 👈 Shrinks height
                hintStyle: TextStyle(fontSize: 14),               
                hintText: "Enter price",
               ),
               style: TextStyle(fontSize: 14),
              ),

          SizedBox(height: 16),
          Text("Category"),
          SizedBox(height: 6,),
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
                contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12), // 👈 Shrinks height
                hintStyle: TextStyle(fontSize: 14),               
                hintText: "Enter price",
               ),
               style: TextStyle(fontSize: 14),
            ),

          SizedBox(height: 16),
          Text("Product Image"),
          SizedBox(height: 8),
          SizedBox(
            width: MediaQuery.of(context).size.width*0.25,
            child: ElevatedButton(
              onPressed: () async {
                final picked=await _picker.pickImage(
                  source: ImageSource.gallery);
                  if(picked != null) {
                    setState(() {
                      _pickedImage=picked;
                    });
                  }
              }, 
              child: Text("Pick image"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrange[200],
                foregroundColor: Colors.white,
              ),
              ),
          ),
            if(_pickedImage != null)
             Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Image.network(_pickedImage!.path, height: 100,),
             ),

             SizedBox(height: 24),
             Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width*0.25,
                child: ElevatedButton(
                  onPressed: _saveProduct, 
                  child: Text("Save product"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrange[200],
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 14),
                    textStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      )
                  ),),
              ),
             )
          ],
        ),
        ),
    );
  }
  void _saveProduct() async{
    if(_nameController.text.isEmpty || _quantityController.text.isEmpty || _priceController.text.isEmpty ||
    _selectedCategory == null){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please fill all fields")),
        );
        return;
    }
    String imageUrl = "https://via.placeholder.com/150";

    try{
      await FirebaseFirestore.instance.collection('products').add({
        'name': _nameController.text.trim(),
        'quantity': int.parse(_quantityController.text.trim()),
        'price': double.parse(_priceController.text.trim()),
        'category' : _selectedCategory,
        'imageUrl' : imageUrl,
        'timestamp' : Timestamp.now(),
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Product saved successfully")),
        );

        _nameController.clear();
        _quantityController.clear();
        _priceController.clear();
        setState(() {
          _selectedCategory = null;
          _pickedImage = null;
        });
    } catch(e){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error saving product : $e")),
        );
    }

  }
}