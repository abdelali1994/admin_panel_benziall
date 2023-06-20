// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:admin_panel_benziall/constants/constants.dart';
import 'package:admin_panel_benziall/helpers/firebase_storage_helper/firebase_storage_helper.dart';
import 'package:admin_panel_benziall/models/category_model/category_model.dart';
import 'package:admin_panel_benziall/models/product_model/product_model.dart';
import 'package:admin_panel_benziall/models/user_model/user_model.dart';
import 'package:admin_panel_benziall/provider/app_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController price = TextEditingController();
  CategoryModel? _selectedCategory;

  File? image;
  void takePicture() async {
    XFile? value = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 40);
    if (value != null) {
      setState(() {
        image = File(value.path);
      });
    }
  }

  // TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(
      context,
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Product Edit",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        children: [
          image == null
              ? CupertinoButton(
                  onPressed: () {
                    takePicture();
                  },
                  child: const CircleAvatar(
                    radius: 50,
                    child: Icon(Icons.camera_alt),
                  ),
                )
              : CupertinoButton(
                  onPressed: () {
                    takePicture();
                  },
                  child: CircleAvatar(
                    backgroundImage: FileImage(image!),
                    radius: 55,
                  ),
                ),
          const SizedBox(
            height: 12.0,
          ),
          TextFormField(
            controller: name,
            decoration: const InputDecoration(
              hintText: 'Product name',
            ),
          ),
          const SizedBox(
            height: 30.0,
          ),
          TextFormField(
            controller: description,
            maxLines: 9,
            decoration: const InputDecoration(
              hintText: 'Product description',
            ),
          ),
          const SizedBox(
            height: 30.0,
          ),
          TextFormField(
            controller: price,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              hintText: "Product price}",
            ),
          ),
          const SizedBox(
            height: 30.0,
          ),
          Theme(
            data: Theme.of(context).copyWith(canvasColor: Colors.white),
            child: DropdownButtonFormField(
              value: _selectedCategory,
              hint: const Text(
                'Select Category',
              ),
              isExpanded: true,
              onChanged: (value) {
                setState(() {
                  _selectedCategory = value;
                });
              },
              items: appProvider.getCategoriesList.map((CategoryModel val) {
                return DropdownMenuItem(
                  value: val,
                  child: Text(
                    val.name,
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(
            height: 30.0,
          ),
          ElevatedButton(
            child: const Text("Add"),
            onPressed: () async {
              if (image == null ||
                  _selectedCategory == null ||
                  name.text.isEmpty ||
                  description.text.isEmpty ||
                  price.text.isEmpty) {
                showMessage("Please fill all information");
              } else {
                appProvider.addProduct(
                  image!,
                  name.text,
                  _selectedCategory!.id,
                  price.text,
                  description.text,
                );
                showMessage("Successesfully added");
                Navigator.of(context).pop();
              }
            },
          ),
          const SizedBox(
            height: 40.0,
          )
        ],
      ),
    );
  }
}
