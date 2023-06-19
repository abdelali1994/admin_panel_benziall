// ignore_for_file: use_build_context_synchronously

import 'package:admin_panel_benziall/constants/routes.dart';
import 'package:admin_panel_benziall/models/category_model/category_model.dart';
import 'package:admin_panel_benziall/provider/app_provider.dart';
import 'package:admin_panel_benziall/screens/categories_view/edit_category/edit_category.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SingleCategoriesItem extends StatefulWidget {
  final CategoryModel singleCategory;
  final int index;
  const SingleCategoriesItem({super.key, required this.singleCategory, required this.index});

  @override
  State<SingleCategoriesItem> createState() => _SingleCategoriesItemState();
}

class _SingleCategoriesItemState extends State<SingleCategoriesItem> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(
      context,
    );

    void _showDeleteConfirmationDialog() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('تأكيد الحذف'),
            content: const Text('هل ترغب حقًا في حذف هذا المستخدم؟'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // إغلاق حوار التأكيد
                },
                child: const Text(
                  'لا',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              TextButton(
                onPressed: () async {
                  setState(() {
                    isLoading = true;
                  });
                  await appProvider
                      .deleteCategoryFromFirebase(widget.singleCategory);
                  setState(() {
                    isLoading = false;
                  });
                  Navigator.of(context).pop(); // إغلاق حوار التأكيد
                },
                child: const Text(
                  'نعم',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          );
        },
      );
    }

    return Card(
      color: Colors.white,
      elevation: 3.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Stack(
        children: [
          Center(
            child: SizedBox(
              // height: 100,
              // width: 100,
              child: Image.network(widget.singleCategory.image, scale: 7),
            ),
          ),
          Positioned(
            right: 0.0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  IgnorePointer(
                    ignoring: isLoading,
                    child: GestureDetector(
                      onTap: () async {
                        _showDeleteConfirmationDialog();
                      },
                      child: isLoading
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                    ),
                  ),
                  const SizedBox(
                    width: 12.0,
                  ),
                  GestureDetector(
                    onTap: () {
                      Routes.instance.push(
                          widget: EditCategory(
                              categoryModel: widget.singleCategory,
                              index: widget.index),
                          context: context);
                    },
                    child: const Icon(
                      Icons.edit,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(
                    width: 12.0,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
