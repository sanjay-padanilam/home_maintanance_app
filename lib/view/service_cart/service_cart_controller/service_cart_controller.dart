import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:home_maintanance_app/model/booking_model.dart';
import 'package:home_maintanance_app/view/service_cart/service_cart_controller/service_cart_state.dart';

final ServiceCartStateProvider = StateNotifierProvider((ref) {
  return ServiceCartStateNotifier();
});

class ServiceCartStateNotifier extends StateNotifier<ServiceCartState> {
  ServiceCartStateNotifier() : super(ServiceCartState());
  Stream<List<OrderModel>> fetchUserOrders(String userId) {
    return FirebaseFirestore.instance
        .collection('Bookings')
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              return OrderModel.fromMap(
                doc.data(),
              );
            }).toList());
  }
}
