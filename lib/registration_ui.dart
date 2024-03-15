import 'package:blood_donation_app/doners_list.dart';
import 'package:blood_donation_app/doners_registration.dart';
import 'package:flutter/material.dart';

class RegistrationUi extends StatelessWidget {
  const RegistrationUi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blood Donation'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.network(
              'https://th.bing.com/th/id/OIP.WiB7YEBLZPPpnM0GGAo86AAAAA?rs=1&pid=ImgDetMain',
              width: double.infinity,
              height: 350,
            ),
            const SizedBox(height: 20),
            const Text('Welcome To The Blood Donation World'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const DonorRegistration()),
                );
              },
              child: const Text('REGISTER AS DONOR'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DonersList()),
                );
              },
              child: const Text('VIEW DONERS LIST'),
            ),
          ],
        ),
      ),
    );
  }
}
