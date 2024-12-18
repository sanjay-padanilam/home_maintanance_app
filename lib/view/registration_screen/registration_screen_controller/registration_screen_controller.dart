import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:home_maintanance_app/view/registration_screen/registration_screen_controller/registration_screen_state.dart';

final RegistrationScreenStateProvider = StateNotifierProvider(
  (ref) => RegistrationScreenStateNotifier(),
);

class RegistrationScreenStateNotifier
    extends StateNotifier<RegistrationScreenState> {
  RegistrationScreenStateNotifier() : super(RegistrationScreenState());

  Future<void> onRegistration(
      {required String email,
      required String password,
      required BuildContext}) async {
    state = state.copyWith(isLoading: true);
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (credential.user?.uid != null) {}
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
      } else if (e.code == 'email-already-in-use') {}
    } catch (e) {}
    state = state.copyWith(isLoading: false);
  }
}
