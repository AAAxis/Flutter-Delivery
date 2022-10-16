import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:driver_app/assistantMethods/assistant_methods.dart';
import 'package:driver_app/widgets/my_drawer.dart';
import 'package:driver_app/widgets/order_card.dart';
import 'package:driver_app/widgets/progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:driver_app/authentication/auth_screen.dart';
import 'package:driver_app/global/global.dart';




class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}



class _HomeScreenState extends State<HomeScreen>
{


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
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
        ),
        title: const Text(
          "New Orders",
          style: TextStyle(fontSize: 45, fontFamily: "Signatra"),
        ),
        centerTitle: true,
      ),
      drawer: MyDrawer(),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("orders")
            .where("status", isEqualTo: "normal")
            .orderBy("orderTime", descending: true)
            .snapshots(),
        builder: (c, snapshot)
        {
          return snapshot.hasData
              ? ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (c, index)
            {
              return FutureBuilder<QuerySnapshot>(
                future: FirebaseFirestore.instance
                    .collection("items")
                    .where("itemID", whereIn: separateOrderItemIDs((snapshot.data!.docs[index].data()! as Map<String, dynamic>) ["productIDs"]))
                    .where("orderBy", whereIn: (snapshot.data!.docs[index].data()! as Map<String, dynamic>)["uid"])
                    .orderBy("publishedDate", descending: true)
                    .get(),
                builder: (c, snap)
                {
                  return snap.hasData
                      ? OrderCard(
                    itemCount: snap.data!.docs.length,
                    data: snap.data!.docs,
                    orderID: snapshot.data!.docs[index].id,
                    seperateQuantitiesList: separateOrderItemQuantities((snapshot.data!.docs[index].data()! as Map<String, dynamic>)["productIDs"]),
                  )
                      : Center(child: circularProgress());
                },
              );
            },
          )
              : Center(child: circularProgress(),);
        },
      ),
    );
  }
}
