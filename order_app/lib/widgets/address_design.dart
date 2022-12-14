import 'package:flutter/material.dart';
import 'package:order_app/assistantMethods/address_changer.dart';
import 'package:order_app/mainScreens/placed_order_screen.dart';
import 'package:order_app/maps/maps.dart';
import 'package:order_app/models/address.dart';
import 'package:provider/provider.dart';

class AddressDesign extends StatefulWidget
{
  final Address? model;
  final int? currentIndex;
  final int? value;
  final String? addressID;
  final String? totalAmount;
  final String? sellerUID;

  AddressDesign({
    this.model,
    this.currentIndex,
    this.value,
    this.addressID,
    this.totalAmount,
    this.sellerUID,
  });

  @override
  _AddressDesignState createState() => _AddressDesignState();
}



class _AddressDesignState extends State<AddressDesign>
{
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()
      {
        //select this address
        Provider.of<AddressChanger>(context, listen: false).displayResult(widget.value);
      },
      child: Card(
        color: Colors.cyan.withOpacity(0.4),
        child: Column(
          children: [

            //address info
            Row(
              children: [
                Radio(
                  groupValue: widget.currentIndex!,
                  value: widget.value!,
                  activeColor: Colors.amber,
                  onChanged: (val)
                  {
                    //provider
                    Provider.of<AddressChanger>(context, listen: false).displayResult(val);
                    print(val);
                  },
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Table(
                        children: [
                          TableRow(
                            children: [
                              const Text(
                                "Name: ",
                                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                              ),
                              Text(widget.model!.name.toString()),
                            ],
                          ),
                          TableRow(
                            children: [
                              const Text(
                                "Phone Number: ",
                                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                              ),
                              Text(widget.model!.phoneNumber.toString()),
                            ],
                          ),
                          TableRow(
                            children: [
                              const Text(
                                "Address: ",
                                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                              ),
                              Text(widget.model!.fullAddress.toString()),
                            ],
                          ),

                          TableRow(
                            children: [
                              const Text(
                                "City / Country: ",
                                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                              ),
                              Text(widget.model!.city.toString()),
                            ],
                          ),

                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),

            //button
            ElevatedButton(
              child: const Text("Check on Maps"),
              style: ElevatedButton.styleFrom(
                primary: Colors.black54,
              ),
              onPressed: ()
              {

                MapsUtils.openMapWithAddress(widget.model!.fullAddress!);
              },
            ),

            //button
            widget.value == Provider.of<AddressChanger>(context).count 
                ? ElevatedButton(
                      child: const Text("Proceed"),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                      ),
                      onPressed: ()
                      {
                        Navigator.push(
                            context, MaterialPageRoute(
                            builder: (c)=> PlacedOrderScreen(
                              addressID: widget.addressID,
                              totalAmount: widget.totalAmount,
                              sellerUID: widget.sellerUID,
                            )
                          )
                        );
                      },
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
