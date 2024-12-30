import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:home_maintanance_app/model/booking_model.dart';
import 'package:home_maintanance_app/view/service_cart/service_cart_controller/service_cart_controller.dart';

class ServiceCart extends ConsumerStatefulWidget {
  const ServiceCart({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => ServiceCartState();
}

class ServiceCartState extends ConsumerState<ServiceCart> {
  final User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.deepPurple.shade200,
        appBar: AppBar(
          backgroundColor: Colors.deepPurple.shade400,
          title: Text('Order List'),
        ),
        body: StreamBuilder<List<OrderModel>>(
          stream: ref
              .read(ServiceCartStateProvider.notifier)
              .fetchUserOrders(user!.uid.toString()),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }
            if (snapshot.hasError || !snapshot.hasData) {
              return Text('Error fetching orders ${snapshot.error}');
            }

            final orders = snapshot.data!;
            return ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                log(order.toString());

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(
                          ' ${order.servicename.toString()}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        trailing: order.status.toLowerCase() == 'approved'
                            ? Container(
                                color: Colors.green,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("Order Approved"),
                                ),
                              )
                            : order.status.toLowerCase() == 'rejected'
                                ? Container(
                                    color: Colors.red,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("Order Rejected"),
                                    ),
                                  )
                                : Container(
                                    color: Colors.yellow,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("Order pending"),
                                    ),
                                  ),
                      ),
                      Divider(
                        height: 12,
                      )
                    ],
                  ),
                );
              },
            );
          },
        ));
  }
}
