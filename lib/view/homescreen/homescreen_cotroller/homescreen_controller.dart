import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:home_maintanance_app/view/homescreen/homescreen_cotroller/homescreen_state.dart';

final HomescreenStateProvider = StateNotifierProvider((ref) {
  return HomeScreenStateNotifier();
});

class HomeScreenStateNotifier extends StateNotifier<HomescreenState> {
  HomeScreenStateNotifier() : super(HomescreenState());
}

Future<String?> getUsername({String? userId}) async {
  try {
    // Reference to the Firestore 'user' collection
    CollectionReference users = FirebaseFirestore.instance.collection('user');

    // Retrieve the document with the given userId
    DocumentSnapshot userDoc = await users.doc(userId).get();

    // Check if the document exists
    if (userDoc.exists) {
      // Extract the username field from the document
      String username = userDoc.get('username') as String;
      return username;
    } else {
      print('User document does not exist.');
      return null;
    }
  } catch (e) {
    print('Error retrieving username: $e');
    return null;
  }
}
