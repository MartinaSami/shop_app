import 'package:flutter/material.dart';
import 'package:flutter_shop_app/widgets/app_drawer.dart';
import 'package:provider/provider.dart';
import 'package:flutter_shop_app/providers/products.dart';
import 'package:flutter_shop_app/widgets/user_product_item.dart';
import 'edit_product_screen.dart';

class UserProductScreen extends StatelessWidget {
  static const routeName = '/user-product-screen';

  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<Products>(context, listen: false)
        .fetchAndSetProducts(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Products"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () =>
                Navigator.of(context).pushNamed(EditProductScreen.routeName),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: _refreshProducts(context),
        builder: (ctx, AsyncSnapshot snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Center(child: CircularProgressIndicator())
                : RefreshIndicator(
              onRefresh: () => _refreshProducts(context),
                    child: Consumer<Products>(
                        builder: (ctx, productData, _) => Padding(
                              padding: EdgeInsets.all(10),
                              child: ListView.builder(
                                itemCount: productData.items.length,
                                itemBuilder: (_, int index) => Column(
                                  children: [
                                    UserProductItem(
                                        productData.items[index].id,
                                        productData.items[index].title,
                                        productData.items[index].imageUrl),
                                    Divider(
                                      thickness: 3,
                                    ),
                                  ],
                                ),

                              ),
                            )),

                  ),
      ),
    );
  }
}
