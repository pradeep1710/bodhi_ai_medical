import 'package:bodhi_ai_medical/screens/home_screen.dart';
import 'package:bodhi_ai_medical/screens/otp_screen.dart';
import 'package:bodhi_ai_medical/screens/registration_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/utils.dart';

class AuthController extends GetxController {
  final auth = FirebaseAuth.instance;

  void signInWithPhone(BuildContext context, String phoneNumber) async {
    try {
      Get.dialog(const Center(child: CircularProgressIndicator()));
      await auth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted: (PhoneAuthCredential credential) async {
            await auth.signInWithCredential(credential);
          },
          verificationFailed: (e) {
            throw Exception(e.message);
          },
          codeSent: (verificationId, forceResendingToken) {
            Get.back();
            Get.to(() => OTPScreen(verificationId: verificationId));
          },
          codeAutoRetrievalTimeout: (verificationId) {});
    } on FirebaseException catch (e, f) {
      debugPrint(e.message.toString());
      debugPrint(f.toString());
      showSnackBar(context, e.message!);
    }
  }

  void verifyOTP(
      BuildContext context, String verificationId, String userOTP) async {
    try {
      final PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: userOTP);
      await auth.signInWithCredential(credential).whenComplete(() {
        Get.offAll(() => HomeScreen());
      });
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
  }

  void signOut() async {
    await auth.signOut();
    Get.offAll(() => const RegistrationScreen());
    update();
  }
}
