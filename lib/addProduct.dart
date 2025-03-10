import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _stockController = TextEditingController();
  final TextEditingController _colorController = TextEditingController();
  File? _image;

  final CollectionReference products =
      FirebaseFirestore.instance.collection('Products');

  Future<void> addProduct() async {
    String title = _titleController.text.trim();
    String price = _priceController.text.trim();
    String stock = _stockController.text.trim();
    String color = _colorController.text.trim();

    if (title.isNotEmpty &&
        price.isNotEmpty &&
        _image != null &&
        stock.isNotEmpty &&
        color.isNotEmpty) {
      await products.add({
        'Title': title,
        'Price': double.tryParse(price) ?? 0.0,
        'Stock': int.tryParse(stock) ?? 0,
        'Color': color,
        'Like': false,
        'Picture': 'Uploaded Image Placeholder',
      });

      _showSuccessDialog();

      _titleController.clear();
      _priceController.clear();
      _stockController.clear();
      _colorController.clear();
      setState(() {
        _image = null;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('⚠️ Please fill in all fields and select an image')),
      );
    }
  }

  Future<void> _showSuccessDialog() async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('🎉 Success!'),
        content: const Text('Your product has been added successfully.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<void> _showImageSourceDialog() async {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.image,
                  color: Color.fromARGB(255, 241, 217, 145)),
              title: const Text('Upload from Gallery'),
              onTap: () => _pickImage(ImageSource.gallery),
            ),
            ListTile(
              leading: const Icon(Icons.link,
                  color: Color.fromARGB(255, 240, 216, 143)),
              title: const Text('Use Online Image URL'),
              onTap: () {
                Navigator.pop(context);
                _showImageUrlDialog();
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
    Navigator.pop(context);
  }

  Future<void> _showImageUrlDialog() async {
    TextEditingController urlController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Enter Image URL'),
        content: TextField(
          controller: urlController,
          decoration: const InputDecoration(hintText: 'Paste image URL here'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _image = null;
              });
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller, String label, IconData icon,
      {bool isNumber = false}) {
    return TextField(
      controller: controller,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: const Color.fromARGB(255, 241, 216, 140)),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Product',
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold, fontSize: 22, color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 243, 214, 125),
        centerTitle: true,
        elevation: 8,
        shadowColor: const Color.fromARGB(255, 241, 213, 126).withOpacity(0.5),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color.fromARGB(255, 245, 219, 143), Colors.brown],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              elevation: 15,
              shadowColor: Colors.black45,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildTextField(
                        _titleController, 'Product Title', Icons.title),
                    const SizedBox(height: 15),
                    _buildTextField(
                        _priceController, 'Product Price', Icons.attach_money,
                        isNumber: true),
                    const SizedBox(height: 15),
                    _buildTextField(
                        _stockController, 'Stock Quantity', Icons.store,
                        isNumber: true),
                    const SizedBox(height: 15),
                    _buildTextField(
                        _colorController, 'Color', Icons.color_lens),
                    const SizedBox(height: 15),
                    GestureDetector(
                      onTap: _showImageSourceDialog,
                      child: Container(
                        height: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                              color: const Color.fromARGB(255, 243, 217, 137),
                              width: 2),
                          color: Colors.grey[200],
                        ),
                        child: _image == null
                            ? const Icon(Icons.add_a_photo,
                                size: 50, color: Colors.amber)
                            : Image.file(_image!, fit: BoxFit.cover),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: addProduct,
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 233, 205, 122),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        elevation: 12,
                        shadowColor: const Color.fromARGB(255, 236, 211, 135)
                            .withOpacity(0.6),
                      ),
                      child: const Text(
                        '➕ Add Product',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
