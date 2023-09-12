import 'package:flutter/material.dart';
import 'package:bmi_calculator/home.dart';

void main() {
  runApp(
    const BMICalculator(),
  );
}

class BMICalculator extends StatelessWidget {
  const BMICalculator({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      //theme: ThemeData(primarySwatch: Color(0fxffffff)),
      // primarySwatch: createMaterialColor(Color(0xFF17E0E0FF)),
      //primarySwatch: Colors.pink,
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}
