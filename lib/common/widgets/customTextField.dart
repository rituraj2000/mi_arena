import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final int maxlines;
  const CustomTextField({
    required this.hint,
    required this.controller,
    this.maxlines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
      child: TextFormField(
        maxLines: maxlines,
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
          border: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black38,
            ),
          ),
        ),
        // validator: (val) {
        //   if (val == null || val.isEmpty) return 'Enter your $hint';

        //   return null;
        // },
      ),
    );
  }
}
