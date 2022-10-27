import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:order_app/global/global.dart';
import 'package:order_app/models/address.dart';
import 'package:order_app/widgets/simple_app_bar.dart';
import 'package:order_app/widgets/text_field.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';



class SaveAddressScreen extends StatelessWidget
{
  final _name = TextEditingController();
  final _phoneNumber = TextEditingController();
  final _city = TextEditingController();
  final _completeAddress = TextEditingController();
  final _locationController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  List<Placemark>? placemarks;
  Position? position;


  Future<Position> _determinePosition() async {
    LocationPermission permission;

    permission = await Geolocator.checkPermission();

    if(permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if(permission == LocationPermission.denied) {
        return Future.error('Location Permissions are denied');
      }
    }

    return await Geolocator.getCurrentPosition();
  }




  void _getCurrentLocation() async {
    Position position = await _determinePosition();



    Position newPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    LocationPermission permission = await Geolocator.requestPermission();


    position = newPosition;


    placemarks = await placemarkFromCoordinates(
        position!.latitude, position!.longitude
    );

    Placemark pMark = placemarks![0];

    String fullAddress = '${pMark.subThoroughfare} ${pMark.thoroughfare}';
    _locationController.text = fullAddress;

    _city.text = '${pMark.locality}, ${pMark.country}';
    _completeAddress.text = fullAddress;
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: SimpleAppBar(title: "Order",),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text("Save Now"),
        backgroundColor: Colors.amber,
        onPressed: ()
        {
          //save address info
          if(formKey.currentState!.validate())
          {
            final model = Address(
              name: _name.text.trim(),
              phoneNumber: _phoneNumber.text.trim(),
              fullAddress: _completeAddress.text.trim(),
              city: _city.text.trim(),
            ).toJson();
            
            FirebaseFirestore.instance.collection("users")
                .doc(sharedPreferences!.getString("uid"))
                .collection("userAddress")
                .doc(DateTime.now().millisecondsSinceEpoch.toString())
                .set(model).then((value)
            {
              Fluttertoast.showToast(msg: "New Address has been saved.");
              formKey.currentState!.reset();
            });
          }
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 6,),
            const Align(
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  "New Address",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                  ),
                ),
              ),
            ),



            const SizedBox(height: 6,),



            Form(
              key: formKey,
              child: Column(
                children: [
                  MyTextField(
                    hint: "Name",
                    controller: _name,
                  ),
                  MyTextField(
                    hint: 'Phone Number',
                    controller: _phoneNumber,
                  ),

                  MyTextField(
                    hint: 'Address Line',
                    controller: _completeAddress,
                  ),
                  MyTextField(
                    hint: 'City / Country',
                    controller: _city,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 6,),

            ElevatedButton.icon(

              label: const Text(
                "Get my Location",

                style: TextStyle(color: Colors.white),
              ),
              icon: const Icon(Icons.location_on, color: Colors.white,),


              onPressed: ()
              {
                //getCurrentLocationWithAddress
                _getCurrentLocation();
              },
            ),

          ],
        ),
      ),
    );
  }
}


