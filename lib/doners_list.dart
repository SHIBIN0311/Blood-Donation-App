// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// class DonorsList extends StatefulWidget {
//   const DonorsList({super.key});

//   @override
//   State<DonorsList> createState() => _DonorsListState();
// }

// class _DonorsListState extends State<DonorsList> {
//   final CollectionReference donersCollection =
//       FirebaseFirestore.instance.collection('Doner');
//   void donorDelet(docId) {
//     donersCollection.doc(docId).delete();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Doners Details"),
//         centerTitle: true,
//       ),
//       body: StreamBuilder(
//         stream: donersCollection.orderBy("name").snapshots(),
//         builder: (context, AsyncSnapshot snapshot) {
//           if (snapshot.hasData) {
//             return ListView.builder(
//               itemCount: snapshot.data.docs.length,
//               itemBuilder: (context, index) {
//                 final DocumentSnapshot donerSnap = snapshot.data.docs[index];
//                 return Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Container(
//                     height: 80,
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10),
//                         color: Colors.white,
//                         boxShadow: const [
//                           BoxShadow(
//                               color: Color.fromARGB(255, 180, 179, 179),
//                               blurRadius: 10,
//                               spreadRadius: 15)
//                         ]),
//                     child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: SizedBox(
//                               child: CircleAvatar(
//                                 radius: 30,
//                                 child: Text(
//                                   donerSnap["bloodgroup"],
//                                   style: const TextStyle(fontSize: 30),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Text(
//                                 donerSnap["name"],
//                                 style: const TextStyle(
//                                     fontSize: 18, fontWeight: FontWeight.bold),
//                               ),
//                               Text(
//                                 donerSnap["phone"].toString(),
//                                 style: const TextStyle(fontSize: 18),
//                               ),
//                               Text(
//                                 donerSnap["age"].toString(),
//                                 style: const TextStyle(fontSize: 18),
//                               ),
//                             ],
//                           ),
//                           IconButton(
//                             onPressed: () {},
//                             icon: const Icon(Icons.people),
//                             iconSize: 30,
//                             color: Colors.redAccent,
//                           ),
//                         ]),
//                   ),
//                 );
//               },
//             );
//           }
//           return Container();
//         },
//       ),
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DonersList extends StatefulWidget {
  const DonersList({super.key});

  @override
  State<DonersList> createState() => _DonersListState();
}

class _DonersListState extends State<DonersList> {
  final CollectionReference donorsCollection =
      FirebaseFirestore.instance.collection('Doner');

  String _searchQuery = '';

  void donorDelete(docId) {
    donorsCollection.doc(docId).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Doners Details"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: const InputDecoration(
                labelText: 'Search',
                hintText: 'Search Blood Group',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                ),
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: donorsCollection.orderBy("name").snapshots(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  final filteredData = snapshot.data.docs.where((doc) =>
                      doc["bloodgroup"]
                          .toString()
                          .toLowerCase()
                          .contains(_searchQuery.toLowerCase()));
                  return ListView.builder(
                    itemCount: filteredData.length,
                    itemBuilder: (context, index) {
                      final DocumentSnapshot donorsnap =
                          filteredData.elementAt(index);
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
                                  blurRadius: 5,
                                  spreadRadius: 15),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  child: CircleAvatar(
                                    radius: 30,
                                    child: Text(
                                      donorsnap["bloodgroup"],
                                      style: const TextStyle(fontSize: 25),
                                    ),
                                  ),
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Name: ${donorsnap["name"]}",
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "Phone: +91 ${donorsnap["phone"].toString()}",
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                  Text(
                                    "Age: ${donorsnap["age"].toString()}",
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                ],
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.people),
                                iconSize: 30,
                                color: Colors.blue,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
                return Container();
              },
            ),
          ),
        ],
      ),
    );
  }
}
