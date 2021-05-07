import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:toko_online/screens/homepage.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class EditProduct extends StatelessWidget {
  final Map product;
  EditProduct({@required this.product});
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _imageUrlController = TextEditingController();
  Future updateProduct() async {
    final response = await http.put(
        Uri.parse(
            "http://10.0.2.2:8000/api/products/" + product['id'].toString()),
        body: {
          "name": _nameController.text,
          "description": _descriptionController.text,
          "price": _priceController.text,
          "image_url": _imageUrlController.text,
        });
    print(response.body);
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product', style: TextStyle(fontSize: 20)),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                controller: _nameController..text = product['name'],
                decoration: InputDecoration(labelText: "Name"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "please enter product name";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController
                  ..text = product['description'],
                decoration: InputDecoration(labelText: "Description"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "please enter Description";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _priceController..text = product["price"],
                decoration: InputDecoration(labelText: "Price"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "please enter price";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _imageUrlController..text = product["image_url"],
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
                      updateProduct().then((value) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomePage()));
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Product Berhasil DI ubah"),
                        ));
                      });
                    }
                  },
                  child: Text("Update"))
            ],
          ),
        ),
      ),
    );
  }
}
