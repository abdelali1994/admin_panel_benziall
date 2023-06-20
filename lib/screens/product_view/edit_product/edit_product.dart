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

class EditProdut extends StatefulWidget {
  final ProductModel productModel;
  final int index;
  const EditProdut(
      {super.key, required this.productModel, required this.index});

  @override
  State<EditProdut> createState() => _EditProdutState();
}

class _EditProdutState extends State<EditProdut> {
  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController price = TextEditingController();

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
              ? widget.productModel.image.isNotEmpty
                  ? CupertinoButton(
                      onPressed: () {
                        takePicture();
                      },
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                          widget.productModel.image,
                        ),
                        radius: 55,
                      ),
                    )
                  : CupertinoButton(
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
            decoration: InputDecoration(
              hintText: widget.productModel.name,
            ),
          ),
          const SizedBox(
            height: 30.0,
          ),
          TextFormField(
            controller: description,
            maxLines: 9,
            decoration: InputDecoration(
              hintText: widget.productModel.description,
            ),
          ),
          const SizedBox(
            height: 30.0,
          ),
          TextFormField(
            controller: price,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: "\$${widget.productModel.price}",
            ),
          ),
          const SizedBox(
            height: 30.0,
          ),
          ElevatedButton(
            child: const Text("Update"),
            onPressed: () async {
              if (image == null &&
                  name.text.isEmpty &&
                  description.text.isEmpty &&
                  price.text.isEmpty) {
                Navigator.of(context).pop();
              } else if (image != null) {
                String imageUrl = await FirebaseStorageHelper.instance
                    .uploadUserImage(widget.productModel.id, image!);
                ProductModel productModel = widget.productModel.copyWith(
                  description:
                      description.text.isEmpty ? null : description.text,
                  name: name.text.isEmpty ? null : name.text,
                  image: imageUrl,
                  price: price.text.isEmpty ? null : price.text,
                );
                appProvider.updateProductList(widget.index, productModel);
                showMessage("Successesfully Updated");
                Navigator.of(context).pop();
              } else {
                ProductModel productModel = widget.productModel.copyWith(
                  description:
                      description.text.isEmpty ? null : description.text,
                  name: name.text.isEmpty ? null : name.text,
                  price: price.text.isEmpty ? null : price.text,
                );
                appProvider.updateProductList(widget.index, productModel);
                showMessage("Successesfully Updated");
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      ),
    );
  }
}
