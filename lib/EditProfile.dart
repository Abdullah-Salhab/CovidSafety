//this page is where the user goes if he want to update his information


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:graduation/LoadingScreen.dart';
import 'package:graduation/ProfileScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:graduation/storage_manager.dart';
import 'package:page_transition/page_transition.dart';
import 'check_connection.dart';
import 'package:connectivity/connectivity.dart';
import 'package:provider/provider.dart';
import 'myProvider.dart';

class editProfile extends StatefulWidget {
  const editProfile({Key? key}) : super(key: key);

  @override
  _editProfileState createState() => _editProfileState();
}

class _editProfileState extends State<editProfile> {
  bool visiblePassword = true;
  var _gender = "Male";
  var userName;
  var email;
  var phone;
  var address;
  var country;

  var countries = [
    "amman",
    "madaba",
    "zarqa",
    "jerash",
    "ma'an",
    "irbid",
    "tafeleh",
    "ajloun",
    "mafra'a",
    "karak",
    "aqaba",
    "balqa'a",
  ];
  DocumentReference userDoc=FirebaseFirestore.instance.collection("Users").doc(
      FirebaseAuth.instance.currentUser?.uid
  );

  trans() async{
    FirebaseFirestore.instance.runTransaction((transaction) async{
      DocumentSnapshot docSnap=await transaction.get(userDoc);
      if(docSnap.exists){
        transaction.update(userDoc,{
          "username": userName,
          "phone": phone,
          "address": address,
          "gender": _gender,
          "country": country,
        });
        StorageManager.saveData("userName", userName);
        StorageManager.saveData("userAddress", address);
      }
    }).whenComplete((){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor:Theme.of(context).secondaryHeaderColor,
          content:
          LocaleText("your informations have been updated!")));
      Navigator.of(context).pop();// this replace loading screen
      // Navigator.of(context).pop();// this replace edit screen
      // Navigator.of(context).pop();// this replace profile screen
      Navigator.pop(context,PageTransition(// this replace edit screen
        alignment: Alignment.center,
        curve: Curves.easeInOut,
        duration: Duration(seconds: 1),
        type: PageTransitionType.scale,child: ProfilePage(),),);
    });

  }

  updateUserInformation() async {
    var formData = formS.currentState;
    if (formData!.validate()) {
      if (await getConnection(context)) {
        showLoading(context);
        formData.save();
        try {
          await trans();
          return "updated successfully";
        } catch (e) {}
      }
    }
   else {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.ERROR,
          animType: AnimType.BOTTOMSLIDE,
          title: Locales.string(context,'Warning!'),
          desc: Locales.string(context,'one or more of the provided updates are not valid,try again'),
        )..show();
      }
  }

  GlobalKey<FormState> formS = new GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Theme.of(context).canvasColor,
        title: LocaleText(
          "Edit_profile",
          style:
          TextStyle( fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body:StreamBuilder(
        stream:userDoc.snapshots(),
        builder:(context,AsyncSnapshot snapshot){
          if((snapshot.hasData ||snapshot.data != null)){
            return Center(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      width: 290,
                      child: Form(
                        key: formS,
                        child: Column(
                          children: <Widget>[
                            SizedBox(height:20),
                            TextFormField(
                              initialValue: "${snapshot.data['username']}",
                              onSaved: (value) {
                                setState(() {
                                  userName = value!;
                                });
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return Locales.string(context,'please,enter your username');
                                }
                                if (RegExp(r'^[a-zA-Z0-9_\s]+$').hasMatch(value) ==
                                    false) {
                                  return Locales.string(context,'Username cant contains special characters other than (_)');
                                }
                                if (RegExp(r'^[\s]+$').hasMatch(value) == true) {
                                  return Locales.string(context,'dont leave any field empty');
                                }
                                if (value.length <= 2) {
                                  return Locales.string(context,'the username cannot be less than 2 letters');
                                } else {
                                  value = value.trim();
                                }
                              },
                              //text field for the user name
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.person,
                                    size: 20,color: Theme.of(context).secondaryHeaderColor ),
                                hintText: Locales.string(context,"User name"),
                                labelText: Locales.string(context,"Username"),
                                hintStyle:
                                TextStyle(fontSize: 14),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                ),
                              ),
                              keyboardType: TextInputType.text,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            TextFormField(
                              //text field for the phone number
                              initialValue: "${snapshot.data['phone']}",
                              enableInteractiveSelection: false,
                              onSaved: (value) {
                                setState(() {
                                  phone = value!;
                                });
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return Locales.string(context,"please,enter your phone number");
                                }
                                if (value.contains(".") || value.contains("-")) {
                                  return Locales.string(context,'please,enter numbers only');
                                }
                                if (RegExp(r'^[\s]+$').hasMatch(value) == true) {
                                  return Locales.string(context,'dont leave any field empty');
                                }
                                if ((value.startsWith("079") ||
                                    value.startsWith("078") ||
                                    value.startsWith("077")) ==
                                    false) {
                                  return Locales.string(context,"your number should start with 079 or 078 or 077");
                                }
                                if (value.length != 10) {
                                  return Locales.string(context,"your number must be exactly 10 digits");
                                } else {
                                  value = value.trim();
                                }
                              },
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.phone,
                                    size: 20,color: Theme.of(context).secondaryHeaderColor),
                                labelText: Locales.string(context, "Phone Number"),
                                hintText: Locales.string(context, "Phone Number"),
                                hintStyle:
                                TextStyle( fontSize: 14),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                  ),
                              ),
                              keyboardType: TextInputType.number,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            TextFormField(
                              //text field for the address
                              initialValue: "${snapshot.data['address']}",
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.location_on,
                                    size: 20,color: Theme.of(context).secondaryHeaderColor),
                                labelText: Locales.string(context, "Address"),
                                hintText: Locales.string(context, "Address"),
                                hintStyle:
                                TextStyle( fontSize: 14),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                ),
                              ),
                              keyboardType: TextInputType.text,
                              onSaved: (value) {
                                address = value;
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return Locales.string(context,"please,enter your address");
                                }
                                if (RegExp(r'^[\s]+$').hasMatch(value) == true) {
                                  return Locales.string(context,'dont leave any field empty');
                                } else {
                                  value = value.trim();
                                }
                              },
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            TextFormField(
                              //text field for the country
                              initialValue: "${snapshot.data['country']}",
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.location_city,
                                    size: 20,color: Theme.of(context).secondaryHeaderColor),
                                labelText: Locales.string(context, "Country"),
                                hintText: Locales.string(context, "Country"),
                                hintStyle:
                                TextStyle( fontSize: 14),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                ),
                              ),
                              keyboardType: TextInputType.text,

                              onSaved: (value) {
                                country = value!.trim();
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return Locales.string(context,"please,enter your country");
                                }
                                if (RegExp(r'^[\s]+$').hasMatch(value) == true) {
                                  return Locales.string(context,'dont leave any field empty');
                                }
                                if ((countries.contains(value.toLowerCase()) ||
                                    value.toLowerCase() == "madaba" ||
                                    value.toLowerCase() == "zarqa" || countries.contains(value.trim())) ==
                                    false) {
                                  return Locales.string(context,"hint:amman,zarqa,mafra'a,madaba,balqa'a,tafeleh");
                                } else {
                                  value = value.trim();
                                }
                              },
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            LocaleText(
                              "Gender",
                              style:
                              TextStyle( fontSize: 18),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            GestureDetector(
                              onTap: (){
                                setState(() {
                                  _gender="Male";
                                });
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      border: Border.all(
                                           width: 1),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Theme.of(context).canvasColor,
                                            spreadRadius: 1),
                                      ]),
                                  child: SizedBox(
                                      height: 30,
                                      width: 250,
                                      child: Row(
                                        children: [
                                          Radio(
                                            value: "Male",
                                            groupValue: _gender,
                                            onChanged: (String? value) {
                                              setState(() {
                                                _gender = value!;
                                              });
                                            },
                                            activeColor:  Theme.of(context).secondaryHeaderColor,
                                            toggleable: true,
                                          ),
                                          LocaleText("Male"),
                                        ],
                                      ))
                              ),
                            ),
                            SizedBox(height: 9),
                            GestureDetector(
                              onTap: (){
                                setState(() {
                                  _gender="Female";
                                });
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      border: Border.all( width: 1),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Theme.of(context).canvasColor,
                                            spreadRadius: 1),
                                      ]),
                                  child: SizedBox(
                                      height: 30,
                                      width: 250,
                                      child: Row(
                                        children: [
                                          Radio(
                                            value: "Female",
                                            groupValue: _gender,
                                            onChanged: (String? value) {
                                              setState(() {
                                                _gender = value!;
                                              });
                                            },
                                            activeColor: Theme.of(context).secondaryHeaderColor,
                                            toggleable: true,
                                          ),
                                          LocaleText(
                                            "Female"
                                          ),
                                        ],
                                      ))),
                            ),
                            SizedBox(height: 20),
                            ElevatedButton(
                                onPressed: () async {
                                  await updateUserInformation();
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                                child: LocaleText(
                                  "Edit",
                                  style: TextStyle(fontSize: 17),
                                )),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );}
          return Center(
            child: CircularProgressIndicator(
              strokeWidth: 2,
            ),
          );
        }
      ),
    );
  }
}
