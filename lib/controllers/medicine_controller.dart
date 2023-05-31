import 'dart:convert';
import 'package:bodhi_ai_medical/model/medicine_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class MedicineController extends GetxController {
  Future<Medicine?> getData() async {
    Medicine medicine;
    try {
      final url = Uri.parse(
          "https://run.mocky.io/v3/f50bcc43-5a7f-4116-ad0e-4375078161b5");
      final response = await http.get(url);

      final data = jsonDecode(response.body);
      medicine = Medicine.fromMap(data[0]);
      update();

      return medicine;
    } catch (e, f) {
      debugPrint(e.toString());
      debugPrint(f.toString());
    }
    update();
    return null;
  }
}
