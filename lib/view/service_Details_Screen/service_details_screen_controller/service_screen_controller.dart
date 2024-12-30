import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:home_maintanance_app/view/service_Details_Screen/service_details_screen_controller/service_screen_state.dart';

final ServiceScreenStateProvider = StateNotifierProvider((ref) {
  return ServiceScreenStateNotifier();
});

class ServiceScreenStateNotifier extends StateNotifier<ServiceScreenState> {
  ServiceScreenStateNotifier() : super(ServiceScreenState());
  void addOrder({
    required final String userId,
    required final String servicename,
    required final String status,
    required final String details,
    final DateTime? timestamp,
  }) async {
    final order = {
      'userId': userId,
      'details': details,
      'itemName': servicename,
      'status': status,
      'timestamp': FieldValue.serverTimestamp(),
    };

    try {
      await FirebaseFirestore.instance.collection('Bookings').add(order);
      print("Order added successfully!");
    } on FirebaseException catch (e) {
      if (e.code == 'permission-denied') {
        print('Permission denied. Please check Firestore rules.');
      } else if (e.code == 'unavailable') {
        print('Firestore is currently unavailable. Try again later.');
      } else if (e.code == 'invalid-argument') {
        print('Invalid data provided. Check the fields and data types.');
      } else {
        print('FirebaseException: ${e.message}');
      }
    } catch (e) {
      print('An unexpected error occurred: $e');
    }
  }
}
