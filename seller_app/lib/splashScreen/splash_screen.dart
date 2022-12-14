import 'dart:async';

import 'package:flutter/material.dart';
import 'package:seller_app/authentication/auth_screen.dart';
import 'package:seller_app/global/global.dart';
import 'package:seller_app/mainScreens/home_screen.dart';
    
    
    class MySplashScreen extends StatefulWidget {
      const MySplashScreen({Key? key}) : super(key: key);
    
      @override
      State<MySplashScreen> createState() => _MySplashScreenState();
    }
    
    class _MySplashScreenState extends State<MySplashScreen> {

      startTimer()
      {
        ///Auth Check
        Timer(Duration(seconds: 2), () async {
        if(firebaseAuth.currentUser != null)
         {
           Navigator.push(context, MaterialPageRoute(builder: (c)=> const HomeScreen()));
         } else
           {
             Navigator.push(context, MaterialPageRoute(builder: (c)=> const AuthScreen()));

           }
           }); //Timer
      }


      @override
      void initState() {
      super.initState();

      startTimer();

    }


      @override
      Widget build(BuildContext context) {
        return Material(
          child: Container(
            color: Colors.white,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("images/splash.jpg"),

                  const SizedBox(height: 10,),
                  const Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Text(
                      "Make Pizza Since 1960s",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 12,
                        fontFamily: "Signatra",
                        letterSpacing: 3,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }
    }
    