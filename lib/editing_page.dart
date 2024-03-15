import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditingPage extends StatefulWidget {
  const EditingPage({super.key});

  @override
  State<EditingPage> createState() => _EditingPageState();
}

class _EditingPageState extends State<EditingPage> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final ageController = TextEditingController();
  final bloodGroup = ["A+", "A-", 'B-', 'B+', 'O+', 'O-', 'AB-', "AB+"];
  String? selectedgroup;

  final CollectionReference donersCollection =
      FirebaseFirestore.instance.collection('Doner');

  void updateDoner(docId) {
    final data = {
      'name': nameController.text,
      'age': ageController.text,
      'phone': phoneController.text,
      'bloodgroup': selectedgroup,
    };
    donersCollection
        .doc(docId)
        .update(data)
        .then((value) => Navigator.pop(context));
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    nameController.text = args["name"];
    phoneController.text = args["phone"];
    selectedgroup = args["bloodgroup"];
    final docId = args['id'];

    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: const Text("Edit Your Data",
              style: TextStyle(color: Colors.white),),
              backgroundColor: Colors.red,
            ),
            body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(children: [
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      labelText: "Doner name",
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
                      labelText: "Phone number",
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
                    onPressed: () {
                      setState(() {
                        selectedgroup = selectedgroup;
                      });
                      updateDoner(docId);
                    },
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(
                          const Size(double.infinity, 50)),
                      backgroundColor: MaterialStateProperty.all(Colors.red),
                    ),
                    child: const Text(
                      "update",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ]))));
  }
}
