class OderModel {
  String name;
  String place;
  String houseName;
  String phoneNumber;
  DateTime orderTime;
  String orderId;
  String userId;
  String status; // Status of the order (e.g., pending, completed, canceled)
  String serviceName; // Name of the service (e.g., Plumbing, Electrical)

  // Constructor
  OderModel({
    required this.name,
    required this.place,
    required this.houseName,
    required this.phoneNumber,
    required this.orderTime,
    required this.orderId,
    required this.userId,
    required this.status,
    required this.serviceName,
  });

  // Factory method to create an instance from a JSON object
  factory OderModel.fromJson(Map<String, dynamic> json) {
    return OderModel(
      name: json['name'],
      place: json['place'],
      houseName: json['houseName'],
      phoneNumber: json['phoneNumber'],
      orderTime: DateTime.parse(json['orderTime']),
      orderId: json['orderId'],
      userId: json['userId'],
      status: json['status'],
      serviceName: json['serviceName'],
    );
  }

  // Method to convert the instance to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'place': place,
      'houseName': houseName,
      'phoneNumber': phoneNumber,
      'orderTime': orderTime.toIso8601String(),
      'orderId': orderId,
      'userId': userId,
      'status': status,
      'serviceName': serviceName,
    };
  }
}
