import 'package:flutter/material.dart';
import 'package:driver_app/mainScreens/home_screen.dart';


class StatusBanner extends StatelessWidget
{
  final bool? status;
  final String? orderStatus;

  StatusBanner({this.status, this.orderStatus});

  @override
  Widget build(BuildContext context)
  {
    String? message;
    IconData? iconData;

    status! ? iconData = Icons.done : iconData = Icons.cancel;
    status! ? message = "New" : message = "Unsuccessful";

    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white10,
              Colors.white10,
            ],
            begin:  FractionalOffset(0.0, 0.0),
            end:  FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp,
          )
      ),
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [


          Text(
            orderStatus == "ended"
                ? "$message Task"
                : "$message Task",
            style: const TextStyle(fontSize: 42.0, letterSpacing: 3, color: Colors.black, fontFamily: "Signatra"),
          ),

        ],
      ),
    );
  }
}
