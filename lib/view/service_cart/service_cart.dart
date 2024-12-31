import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('bookings')
              .where('userId',
                  isEqualTo: FirebaseAuth.instance.currentUser?.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return CircularProgressIndicator();
            final bookings = snapshot.data!.docs;
            return ListView.builder(
              itemCount: bookings.length,
              itemBuilder: (context, index) {
                final booking = bookings[index];
                return Card(
                  child: ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(booking['service name']),
                        Text("Adress: ${booking['serviceDetails']}"),
                      ],
                    ),
                    subtitle: Text('Status: ${booking['status']}'),
                  ),
                );
              },
            );
          },
        ));
  }
}
