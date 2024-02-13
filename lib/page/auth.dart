import 'package:bus_finder/widget/custom_button.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Authorization'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Authorization Screen'),
            CustomButton(
              title: 'Get Started',
              onPressed: () {},
            ),
            CustomButton(
              title: 'Terms and Conditions',
              onPressed: () {},
            ),
            CustomButton(
              title: 'Privacy Policy',
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
