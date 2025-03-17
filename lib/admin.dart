import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminPanel extends StatefulWidget {
  @override
  _AdminPanelState createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  final CollectionReference products = FirebaseFirestore.instance.collection('Products');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Panel', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.deepPurple,
      ),
      body: StreamBuilder(
        stream: products.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No products available'));
          }

          return ListView(
            padding: EdgeInsets.all(10),
            children: snapshot.data!.docs.map((doc) {
              return Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(vertical: 8),
                child: ListTile(
                  leading: Image.network(doc['Picture'], width: 50, height: 50, fit: BoxFit.cover),
                  title: Text(doc['Title'], style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text('Price: \$${doc['Price']} | Color: ${doc['Color']} | Stock: ${doc['Stock']}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit, color: Colors.blue),
                        onPressed: () => _editProduct(doc),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _deleteProduct(doc.id),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addProduct,
        child: Icon(Icons.add, color: Colors.white),
        backgroundColor: Colors.deepPurple,
      ),
    );
  }

  void _addProduct() {
    _showProductDialog();
  }

  void _editProduct(DocumentSnapshot doc) {
    _showProductDialog(doc);
  }

  void _deleteProduct(String id) async {
    await products.doc(id).delete();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Product deleted')));
  }

  void _showProductDialog([DocumentSnapshot? doc]) {
    final _titleController = TextEditingController(text: doc != null ? doc['Title'] : '');
    final _pictureController = TextEditingController(text: doc != null ? doc['Picture'] : '');
    final _priceController = TextEditingController(text: doc != null ? doc['Price'].toString() : '');
    final _colorController = TextEditingController(text: doc != null ? doc['Color'] : '');
    final _stockController = TextEditingController(text: doc != null ? doc['Stock'].toString() : '');

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(doc == null ? 'Add Product' : 'Edit Product'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(controller: _titleController, decoration: InputDecoration(labelText: 'Title')),
                TextField(controller: _pictureController, decoration: InputDecoration(labelText: 'Picture URL')),
                TextField(controller: _priceController, decoration: InputDecoration(labelText: 'Price'), keyboardType: TextInputType.number),
                TextField(controller: _colorController, decoration: InputDecoration(labelText: 'Color')),
                TextField(controller: _stockController, decoration: InputDecoration(labelText: 'Stock'), keyboardType: TextInputType.number),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (doc == null) {
                  await products.add({
                    'Title': _titleController.text,
                    'Picture': _pictureController.text,
                    'Price': double.parse(_priceController.text),
                    'Color': _colorController.text,
                    'Stock': int.parse(_stockController.text),
                  });
                } else {
                  await products.doc(doc.id).update({
                    'Title': _titleController.text,
                    'Picture': _pictureController.text,
                    'Price': double.parse(_priceController.text),
                    'Color': _colorController.text,
                    'Stock': int.parse(_stockController.text),
                  });
                }
                Navigator.pop(context);
              },
              child: Text(doc == null ? 'Add' : 'Update'),
            ),
          ],
        );
      },
    );
  }
}