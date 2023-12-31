import 'package:admin_panel_benziall/constants/routes.dart';
import 'package:admin_panel_benziall/models/user_model/user_model.dart';
import 'package:admin_panel_benziall/provider/app_provider.dart';
import 'package:admin_panel_benziall/screens/user_view/edit_user/edit_user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SingleUserCard extends StatefulWidget {
  final UserModel userModel;
  final int index;
  const SingleUserCard({super.key, required this.userModel, required this.index});

  @override
  State<SingleUserCard> createState() => _SingleUserCardState();
}

class _SingleUserCardState extends State<SingleUserCard> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);

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
                  await appProvider.deleteUserFromFirebase(widget.userModel);
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
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            widget.userModel.image != null
                ? CircleAvatar(
                    // radius: 20, // قطر الصورة الدائرية
                    backgroundImage:
                        NetworkImage(widget.userModel.image!), // مصدر الصورة
                  )
                // ? Image.network(userModel.image!,width: 40,height: 40,)
                : const CircleAvatar(
                    child: Icon(Icons.person),
                  ),
            const SizedBox(
              width: 12.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.userModel.name),
                Text(widget.userModel.email),
              ],
            ),
            const Spacer(),
            isLoading
                ? const CircularProgressIndicator()
                : GestureDetector(
                    onTap: () async {
                      _showDeleteConfirmationDialog();
                    },
                    child: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  ),
            const SizedBox(
              width: 6.0,
            ),
            GestureDetector(
              onTap: () async {
                Routes.instance.push(
                    widget: EditUser(index:widget.index,userModel: widget.userModel),
                    context: context);
                // setState(() {
                //   isLoading = true;
                // });
                // await appProvider.deleteUserFromFirebase(widget.userModel);
                // setState(() {
                //   isLoading = false;
                // });
              },
              child: const Icon(
                Icons.edit,
                color: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// import 'package:admin_panel_benziall/models/user_model/user_model.dart';
// import 'package:admin_panel_benziall/provider/app_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class SingleUserCard extends StatefulWidget {
//   final UserModel userModel;

//   const SingleUserCard({Key? key, required this.userModel}) : super(key: key);

//   @override
//   _SingleUserCardState createState() => _SingleUserCardState();
// }

// class _SingleUserCardState extends State<SingleUserCard> {
//   bool isLoading = false;

//   @override
//   Widget build(BuildContext context) {
//     AppProvider appProvider = Provider.of<AppProvider>(context);

// void _showDeleteConfirmationDialog() {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: const Text('تأكيد الحذف'),
//         content: const Text('هل ترغب حقًا في حذف هذا المستخدم؟'),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop(); // إغلاق حوار التأكيد
//             },
//             child: const Text(
//               'لا',
//               style: TextStyle(fontSize: 18),
//             ),
//           ),
//           TextButton(
//             onPressed: () async {
//               setState(() {
//                 isLoading = true;
//               });
//               await appProvider.deleteUserFromFirebase(widget.userModel);
//               setState(() {
//                 isLoading = false;
//               });
//               Navigator.of(context).pop(); // إغلاق حوار التأكيد
//             },
//             child: const Text(
//               'نعم',
//               style: TextStyle(fontSize: 18),
//             ),
//           ),
//         ],
//       );
//     },
//   );
// }

//     return Card(
//       child: Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: Row(
//           children: [
//             widget.userModel.image != null
//                 ? CircleAvatar(
//                     radius: 20,
//                     backgroundImage: NetworkImage(widget.userModel.image!),
//                   )
//                 : const CircleAvatar(
//                     child: Icon(Icons.person),
//                   ),
//             const SizedBox(
//               width: 12.0,
//             ),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(widget.userModel.name),
//                 Text(widget.userModel.email),
//               ],
//             ),
//             const Spacer(),
//             isLoading
//                 ? const CircularProgressIndicator()
//                 : IconButton(
//                     onPressed: () {
//                       _showDeleteConfirmationDialog();
//                     },
//                     icon: const Icon(
//                       Icons.delete,
//                       color: Colors.red,
//                     ),
//                   ),
//           ],
//         ),
//       ),
//     );
//   }
// }
