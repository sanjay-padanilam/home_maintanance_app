import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:home_maintanance_app/view/homescreen/homescreen_cotroller/homescreen_state.dart';

final HomescreenStateProvider =
    StateNotifierProvider<HomeScreenStateNotifier, HomescreenState>(
  (ref) => HomeScreenStateNotifier(),
);

class HomeScreenStateNotifier extends StateNotifier<HomescreenState> {
  HomeScreenStateNotifier() : super(HomescreenState());

  Future<void> fetchUsername(String userId) async {
    try {
      // Set loading state
      state = state.copyWith(isLoading: true);

      // Reference to the Firestore 'user' collection
      CollectionReference users = FirebaseFirestore.instance.collection('user');

      // Retrieve the document with the given userId
      DocumentSnapshot userDoc = await users.doc(userId).get();

      // Check if the document exists
      if (userDoc.exists) {
        // Extract the username field from the document
        String username = userDoc.get('username') as String;

        // Update the state with the username and set isLoading to false
        state = state.copyWith(name: username);
      } else {
        print('User document does not exist.');
        state = state.copyWith(isLoading: false);
      }
    } catch (e) {
      print('Error retrieving username: $e');
      state = state.copyWith(isLoading: false);
    }
  }
}
