// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:admin_panel_benziall/constants/constants.dart';
import 'package:admin_panel_benziall/helpers/firebase_storage_helper/firebase_storage_helper.dart';
import 'package:admin_panel_benziall/models/user_model/user_model.dart';
import 'package:admin_panel_benziall/provider/app_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class EditUser extends StatefulWidget {
  final UserModel userModel;
  final int index;
  const EditUser({super.key, required this.userModel, required this.index});

  @override
  State<EditUser> createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  TextEditingController name = TextEditingController();

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
          "User Edit",
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
                  child: CircleAvatar(
                      radius: 50,
                      child: image == null
                          ? const Icon(Icons.camera_alt)
                          : Image.file(image!)),
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
              hintText: widget.userModel.name,
            ),
          ),
          const SizedBox(
            height: 30.0,
          ),
          ElevatedButton(
            child: const Text("Update"),
            onPressed: () async {
              if (image == null && name.text.isEmpty) {
                Navigator.of(context).pop();
              } else if (image != null) {
                String imageUrl = await FirebaseStorageHelper.instance
                    .uploadUserImage(widget.userModel.id, image!);
                UserModel userModel = widget.userModel.copyWith(
                  image: imageUrl,
                  name: name.text.isEmpty ? null : name.text,
                );
                appProvider.updateUserList(widget.index, userModel);
                showMessage("Successesfully Updated");
                Navigator.of(context).pop();
              } else {
                UserModel userModel = widget.userModel.copyWith(
                  image: image,
                  name: name.text.isEmpty ? null : name.text,
                );
                appProvider.updateUserList(widget.index, userModel);
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
