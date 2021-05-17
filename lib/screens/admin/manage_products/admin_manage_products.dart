import 'package:flutter/material.dart';
import 'package:wiakum/cosntants.dart';
import 'package:wiakum/screens/admin/manage_products/components/edit_products/component/edit_products.dart';
import 'components/add_products/add_products.dart';

class AdminManageProducts extends StatelessWidget {
  static const routeName='adminManageProducts';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Manage Products'),
            backgroundColor: primaryColor,
            bottom: TabBar(tabs: [
              Tab(child: Text('Add Product'),),
              Tab(child: Text('Edit Products'),)
            ]),
          ),
          body: TabBarView(children: [
            AddProducts(),
            EditProducts()
          ]),
        ),
      ),
    );
  }
}
