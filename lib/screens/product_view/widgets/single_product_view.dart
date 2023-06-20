import 'package:admin_panel_benziall/models/product_model/product_model.dart';
import 'package:admin_panel_benziall/provider/app_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SingleProductView extends StatefulWidget {
  const SingleProductView({
    super.key,
    required this.singleProduct,
  });

  final ProductModel singleProduct;

  @override
  State<SingleProductView> createState() => _SingleProductViewState();
}

class _SingleProductViewState extends State<SingleProductView> {
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
                            .deleteProductsFromFirebase(widget.singleProduct);
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
      color: Theme.of(context).primaryColor.withOpacity(0.3),
      elevation: 0.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Stack(
        // alignment: Alignment.topRight,
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 12.0,
                ),
                Image.network(
                  widget.singleProduct.image,
                  height: 100,
                  width: 100,
                ),
                const SizedBox(
                  height: 12.0,
                ),
                Text(
                  widget.singleProduct.name,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text("Price: \$${widget.singleProduct.price}"),
              ],
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
                      // Routes.instance.push(
                      //     widget: EditCategory(
                      //         categoryModel: widget.singleCategory,
                      //         index: widget.index),
                      //     context: context);
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
