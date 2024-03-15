import 'package:blood_donation_app/registration_ui.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Blood Donation',
        style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.network(
              'https://th.bing.com/th/id/OIP.dVS1gNpT4S7OZyphQ80f8wHaC0?w=1440&h=548&rs=1&pid=ImgDetMain',
              width: double.infinity,
              height: 350,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text('Welcome To The Blood Donation World'),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RegistrationUi()),
                );
              },
              child: const Text('Go Ahead'),
            ),
          ],
        ),
      ),
    );
  }
}
