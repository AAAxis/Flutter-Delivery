
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:firebase_storage/firebase_storage.dart' as fStorage;
import 'package:order_app/global/global.dart';
import 'package:order_app/mainScreens/home_screen.dart';
import 'package:order_app/widgets/custom_text_field.dart';
import 'package:order_app/widgets/error_dialog.dart';
import 'package:order_app/widgets/loading_dialog.dart';

import 'package:shared_preferences/shared_preferences.dart';



class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  XFile? imageXFile;
  final ImagePicker _picker = ImagePicker();



  String userImageUrl = "";


  Future<void> _getImage() async
  {
    imageXFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageXFile;
    });
  }


  Future<void> formValidation() async
  {
    if(imageXFile == null)
    {
      showDialog(
          context: context,
          builder: (c)
          {
            return ErrorDialog(
              message: "Please select an image.",
            );
          }
      );
    }
    else
    {
      if(emailController.text.isNotEmpty && nameController.text.isNotEmpty && passwordController.text.isNotEmpty)
      {
        //start uploading image
        showDialog(
            context: context,
            builder: (c)
            {
              return LoadingDialog(
                message: "Registering Account",
              );
            }
        );

        String fileName = DateTime.now().millisecondsSinceEpoch.toString();
        fStorage.Reference reference = fStorage.FirebaseStorage.instance.ref().child("users").child(fileName);
        fStorage.UploadTask uploadTask = reference.putFile(File(imageXFile!.path));
        fStorage.TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
        await taskSnapshot.ref.getDownloadURL().then((url) {
          userImageUrl = url;

          //save info to firestore
          authenticateSellerAndSignUp();
        });
      }
      else
      {
        showDialog(
            context: context,
            builder: (c)
            {
              return ErrorDialog(
                message: "Please fill all information!",
              );
            }
        );
      }
    }
  }



  void authenticateSellerAndSignUp() async
  {
    User? currentUser;


    await firebaseAuth.createUserWithEmailAndPassword(
      email: emailController.text.trim(), password: passwordController.text.trim(),
    ).then((auth) {
      currentUser = auth.user;
    }).catchError((error){
      Navigator.pop(context);
      showDialog (
          context: context,
          builder: (c) {
            return ErrorDialog(
              message: error.message.toString(),
            );
          }
      );

    });


    if(currentUser != null)
    {
      saveDataToFileStore(currentUser!).then((value) {
        Navigator.pop(context);
        ///Send user to Home Page
        Route newRoute = MaterialPageRoute(builder: (c) => HomeScreen());
        Navigator.pushReplacement(context, newRoute);
      });
    }
  }

  Future saveDataToFileStore(User currentUser) async
  {
    FirebaseFirestore.instance.collection("users").doc(currentUser.uid).set({
      "uid": currentUser.uid,
      "email": currentUser.email,
      "name": nameController.text.trim(),
      "userAvatarUrl": userImageUrl,
      "status": "approved",
      "userCart": ['garbageValue'],



    });
    ///save data locally
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences!.setString("uid", currentUser.uid);
    await sharedPreferences!.setString("email", currentUser.email.toString());
    await sharedPreferences!.setString("name", nameController.text.trim());
    await sharedPreferences!.setString("photoUrl", userImageUrl);
    await sharedPreferences!.setStringList("userCart", ['garbageValue']);

  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(height: 15,),
            InkWell(
              onTap: ()
              {
                _getImage();
              },
              child: CircleAvatar(
                radius: MediaQuery.of(context).size.width * 0.20,
                backgroundColor: Colors.white,
                backgroundImage: imageXFile==null ? null : FileImage(File(imageXFile!.path)),
                child: imageXFile == null
                    ?
                Icon(Icons.add_photo_alternate,
                  size: MediaQuery.of(context).size.width * 0.20,
                  color: Colors.grey,
                ) : null,

              ),
            ),
            const SizedBox(height: 10,),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextField(
                    data: Icons.person,
                    controller: nameController,
                    hintText: "Name",
                    isObsecre: false,
                  ),
                  CustomTextField(
                    data: Icons.email,
                    controller: emailController,
                    hintText: "Email",
                    isObsecre: false,
                  ),
                  CustomTextField(
                    data: Icons.lock,
                    controller: passwordController,
                    hintText: "Password",
                    isObsecre: true,
                  ),

                ],
              ),
            ),
            const SizedBox(height: 30,),
            ElevatedButton(
              child: const Text(
                "Sign Up",
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
                padding: EdgeInsets.symmetric(horizontal: 100, vertical: 20),
              ),
              onPressed: ()
              {
                formValidation();
              },
            ),
            const SizedBox(height: 30,),
          ],
        ),
      ),
    );
  }

}



