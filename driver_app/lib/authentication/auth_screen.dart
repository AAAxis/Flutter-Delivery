import 'package:flutter/material.dart';

import 'login.dart';
import 'register.dart';

    
    
    class AuthScreen extends StatefulWidget {
      const AuthScreen({Key? key}) : super(key: key);
    
      @override
      State<AuthScreen> createState() => _AuthScreenState();
    }
    
    class _AuthScreenState extends State<AuthScreen> {
      @override
      Widget build(BuildContext context) {
        return DefaultTabController(
          length: 2,
          child: Scaffold(
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
            automaticallyImplyLeading: false,
            title: const Text("Dominos Pizza",
            style: TextStyle(
              fontSize: 45,
              color: Colors.white,
              fontFamily: "Bebas"
             ),
            ),
            centerTitle: true,
            bottom: const TabBar(
                tabs: [
              Tab(
                icon: Icon(Icons.lock, color: Colors.white,),
                    text: "Login",
              ),
              Tab(
                icon: Icon(Icons.lock, color: Colors.white,),
                text: "Register",
              ),
             ],
              indicatorColor: Colors.white,
              indicatorWeight: 6,
            ),
          ),
            body: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Colors.blue,
                    Colors.blue,
                  ],
                ),
              ),
              child: TabBarView(
                children: [
                  LoginScreen(),
                  RegisterScreen(),
                ],
              )
            ),
        ),
        );
      }
    }
    