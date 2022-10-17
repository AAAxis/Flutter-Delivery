import 'package:admin_app/authentication/login_screen.dart';
import 'package:admin_app/main_screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    // Replace with actual values
      options: const FirebaseOptions(
      apiKey: "AIzaSyDst_lvJiVQiSQmrL5n8a1ezvxL1JJ6Wv4",
      appId: "1:423720830559:web:a19c5cc7a5bb8811623dea",
      messagingSenderId: "423720830559",
      projectId: "mystical-height-359721",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget
{
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Admin Web Portal',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: FirebaseAuth.instance.currentUser == null ? const LoginScreen() : const HomeScreen(),
    );
  }
}



