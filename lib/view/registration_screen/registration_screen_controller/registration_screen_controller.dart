import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:home_maintanance_app/utils/snackbar_utils.dart';
import 'package:home_maintanance_app/view/registration_screen/registration_screen_controller/registration_screen_state.dart';

final registrationScreenStateProvider = StateNotifierProvider<
    RegistrationScreenStateNotifier,
    RegistrationScreenState>((ref) => RegistrationScreenStateNotifier());

class RegistrationScreenStateNotifier
    extends StateNotifier<RegistrationScreenState> {
  RegistrationScreenStateNotifier() : super(RegistrationScreenState());

  Future<bool> onRegistration({
    required String email,
    required String password,
    required String username,
    required BuildContext context,
  }) async {
    state = state.copyWith(isLoading: true);

    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user?.uid != null) {
        const userCollection = "user";
        await FirebaseFirestore.instance
            .collection(userCollection)
            .doc(credential.user!.uid)
            .set({
          "id": credential.user!.uid,
          'email': credential.user!.email,
          'username': username,
        });

        SnackbarUrils.showOntimeSnackbar(
          message: "Registration Successful",
          context: context,
          backgroundColor: Colors.green,
        );
        return true;
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'weak-password':
          errorMessage = 'The password provided is too weak.';
          break;
        case 'email-already-in-use':
          errorMessage = 'The account already exists for that email.';
          break;
        default:
          errorMessage = 'Registration failed: ${e.code}';
      }
      SnackbarUrils.showOntimeSnackbar(
        message: errorMessage,
        context: context,
      );
    } catch (e) {
      SnackbarUrils.showOntimeSnackbar(
        message: 'An unexpected error occurred: ${e.toString()}',
        context: context,
      );
    } finally {
      state = state.copyWith(isLoading: false);
    }
    return false;
  }
}
