import 'package:bmi_calculator/constants.dart';
import 'package:flutter/material.dart';
import 'package:bmi_calculator/util/text_field.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _formKey = GlobalKey<FormState>();

  final _weightController = TextEditingController();
  final _heightController = TextEditingController();

  double bmiValue = 0;
  String postComment = '';
  IconData? commentIcon;
  Color? bgColor;
  String idealWeightMessage = ''; // Variable for ideal weight message

  void calculateBMI() {
    final double doubleWeight = double.parse(_weightController.text);
    final double doubleHeight = double.parse(_heightController.text);
    setState(() {
      bmiValue = doubleWeight / (doubleHeight * doubleHeight) * 10000;
    });
  }

  void displayComment() {
    setState(() {
      if (bmiValue < 18.5) {
        bgColor = Colors.orange[300];
        commentIcon = Icons.sentiment_dissatisfied;
        postComment = 'You\'re Underweight!';
      } else if (bmiValue < 24.9) {
        bgColor = Colors.green[300];
        commentIcon = Icons.sentiment_very_satisfied;
        postComment = 'You\'re Healthy!';
      } else {
        bgColor = Colors.red[300];
        commentIcon = Icons.sentiment_very_dissatisfied;
        postComment = 'You\'re Overweight!';
      }

      // Calculate ideal weight here
      double height = double.parse(_heightController.text);
      double idealWeight = 50 + 0.91 * (height - 152.4);
      idealWeightMessage = 'Ideal weight: ${idealWeight.toStringAsFixed(2)} kg';
    });
  }

  @override
  void dispose() {
    _weightController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(
          backgroundColor: kActiveButtonColor,
          title: const Center(
            child: Text('BMI Calculator'),
          ),
        ),
        body: Center(
          child: ListView(
            children: [
              const SizedBox(
                height: 15.0,
              ),
              Column(
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Text(
                      'Body Mass Index(BMI) is a metric of body fat percentage commonly used to estimate risk levels of potential health problems.',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        InputField(
                          defaultController: _weightController,
                          title: 'Weight (kg)',
                          icon: Icons.scale,
                        ),
                        InputField(
                          defaultController: _heightController,
                          title: 'Height (cm)',
                          icon: Icons.height,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: screenWidth,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 100.0, vertical: 8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          calculateBMI();
                          displayComment();
                        } else {
                          // Do nothing
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 5.0,
                        backgroundColor: kActiveButtonColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        child: Text('Calculate'),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Text(
                      'Your BMI Value is:',
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                  Text(
                    bmiValue.toStringAsFixed(3),
                    style: const TextStyle(fontSize: 35.0),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          commentIcon,
                          size: 35.0,
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          postComment,
                          style: const TextStyle(fontSize: 20.0),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Text(
                      idealWeightMessage,
                      style: const TextStyle(fontSize: 20.0),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
