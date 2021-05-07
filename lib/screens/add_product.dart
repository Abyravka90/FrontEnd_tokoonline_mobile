import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:toko_online/screens/homepage.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class AddProduct extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _imageUrlController = TextEditingController();
  Future saveProduct() async {
    final response =
        await http.post(Uri.parse("http://10.0.2.2:8000/api/products"), body: {
      "name": _nameController.text,
      "description": _descriptionController.text,
      "price": _priceController.text,
      "image_url": _imageUrlController.text,
    });
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product', style: TextStyle(fontSize: 20)),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: "Name"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "please enter product name";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: "Description"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "please enter Description";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _priceController,
                decoration: InputDecoration(labelText: "Price"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "please enter price";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _imageUrlController,
                decoration: InputDecoration(labelText: "Image_url"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "please enter Image Url Value";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      saveProduct().then((value) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomePage()));
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Product Berhasil Di tambahkan!"),
                        ));
                      });
                    }
                  },
                  child: Text("Save"))
            ],
          ),
        ),
      ),
    );
  }
}
