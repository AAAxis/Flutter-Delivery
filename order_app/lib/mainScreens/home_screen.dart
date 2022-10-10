import 'package:flutter/material.dart';
import 'package:order_app/authentication/auth_screen.dart';
import 'package:order_app/global/global.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}



class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.blue.shade800,
                Colors.blue.shade800,
              ],
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset (1.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp,
            ),
          ),
        ),
        title: Text(
            sharedPreferences!.getString("name")!,

        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text("Logout"),
          style: ElevatedButton.styleFrom(
            primary:  Colors.red,
          ),
          onPressed: ()
          {
              firebaseAuth.signOut().then((value) {
                Navigator.push(context, MaterialPageRoute(builder: (c)=> const AuthScreen()));
              });

          },
        ),
      ),
    );
  }
}

