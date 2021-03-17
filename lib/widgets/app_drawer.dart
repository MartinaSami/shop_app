import 'package:flutter/material.dart';
import 'package:flutter_shop_app/providers/auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter_shop_app/screens/user_products_screen.dart';
import 'package:flutter_shop_app/screens/orders_screen.dart';
import 'package:flutter_shop_app/screens/auth_screen.dart';
class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text("Hello"),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
              leading: Icon(Icons.shop),
              title: Text("Shop"),
              onTap: () => Navigator.of(context).pushReplacementNamed('/')),
          Divider(),
          ListTile(
              leading: Icon(Icons.payment),
              title: Text("Orders"),
              onTap: () => Navigator.of(context)
                  .pushReplacementNamed(OrderScreen.routeName)),
          Divider(),
          ListTile(
              leading: Icon(Icons.edit),
              title: Text("Manage Product"),
              onTap: () => Navigator.of(context)
                  .pushReplacementNamed(UserProductScreen.routeName)),
          Divider(),
          ListTile(
              leading: Icon(Icons.logout),
              title: Text("Logout"),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context)
                    .pushReplacementNamed('/');
                Provider.of<Auth>(context,listen: false).tryAutoLogout();
              }),
        ],
      ),
    );
  }
}
