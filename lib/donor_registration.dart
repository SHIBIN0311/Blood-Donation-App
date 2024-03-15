
import 'package:blood_donation_app/donor_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DonorRegistration extends StatefulWidget {
  const DonorRegistration({super.key});

  @override
  State<DonorRegistration> createState() => _DonorRegistrationState();
}

class _DonorRegistrationState extends State<DonorRegistration> {
  final bloodGroup = ["A+", "A-", 'B-', 'B+', 'O+', 'O-', 'AB-', "AB+"];
  String? selectedgroup;
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final ageController = TextEditingController();

  final CollectionReference donersCollection =
      FirebaseFirestore.instance.collection('Doner');
  addDoners() {
    final data = {
      "name": nameController.text,
      "phone": phoneController.text,
      "age": ageController.text,
      "bloodgroup": selectedgroup
    };
    donersCollection.add(data);
  }
   bool isButtonPressed() {
    return nameController.text.isNotEmpty &&
           phoneController.text.isNotEmpty &&
           ageController.text.isNotEmpty;
 }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
          title: const Text(
            'Register Now',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: "Doner Name",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                keyboardType: TextInputType.number,
                controller: ageController,
                decoration: const InputDecoration(
                  labelText: "Doner Age",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: phoneController,
                keyboardType: TextInputType.number,
                maxLength: 10,
                decoration: const InputDecoration(
                  labelText: "Phone Number",
                  border: OutlineInputBorder(),
                ),
              ),
              DropdownButtonFormField(
                items: bloodGroup
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e),
                        ))
                    .toList(),
                onChanged: (val) {
                  setState(() {
                    selectedgroup = val;
                  });
                },
                decoration: const InputDecoration(
                  labelText: "Choose blood group",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: isButtonPressed() ? () {
                  addDoners();
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const DonorDetails(),
                  ));
                }: null,
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(
                      const Size(double.infinity, 50)),
                  backgroundColor: MaterialStateProperty.all(Colors.red),
                ),
                child: const Text(
                  "Save",
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
