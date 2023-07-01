// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:admin_panel_benziall/constants/constants.dart';
import 'package:admin_panel_benziall/helpers/firebase_storage_helper/firebase_storage_helper.dart';
import 'package:admin_panel_benziall/models/category_model/category_model.dart';
import 'package:admin_panel_benziall/models/order_model/order_model.dart';
import 'package:admin_panel_benziall/models/product_model/product_model.dart';
import 'package:admin_panel_benziall/models/user_model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
// import 'package:firebase_admin/firebase_admin.dart';

class FirebaseFirestoreHelper {
  static FirebaseFirestoreHelper instance = FirebaseFirestoreHelper();
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<List<UserModel>> getUserList() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await _firebaseFirestore.collection("users").get();
    return querySnapshot.docs.map((e) => UserModel.fromJson(e.data())).toList();
  }

  Future<List<CategoryModel>> getCategories() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firebaseFirestore.collection("categories").get();
      List<CategoryModel> categoriesList = querySnapshot.docs
          .map((e) => CategoryModel.fromJson(e.data()))
          .toList();
      return categoriesList;
    } catch (e) {
      showMessage(e.toString());
      return [];
    }
  }

  Future<String> deleteSingleUser(String id) async {
    try {
      await _firebaseFirestore.collection("users").doc(id).delete();
      return "Successesfully Deleted";
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> updateUser(UserModel userModel) async {
    try {
      await _firebaseFirestore
          .collection("users")
          .doc(userModel.id)
          .update(userModel.toJson());
    } catch (e) {}
  }

  Future<String> deleteSingleCategory(String id) async {
    try {
      await _firebaseFirestore.collection("categories").doc(id).delete();
      return "Successesfully Deleted";
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> updateSingleCategory(CategoryModel categoryModel) async {
    try {
      await _firebaseFirestore
          .collection("categories")
          .doc(categoryModel.id)
          .update(categoryModel.toJson());
    } catch (e) {}
  }

  Future<CategoryModel> addSingleCategory(File image, String name) async {
    DocumentReference reference =
        _firebaseFirestore.collection("categories").doc();
    String imageUrl = await FirebaseStorageHelper.instance
        .uploadUserImage(reference.id, image);
    CategoryModel addCategory =
        CategoryModel(id: reference.id, image: imageUrl, name: name);
    await reference.set(
      addCategory.toJson(),
    );
    return addCategory;
  }

//////////products/////
  Future<List<ProductModel>> getProducts() async {
    QuerySnapshot<Map<String, dynamic>> querySnashot =
        await _firebaseFirestore.collectionGroup("products").get();
    List<ProductModel> productList =
        querySnashot.docs.map((e) => ProductModel.fromJson(e.data())).toList();
    return productList;
  }

  Future<String> deleteProduct(String categoryId, String productId) async {
    try {
      await _firebaseFirestore
          .collection("categories")
          .doc(categoryId)
          .collection("products")
          .doc(productId)
          .delete();
      return "Successesfully Deleted";
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> updateSingleProduct(ProductModel productModel) async {
    try {
      await _firebaseFirestore
          .collection("categories")
          .doc(productModel.categoryId)
          .collection("products")
          .doc(productModel.id)
          .update(productModel.toJson());
    } catch (e) {}
  }

  Future<ProductModel> addSingleProduct(
    File image,
    String name,
    String categoryId,
    String price,
    String description,
    // String id,
  ) async {
    DocumentReference reference = _firebaseFirestore
        .collection("categories")
        .doc(categoryId)
        .collection("products")
        .doc();

    String imageUrl = await FirebaseStorageHelper.instance
        .uploadUserImage(reference.id, image);
    ProductModel addProduct = ProductModel(
      id: reference.id,
      image: imageUrl,
      name: name,
      categoryId: categoryId,
      description: description,
      isFavourite: false,
      price: double.parse(price),
      qty: 1,
    );
    await reference.set(
      addProduct.toJson(),
    );
    return addProduct;
  }

  /////////Oreders//////
  Future<List<OrderModel>> getCompletedOrder() async {
    QuerySnapshot<Map<String, dynamic>> completedOrder =
        await _firebaseFirestore
            .collection("orders")
            .where("status", isEqualTo: "Completed")
            .get();
    // await _firebaseFirestore.collection("orders").get();
    List<OrderModel> completedOrderList =
        completedOrder.docs.map((e) => OrderModel.fromJson(e.data())).toList();
    return completedOrderList;
  }
  Future<List<OrderModel>> getCancelOrder() async {
    QuerySnapshot<Map<String, dynamic>> cancelOrder =
        await _firebaseFirestore
            .collection("orders")
            .where("status", isEqualTo: "Cancel")
            .get();
    // await _firebaseFirestore.collection("orders").get();
    List<OrderModel> cancelOrderList =
        cancelOrder.docs.map((e) => OrderModel.fromJson(e.data())).toList();
    return cancelOrderList;
  }
}
