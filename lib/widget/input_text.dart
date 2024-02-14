import 'package:bus_finder/bloc/bus_bloc.dart';
import 'package:flutter/material.dart';

class Input extends StatefulWidget {
  late dynamic onChanged;
  Input({super.key, required String title, required this.onChanged});
  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {
  dynamic onChanged;
  String title = '';
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: title,
        border: const OutlineInputBorder(),
        prefixIcon: Icon(Icons.search),
      ),
    );
  }
}
