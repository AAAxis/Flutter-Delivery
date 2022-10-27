import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:driver_app/assistantMethods/get_current_location.dart';
import 'package:driver_app/global/global.dart';
import 'package:driver_app/mainScreens/home_screen.dart';
import 'package:driver_app/mainScreens/parcel_picking_screen.dart';
import 'package:driver_app/splashScreen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:driver_app/models/address.dart';


class ShipmentAddressDesign extends StatelessWidget
{
  final Address? model;
  final String? orderStatus;
  final String? orderId;
  final String? sellerId;
  final String? orderByUser;

  ShipmentAddressDesign({this.model, this.orderStatus, this.orderId, this.sellerId, this.orderByUser});



  confirmedParcelShipment(BuildContext context, String getOrderID, String sellerId, String purchaserId)
  {
    FirebaseFirestore.instance
        .collection("orders")
        .doc(getOrderID)
        .update({
      "riderUID": sharedPreferences!.getString("uid"),
      "riderName": sharedPreferences!.getString("name"),
      "status": "picking",
      "address": completeAddress,
    });

    //send rider to shipmentScreen
    Navigator.push(context, MaterialPageRoute(builder: (context) => ParcelPickingScreen(
      purchaserId: purchaserId,
      purchaserAddress: model!.fullAddress,
      sellerId: sellerId,
      getOrderID: getOrderID,
    )));
  }



  @override
  Widget build(BuildContext context)
  {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
              'Shipping Details:',
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)
          ),
        ),
        const SizedBox(
          height: 5.0,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          width: MediaQuery.of(context).size.width,
          child: Table(
            children: [
              TableRow(
                children: [
                  const Text(
                    "Name",
                    style: TextStyle(color: Colors.black),
                  ),
                  Text(model!.name!),
                ],
              ),
              TableRow(
                children: [
                  const Text(
                    "Phone Number",
                    style: TextStyle(color: Colors.black),
                  ),
                  Text(model!.phoneNumber!),
                ],
              ),
              TableRow(
                children: [
                  const Text(
                    "Full Address",
                    style: TextStyle(color: Colors.black),
                  ),
                  Text(model!.fullAddress!),
                ],
              ),
              TableRow(
                children: [
                  const Text(
                    "City / Country",
                    style: TextStyle(color: Colors.black),
                  ),
                  Text(model!.city!),
                ],
              ),
            ],


          ),
        ),


        orderStatus == "ended"
            ? Container()
            : Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: InkWell(
              onTap: ()
              {
                UserLocation uLocation = UserLocation();
                uLocation.getCurrentLocation();

                confirmedParcelShipment(context, orderId!, sellerId!, orderByUser!);
              },

              child: Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.blue,
                        Colors.blue,
                      ],
                      begin:  FractionalOffset(0.0, 0.0),
                      end:  FractionalOffset(1.0, 0.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp,
                    )
                ),
                width: MediaQuery.of(context).size.width - 40,
                height: 45,
                child: const Center(
                  child: Text(
                    "Confirm",
                    style: TextStyle(color: Colors.white, fontSize: 15.0),
                  ),
                ),
              ),
            ),
          ),
        ),


        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: InkWell(
              onTap: ()
              {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
              },
              child: Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.red,
                        Colors.red,
                      ],
                      begin:  FractionalOffset(0.0, 0.0),
                      end:  FractionalOffset(1.0, 0.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp,
                    )
                ),
                width: MediaQuery.of(context).size.width - 40,
                height: 45,
                child: const Center(
                  child: Text(
                    "Go Back",
                    style: TextStyle(color: Colors.white, fontSize: 15.0),
                  ),
                ),
              ),
            ),
          ),
        ),

        SizedBox(height: 20,),
      ],
    );
  }
}
