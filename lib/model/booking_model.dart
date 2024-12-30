import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  final String userId;

  final String servicename;

  final String status;
  final String details;
  final DateTime? timestamp;

  OrderModel({
    required this.details,
    required this.userId,
    required this.servicename,
    required this.status,
    this.timestamp,
  });

  factory OrderModel.fromMap(
    Map<String, dynamic> data,
  ) {
    return OrderModel(
      userId: data['userId'],
      servicename: data['itemName'],
      status: data['status'],
      timestamp: (data['timestamp'] as Timestamp?)?.toDate(),
      details: data['details'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'details': details,
      'itemName': servicename,
      'status': status,
      'timestamp': FieldValue.serverTimestamp(),
    };
  }
}
