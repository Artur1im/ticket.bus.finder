import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final title;
  final onPressed;
  const CustomButton({super.key, this.title, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(title),
    );
  }
}
