import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:home_maintanance_app/model/oder_model.dart';
import 'package:home_maintanance_app/view/service_Details_Screen/service_details_screen_controller/service_screen_state.dart';

final ServiceScreenStateProvider = StateNotifierProvider((ref) {
  return ServiceScreenStateNotifier();
});

class ServiceScreenStateNotifier extends StateNotifier<ServiceScreenState> {
  ServiceScreenStateNotifier() : super(ServiceScreenState());

  void addOrderToFirebase(
      {BuildContext? context,
      final String? name,
      final String? place,
      final String? houseName,
      final String? phoneNumber,
      final DateTime? orderTime,
      final String? orderId,
      final String? userId,
      final String? status,
      final String? serviceName}) async {
    try {
      // Create the order instance
      OderModel order = OderModel(
        name: name.toString(),
        place: place.toString(),
        houseName: houseName.toString(),
        phoneNumber: phoneNumber.toString(),
        orderTime: DateTime.now(),
        orderId: FirebaseFirestore.instance.collection('orders').doc().id,
        userId: "USER_ID", // Replace with the actual user ID
        status: "pending", // Default status
        serviceName: serviceName.toString(), // Service name
      );

      // Add to Firestore
      await FirebaseFirestore.instance
          .collection('orders')
          .doc(orderId)
          .set(order.toJson());

      ScaffoldMessenger.of(context!).showSnackBar(
        SnackBar(content: Text("Order added successfully!")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context!).showSnackBar(
        SnackBar(content: Text("Failed to add order: $e")),
      );
    }
  }
}
