import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:order_app/assistantMethods/assistant_methods.dart';
import 'package:order_app/authentication/auth_screen.dart';
import 'package:order_app/authentication/login.dart';
import 'package:order_app/global/global.dart';
import 'package:order_app/models/sellers.dart';
import 'package:order_app/splashScreen/splash_screen.dart';
import 'package:order_app/widgets/sellers_design.dart';
import 'package:order_app/widgets/my_drawer.dart';
import 'package:order_app/widgets/progress_bar.dart';



class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}



class _HomeScreenState extends State<HomeScreen>
{

  restrictBlockedUsersFromUsingApp() async
  {
    await FirebaseFirestore.instance.collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .get().then((snapshot)
    {
      if(snapshot.data()!["status"] != "approved")
        {
          firebaseAuth.signOut();
          Fluttertoast.showToast(msg: "You have been Blocked");
          Navigator.push(context, MaterialPageRoute(builder: (c)=> MySplashScreen()));
        } else
          {
            clearCartNow(context);
          }
    });
  }

  @override
  void initState() {
    super.initState();

    restrictBlockedUsersFromUsingApp();
  }

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
          "Order",
          style: TextStyle(fontSize: 45, fontFamily: "Signatra"),
        ),
        centerTitle: true,
      ),
      drawer: MyDrawer(),
      body: CustomScrollView(
        slivers: [
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("sellers")
                .snapshots(),
            builder: (context, snapshot)
            {
              return !snapshot.hasData
                  ? SliverToBoxAdapter(child: Center(child: circularProgress(),),)
                  : SliverStaggeredGrid.countBuilder(
                      crossAxisCount: 1,
                      staggeredTileBuilder: (c) => StaggeredTile.fit(1),
                      itemBuilder: (context, index)
                      {
                        Sellers sModel = Sellers.fromJson(
                          snapshot.data!.docs[index].data()! as Map<String, dynamic>
                        );
                        //design for display sellers-cafes-restuarents
                        return SellersDesignWidget(
                          model: sModel,
                          context: context,
                        );
                      },
                      itemCount: snapshot.data!.docs.length,
                    );
            },
          ),
        ],
      ),
    );
  }
}
