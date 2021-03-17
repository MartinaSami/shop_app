import 'package:flutter/material.dart';
import 'package:flutter_shop_app/providers/orders.dart' as ord;
import 'package:intl/intl.dart';

class OrderItem extends StatelessWidget {
  final ord.OrderItem order;

  const OrderItem(this.order);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: ExpansionTile(
        title: Text('\$${order.amount}'),
        subtitle: Text(DateFormat('dd/MM/yyy').format(order.dateTime)),
        children: order.products
            .map((prod) => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      prod.title,
                      style: TextStyle(fontSize: 20),
                    ),
                    Text('${prod.quantity}x \$${prod.price}',
                        style: TextStyle(color: Colors.grey)),
                  ],
                ))
            .toList(),
      ),
    );
  }
}
