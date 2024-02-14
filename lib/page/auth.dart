import 'package:bus_finder/page/home_page.dart';
import 'package:bus_finder/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final String privacyPolicyUrl = 'https://www.youtube.com/';
  final String termsConditionsUrl = 'https://flutter.dev/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Authorization'),
        ),
        body: Container(
            color: Colors.white,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButton(
                    title: 'Get Started',
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => const HomePage(),
                          ));
                    },
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                    title: 'Terms and Conditions',
                    onPressed: () {
                      _launchUrl(termsConditionsUrl);
                    },
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                    title: 'Privacy Policy',
                    onPressed: () {
                      _launchUrl(privacyPolicyUrl);
                    },
                  ),
                ],
              ),
            )));
  }

  void _launchUrl(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }
}
