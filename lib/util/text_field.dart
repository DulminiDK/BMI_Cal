import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  const InputField({
    super.key,
    required this.title,
    required this.icon,
    required this.defaultController,
  });

  final TextEditingController defaultController;
  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 8.0),
      child: TextFormField(
        controller: defaultController,
        validator: (value) {
          if (value!.isEmpty) {
            return 'This field is required.';
          }
          return null;
        },
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(
              color: Color.fromARGB(255, 7, 82, 96),
              width: 2.0,
            ),
          ),
          label: Text(title),
          labelStyle: const TextStyle(
            color: Color.fromARGB(255, 7, 82, 96), // Set the text color here
          ),
          prefixIcon: Icon(
            icon,
            color: const Color.fromARGB(255, 7, 82, 96),
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: const BorderSide(
                color: Color.fromARGB(255, 7, 82, 96),
                width: 2.0,
              )),
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }
}
