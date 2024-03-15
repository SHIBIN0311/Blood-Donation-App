
import 'package:blood_donation_app/donor_registration.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ReceiverDetails extends StatefulWidget {
  const ReceiverDetails({super.key});

  @override
  State<ReceiverDetails> createState() => _ReceiverDetailsState();
}

class _ReceiverDetailsState extends State<ReceiverDetails> {
  final CollectionReference donersCollection =
      FirebaseFirestore.instance.collection('Receiver');
  void donorDelet(docId) {
    donersCollection.doc(docId).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Receiver Details",
        style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.red,
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const DonorRegistration()),
          );
        },
        backgroundColor: Colors.red,
        child: const Icon(
          Icons.add,
          size: 40,
        ),
      ),
      body: StreamBuilder(
        stream: donersCollection.orderBy("name").snapshots(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot donerSnap = snapshot.data.docs[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 80,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                              color: Color.fromARGB(255, 180, 179, 179),
                              blurRadius: 10,
                              spreadRadius: 15)
                        ]),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              child: CircleAvatar(
                                backgroundColor: Colors.red,
                                radius: 30,
                                child: Text(
                                  donerSnap["bloodgroup"],
                                  style: const TextStyle(fontSize: 30),
                                ),
                              ),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                donerSnap["name"],
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                donerSnap["phone"].toString(),
                                style: const TextStyle(fontSize: 18),
                              ),
                              Text(
                                donerSnap["age"].toString(),
                                style: const TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/update',
                                  arguments: {
                                    "name": donerSnap["name"],
                                    "phone": donerSnap["phone"].toString(),
                                    "age": donerSnap["age"].toString(),
                                    "bloodgroup": donerSnap["bloodgroup"],
                                    "id": donerSnap.id,
                                  });
                            },
                            icon: const Icon(Icons.edit),
                            iconSize: 30,
                            color: Colors.blue,
                          ),
                          IconButton(
                            onPressed: () {
                              donorDelet(donerSnap.id);
                            },
                            icon: const Icon(Icons.delete),
                            iconSize: 30,
                            color: Colors.redAccent,
                          ),
                        ]),
                  ),
                );
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}
