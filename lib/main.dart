import 'package:bodhi_ai_medical/firebase_options.dart';
import 'package:bodhi_ai_medical/screens/home_screen.dart';
import 'package:bodhi_ai_medical/screens/registration_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance;
    return GetMaterialApp(
        title: 'Bodhi Ai Medical',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.lightBlue),
        ),
        home: StreamBuilder<User?>(
            stream: auth.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return HomeScreen();
              } else {
                return const RegistrationScreen();
              }
            }));
  }
}
