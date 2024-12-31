import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:home_maintanance_app/view/service_Details_Screen/service_details_screen_controller/service_screen_state.dart';

final ServiceScreenStateProvider = StateNotifierProvider((ref) {
  return ServiceScreenStateNotifier();
});

class ServiceScreenStateNotifier extends StateNotifier<ServiceScreenState> {
  ServiceScreenStateNotifier() : super(ServiceScreenState());

  Future addOrder(
      {required String details, required String servicename}) async {
    FirebaseFirestore.instance.collection('bookings').add({
      'userId': FirebaseAuth.instance.currentUser?.uid,
      'service name': servicename,
      'serviceDetails': details,
      'status': 'pending',
      'timestamp': FieldValue.serverTimestamp(),
    });
  }
}
