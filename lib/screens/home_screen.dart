import 'package:bodhi_ai_medical/controllers/auth_controller.dart';
import 'package:bodhi_ai_medical/controllers/medicine_controller.dart';
import 'package:bodhi_ai_medical/widgets/custom_container.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class HomeScreen extends StatelessWidget {
  final auth = FirebaseAuth.instance;
  HomeScreen({super.key});

  String greet() {
    final currentDatetime = DateTime.now();
    if (currentDatetime.hour > 4 && currentDatetime.hour < 12) {
      return 'Good Morning';
    } else if (currentDatetime.hour < 16) {
      return 'Good Afternoon';
    } else if (currentDatetime.hour < 20) {
      return 'Good Evening';
    } else {
      return 'Good Night';
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MedicineController());
    final authcontroller = Get.find<AuthController>();
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.lightBlue.shade100,
        title: Column(
          // mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${greet()},',
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w400),
            ),
            Text(
              "It's ${DateFormat('EEEE, d MMMM y').format(DateTime.now())}",
              style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w300),
            )
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {
                authcontroller.signOut();
              },
              icon: const Icon(Icons.exit_to_app_rounded))
        ],
      ),
      body: FutureBuilder(
        future: controller.getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.lightBlue,
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(15),
            child: SingleChildScrollView(
              physics: const ScrollPhysics(parent: BouncingScrollPhysics()),
              child: Column(
                children: [
                  CustomContainer(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Phone No. : ${auth.currentUser!.phoneNumber}',
                          style: const TextStyle(fontSize: 18),
                        ),
                        Text(
                          "User Id : ${const Uuid().v1().substring(0, 6)}",
                          style: const TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  CustomContainer(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Medicine Prescribe :',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Medicine name -',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        snapshot.data!.genericName,
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Dose -',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        '${snapshot.data!.dose} dose per day',
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Strength -',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                      ...snapshot.data!.activeIngredients.map((each) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 10),
                              Text(
                                each.name,
                                style: const TextStyle(fontSize: 18),
                              ),
                              Text(
                                '(${each.strength})',
                                style: const TextStyle(fontSize: 18),
                              ),
                            ],
                          )),
                    ],
                  ))
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
