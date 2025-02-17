import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:home_maintanance_app/view/service_Details_Screen/service_details_screen_controller/service_screen_controller.dart';

class ServiceDetailsScreen extends ConsumerStatefulWidget {
  final String? servicename;
  const ServiceDetailsScreen({super.key, this.servicename});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ServiceDetailsScreenState();
}

class _ServiceDetailsScreenState extends ConsumerState<ServiceDetailsScreen> {
  TextEditingController _detailscontroller = TextEditingController();
  User? currentUser = FirebaseAuth.instance.currentUser;
  @override
  @override
  Widget build(BuildContext context) {
    final serviceDetailsScreen = ref.watch(ServiceScreenStateProvider);
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple.shade300, Colors.deepPurple.shade100],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Enter Your Address',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _detailscontroller,
                decoration: InputDecoration(
                  hintText: 'Enter delivery address',
                  prefixIcon: const Icon(Icons.location_on),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.teal, width: 2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  // final address = _detailscontroller.text;
                  // if (address.isEmpty) {
                  //   ScaffoldMessenger.of(context).showSnackBar(
                  //     const SnackBar(content: Text('Please enter an address')),
                  //   );

                  // ref.read(ServiceScreenStateProvider.notifier).addOrder(
                  //     servicename: widget.servicename ?? '',
                  //     status: 'pending',
                  //     details: _detailscontroller.text,
                  //     userId: currentUser!.uid.toString());
                  // FirebaseFirestore.instance.collection('bookings').add({
                  //   'userId': FirebaseAuth.instance.currentUser?.uid,
                  //   'serviceDetails': _detailscontroller.text,
                  //   'status': 'pending',
                  //   'timestamp': FieldValue.serverTimestamp(),
                  // });
                  // } else {
                  //   ScaffoldMessenger.of(context).showSnackBar(
                  //     SnackBar(content: Text('Order placed for: $address')),
                  //   );
                  // }
                  await ref.read(ServiceScreenStateProvider.notifier).addOrder(
                      details: _detailscontroller.text,
                      servicename: widget.servicename.toString());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Center(
                  child: Text(
                    'Place Order',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.teal[50],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'Your order will be delivered to the address you specify. Please ensure accuracy for smooth delivery.',
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
