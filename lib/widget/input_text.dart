import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Input extends StatefulWidget {
  late dynamic onChanged;
  String title;
  String value;

  Input({
    super.key,
    required this.title,
    required this.value,
    this.onChanged,
    TextEditingController? controller,
  });

  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: TextEditingController()..text = widget.value,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        labelText: widget.title,
        border: const OutlineInputBorder(),
        prefixIcon: const Icon(Icons.location_city),
      ),
    );
  }
}
