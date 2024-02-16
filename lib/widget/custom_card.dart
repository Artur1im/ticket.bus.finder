import 'package:bus_finder/model.dart/station.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomCard extends StatelessWidget {
  String routeName;
  String status;
  String statusPrint;
  int duration;
  Station departure;
  Station destination;

  CustomCard(
      {super.key,
      required this.routeName,
      required this.status,
      required this.statusPrint,
      required this.duration,
      required this.departure,
      required this.destination});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromRGBO(252, 252, 252, 1),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(routeName),
                Text('город'),
              ],
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Автобус 1'),
                    SizedBox(height: 5.0),
                    Icon(Icons.directions_bus),
                    Text('отбытие\n20: 00'),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('100 км'),
                    SizedBox(
                      width: 100,
                      child: Divider(color: Colors.black),
                    ),
                    Text('10 часво')
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Автобус 2'),
                    SizedBox(height: 5.0),
                    Icon(Icons.directions_bus),
                    Text('Прибытие\n20: 00'),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
