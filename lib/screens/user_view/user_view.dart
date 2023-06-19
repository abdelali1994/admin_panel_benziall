import 'package:admin_panel_benziall/models/user_model/user_model.dart';
import 'package:admin_panel_benziall/provider/app_provider.dart';
import 'package:admin_panel_benziall/screens/user_view/widgets/single_user_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserView extends StatelessWidget {
  const UserView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User View"),
      ),
      body: Consumer<AppProvider>(
        builder: (context, value, child) {
          return ListView.builder(
            padding: const EdgeInsets.all(12.0),
            itemCount: value.getUserList.length,
            itemBuilder: (context, index) {
              UserModel userModel = value.getUserList[index];
              return SingleUserCard(
                userModel: userModel,index: index,
                
              );
            },
          );
        },
      ),
    );
  }
}
