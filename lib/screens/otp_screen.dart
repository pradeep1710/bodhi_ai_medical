import 'package:bodhi_ai_medical/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

class OTPScreen extends StatelessWidget {
  final String verificationId;
  const OTPScreen({super.key, required this.verificationId});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthController>();
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
          physics: const ScrollPhysics(parent: BouncingScrollPhysics()),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
            child: Column(
              children: [
                SizedBox(
                  height: 300,
                  width: 300,
                  child: Image.asset('assets/otp.png'),
                ),
                const Text(
                  'Verification',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Enter the OTP sent to your phone number",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15),
                ),
                const SizedBox(height: 10),
                Pinput(
                  closeKeyboardWhenCompleted: false,
                  length: 6,
                  showCursor: true,
                  defaultPinTheme: PinTheme(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                          color: Colors.lightBlue.shade50,
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(5)),
                      textStyle: const TextStyle(fontSize: 20)),
                  onSubmitted: (userOTP) {
                    controller.verifyOTP(context, verificationId, userOTP);
                  },
                )
              ],
            ),
          )),
    ));
  }
}
