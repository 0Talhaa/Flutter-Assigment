import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart'; // To format current time

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
  String? _imageUrl;
  String? _imageTime; // To store the current time when image is selected

  final CollectionReference products =
      FirebaseFirestore.instance.collection('Products');
  TextEditingController urlController = TextEditingController();

  Future<void> addProduct() async {
    String title = _titleController.text.trim();
    String price = _priceController.text.trim();
    String stock = _stockController.text.trim();
    String color = _colorController.text.trim();

    if (title.isNotEmpty &&
        price.isNotEmpty &&
        stock.isNotEmpty &&
        color.isNotEmpty) {
      await products.add({
        'Title': title,
        'Price': double.tryParse(price) ?? 0.0,
        'Stock': int.tryParse(stock) ?? 0,
        'Color': color,
        'Picture': _imageUrl ?? '', // Use the URL from the user input or image
        'Timestamp':
            _imageTime ?? '', // Store the time when the image was selected
      });

      _showSuccessDialog();

      _titleController.clear();
      _priceController.clear();
      _stockController.clear();
      _colorController.clear();
      setState(() {
        _image = null;
        _imageUrl = null;
        _imageTime = null; // Reset the image and timestamp
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
            onPressed: () {
              Navigator.pop(context); // Close the dialog
              Navigator.pushReplacementNamed(
                  context, '/home'); // Navigate to main.dart
            },
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
              leading: const Icon(Icons.image),
              title: const Text('Upload from Gallery'),
              onTap: () => _pickImage(ImageSource.gallery),
            ),
            ListTile(
              leading: const Icon(Icons.link),
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
        _image = File(pickedFile.path); // Store the selected image
        _imageUrl = null; // Reset the URL if a new image is picked
        _imageTime = DateFormat('yyyy-MM-dd HH:mm:ss')
            .format(DateTime.now()); // Get current time
      });
    }
    Navigator.pop(context); // Close the bottom sheet
  }

  Future<void> _showImageUrlDialog() async {
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
                _imageUrl =
                    urlController.text; // Save the URL entered by the user
                _image = null; // Clear selected image if URL is used
                _imageTime = DateFormat('yyyy-MM-dd HH:mm:ss')
                    .format(DateTime.now()); // Set the current time
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
        prefixIcon: Icon(icon),
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
        backgroundColor: Colors.blueGrey, // Simple blue-grey color
        centerTitle: true,
        elevation: 4,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        color: Colors.grey[200], // Light grey background color
        child: Center(
          child: SingleChildScrollView(
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              elevation: 8,
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
                            color: Colors.grey, // Simple border color
                            width: 2,
                          ),
                          color: Colors.grey[300], // Light grey background
                        ),
                        child: _image == null
                            ? _imageUrl == null
                                ? const Icon(Icons.add_a_photo,
                                    size: 50, color: Colors.grey)
                                : Image.network(_imageUrl!, fit: BoxFit.cover)
                            : Image.file(_image!, fit: BoxFit.cover),
                      ),
                    ),
                    const SizedBox(height: 10),
                    if (_imageTime != null)
                      Text(
                        'Image uploaded at: $_imageTime',
                        style: const TextStyle(color: Colors.grey),
                      ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: addProduct,
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Colors.blueGrey, // Simple blue-grey color
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        elevation: 6,
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
