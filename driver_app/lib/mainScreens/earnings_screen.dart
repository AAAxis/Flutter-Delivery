import 'package:flutter/material.dart';
import 'package:driver_app/global/global.dart';
import 'package:driver_app/splashScreen/splash_screen.dart';


class EarningsScreen extends StatefulWidget
{
  const EarningsScreen({Key? key}) : super(key: key);

  @override
  _EarningsScreenState createState() => _EarningsScreenState();
}




class _EarningsScreenState extends State<EarningsScreen>
{
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Text(
                "€ " + previousRiderEarnings,
                style: const TextStyle(
                  fontSize: 80,
                  color: Colors.white,
                  fontFamily: "Signatra"
                ),
              ),

              const Text(
                "Total Earnings",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey,
                    letterSpacing: 3,
                    fontWeight: FontWeight.bold,
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }
}
