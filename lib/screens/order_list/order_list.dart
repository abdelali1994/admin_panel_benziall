import 'package:admin_panel_benziall/models/order_model/order_model.dart';
import 'package:admin_panel_benziall/widgets/single_order_widget/single_order_widget.dart';
import 'package:flutter/material.dart';

class OrderList extends StatelessWidget {
  final List<OrderModel> orderModelList;
  final String title;
  const OrderList({super.key, required this.orderModelList, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text("$title Order list"),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
        child: ListView.builder(
            itemCount: orderModelList.length,
            itemBuilder: (context, index) {
              OrderModel orderModel = orderModelList[index];
              return SingleOrderWidget(
                orderModel: orderModel,
              );
            }),
      ),
    );
  }
}
