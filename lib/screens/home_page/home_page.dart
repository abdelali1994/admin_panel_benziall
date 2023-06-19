import 'package:admin_panel_benziall/constants/routes.dart';
import 'package:admin_panel_benziall/provider/app_provider.dart';
import 'package:admin_panel_benziall/screens/categories_view/categories_view.dart';
import 'package:admin_panel_benziall/screens/home_page/widgets/single_dash_item.dart';
import 'package:admin_panel_benziall/screens/user_view/user_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  bool isLoading = false;
  void getData() async {
    setState(() {
      isLoading = true;
    });
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);
    await appProvider.callBackFunction();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(' Dashboard'),
        ),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
              child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CircleAvatar(
                        radius: 30,
                      ),
                      const SizedBox(
                        height: 12.0,
                      ),
                      const Text(
                        "Ali ghaffari",
                        style: TextStyle(fontSize: 18),
                      ),
                      const Text(
                        "Alighaffari@gmail.com",
                        style: TextStyle(fontSize: 18),
                      ),
                      GridView.count(
                        shrinkWrap: true,
                        primary: false,
                        padding: const EdgeInsets.only(top: 12.0),
                        crossAxisCount: 2,
                        children: [
                          SingleDashItem(
                              onPressed: () {
                                Routes.instance.push(
                                    widget: const UserView(), context: context);
                              },
                              title: appProvider.getUserList.length.toString(),
                              subtitle: "Users"),
                          SingleDashItem(
                              onPressed: () {
                                Routes.instance.push(
                                    widget: const CategoriesView(), context: context);
                              },
                              title: appProvider.getCategoriesList.length
                                  .toString(),
                              subtitle: "Categories"),
                          SingleDashItem(
                              onPressed: () {},
                              title: "400",
                              subtitle: "Products"),
                          SingleDashItem(
                              onPressed: () {},
                              title: "1300",
                              subtitle: "Earning"),
                          SingleDashItem(
                              onPressed: () {},
                              title: "300",
                              subtitle: "Pending Order"),
                          SingleDashItem(
                              onPressed: () {},
                              title: "300",
                              subtitle: "Completed Order"),
                          SingleDashItem(
                              onPressed: () {},
                              title: "300",
                              subtitle: "Cancel Order"),
                          SingleDashItem(
                              onPressed: () {},
                              title: "300",
                              subtitle: "Delivery Order"),
                        ],
                      ),
                    ]),
              ),
            ),
    );
  }
}
