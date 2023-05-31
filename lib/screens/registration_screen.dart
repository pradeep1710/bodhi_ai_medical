import 'package:bodhi_ai_medical/controllers/auth_controller.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController controller = Get.put(AuthController());
    final formKey = GlobalKey<FormState>();
    TextEditingController phoneNumberController = TextEditingController();

    Country selectedCountry = Country(
        phoneCode: "91",
        countryCode: "IN",
        e164Sc: 0,
        geographic: true,
        level: 1,
        name: "India",
        example: "India",
        displayName: "India",
        displayNameNoCountryCode: "IN",
        e164Key: '');

    void selectCountryCode(BuildContext context) {
      showCountryPicker(
          context: context,
          countryListTheme:
              const CountryListThemeData(borderRadius: BorderRadius.zero),
          onSelect: (value) {
            selectedCountry = value;
          });
    }

    void saveForm() {
      if (formKey.currentState!.validate()) {
        formKey.currentState!.save();
      }
    }

    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        physics: const ScrollPhysics(parent: BouncingScrollPhysics()),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 300,
                  width: 300,
                  child: Image.asset('assets/registration.png'),
                ),
                const Text(
                  'Register',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Add your phone number. We'll send you a verification code",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: phoneNumberController,
                  style: const TextStyle(fontSize: 18),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isNotEmpty && value.length > 9) {
                      return null;
                    }
                    return 'enter valid number';
                  },
                  onSaved: (phoneNumber) {
                    controller.signInWithPhone(
                        context, '+${selectedCountry.phoneCode}$phoneNumber');
                  },
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                      hintText: 'Enter phone number',
                      prefixIcon: Container(
                        padding:
                            const EdgeInsets.only(top: 12, left: 10, right: 5),
                        child: InkWell(
                            onTap: () => selectCountryCode(context),
                            child: SizedBox(
                                child: Text(
                              '${selectedCountry.flagEmoji} +${selectedCountry.phoneCode}',
                              style: const TextStyle(fontSize: 18),
                            ))),
                      )),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 60,
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: saveForm,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4FC3F7),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50))),
                      child: const Text(
                        'SignIn',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      )),
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
