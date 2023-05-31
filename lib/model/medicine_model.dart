// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

class Medicine {
  final String genericName;
  final String brand;
  final List<ActiveIngredients> activeIngredients;
  int dose;
  Medicine({
    required this.genericName,
    required this.brand,
    required this.activeIngredients,
  }) : dose = Random().nextInt(3) + 1;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'genericName': genericName,
      'brand': brand,
      'activeIngredients': activeIngredients.map((x) => x.toMap()).toList(),
      'dose': dose,
    };
  }

  factory Medicine.fromMap(Map<String, dynamic> map) {
    return Medicine(
      genericName: map["generic_name"] as String,
      brand: map["brand_name"] as String,
      activeIngredients: List<ActiveIngredients>.from(
        map["active_ingredients"].map<ActiveIngredients>(
          (x) => ActiveIngredients.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }
}

class ActiveIngredients {
  final String name;
  final String strength;
  ActiveIngredients({
    required this.name,
    required this.strength,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'strength': strength,
    };
  }

  factory ActiveIngredients.fromMap(Map<String, dynamic> map) {
    return ActiveIngredients(
      name: map['name'] as String,
      strength: map['strength'] as String,
    );
  }
}
