import 'package:blood_donation_app/editing_page.dart';
import 'package:blood_donation_app/home_page.dart';
import 'package:blood_donation_app/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyC9Y8ICW8S-4orNfvzQ13Q9ZKTH5aV3IoU",
            authDomain: "blood-donation-app-8f1a8.firebaseapp.com",
            projectId: "blood-donation-app-8f1a8",
            storageBucket: "blood-donation-app-8f1a8.appspot.com",
            messagingSenderId: "263123763326",
            appId: "1:263123763326:web:f2a19cd618bfe87dff982f"));
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/update':(context) => const EditingPage()
      },

      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(
        child: HomePage(),
      ),
    );
  }
}
