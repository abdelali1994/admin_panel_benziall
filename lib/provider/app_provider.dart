// ignore_for_file: use_build_context_synchronously

import 'package:admin_panel_benziall/constants/constants.dart';
import 'package:admin_panel_benziall/helpers/firebase_firestore_helper/firebase_firestore.dart';
import 'package:admin_panel_benziall/models/category_model/category_model.dart';
import 'package:admin_panel_benziall/models/user_model/user_model.dart';
import 'package:flutter/material.dart';

class AppProvider with ChangeNotifier {
  List<UserModel> _userList = [];
  List<CategoryModel> _categoriesList = [];

  Future<void> getUserListFun() async {
    _userList = await FirebaseFirestoreHelper.instance.getUserList();
  }

  Future<void> getCategoriesListFun() async {
    _categoriesList = await FirebaseFirestoreHelper.instance.getCategories();
  }

  Future<void> deleteUserFromFirebase(UserModel userModel) async {
    notifyListeners();
    String value =
        await FirebaseFirestoreHelper.instance.deleteSingleUser(userModel.id);
    if (value == "Successesfully Deleted") {
      _userList.remove(userModel);
      showMessage("Successesfully Deleted");
    }

    notifyListeners();
  }

  List<UserModel> get getUserList => _userList;
  List<CategoryModel> get getCategoriesList => _categoriesList;

  Future<void> callBackFunction() async {
    await getUserListFun();
    await getCategoriesListFun();
  }

  void updateUserList(int index,UserModel userModel) async {
    await FirebaseFirestoreHelper.instance.updateUser(userModel);
    // int index = _userList.indexOf(userModel);
    _userList[index] = userModel;
    notifyListeners();
  }
}
