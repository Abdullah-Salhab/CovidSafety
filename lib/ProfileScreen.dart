//this is where the user can view his profile and edit it if he wants to,and he can log out in this one
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:graduation/EditProfile.dart';
import 'package:graduation/LoadingScreen.dart';
import 'package:graduation/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_locales/flutter_locales.dart';

import 'package:provider/provider.dart';
import 'addMedicines.dart';
import 'check_connection.dart';
import 'medicines.dart';
import 'myProvider.dart';
import 'storage_manager.dart';

class ProfilePage extends StatefulWidget {

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var username;
  var gender;
  var address;
  var age;
  var phone;
  var email;
  var country;

  DocumentReference userDoc = FirebaseFirestore.instance
      .collection("Users")
      .doc(FirebaseAuth.instance.currentUser?.uid);

  signOut() async{
    //this function is called when the user press the 'log out' in the menu.
    //delete all cache memory
  showLoading(context);
  print("============ logout and delete all data from shared preference =================");
  // cancel all the previous notifications
  await flutterLocalNotificationsPlugin.cancelAll();
  setState(()  {
    // set the initial values for the variables
    Medicines.medicName=[];
    Medicines.medicTaken=[];
    Medicines.medicTimesAdded=[];
    Medicines.medicTimesId=[[1, 2, 3], [4, 5, 6], [7, 8, 9], [10, 11, 12], [13, 14, 15],
      [16, 17, 18], [19, 20, 21], [22, 23, 24], [25, 26, 27], [28, 29, 30]];
    Medicines.covidMedicName=[];
    Medicines.covidMedicTimesAdded=[];
    Medicines.covidMedicTaken=[];
    Medicines.covidMedicTimesId=[[31, 32, 33], [34, 35, 36], [37, 38, 39],
      [40, 41, 42], [43, 44, 45], [46, 47, 48], [49, 50, 51], [52, 53, 54],
      [55, 56, 57], [58, 59, 60]];
    // set light theme
    if(context.read<MyProvider>().isNight)
      context.read<MyProvider>().changeNight();
  });
  // clear shared preferences
  await StorageManager.clearData();
  await FirebaseAuth.instance.signOut();
  Navigator.pushReplacement(
      context,PageTransition(
    alignment:Alignment.bottomCenter,
    curve:Curves.easeInOut,
    duration: Duration(seconds: 1),
    type: PageTransitionType.scale,
    child: loginScreen(),
  ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // backgroundColor: Theme.of(context).canvasColor,
          title: LocaleText(
            "Profile",
            style: TextStyle( fontSize: 19),
          ),
          elevation: 0,
          centerTitle: true,
          actions: <Widget>[
            PopupMenuButton(
                //this widget is the pop up menu where the edit profile and log out are contained
                onSelected: (result) async{
                  if(result==0) {
                    Navigator.push(
                        context,PageTransition(
                      alignment:Alignment.bottomCenter,
                      curve:Curves.easeInOut,
                      duration: Duration(seconds: 1),
                      type: PageTransitionType.size,
                      child: editProfile(),
                    ));
                  }else if(result==1){
                    await signOut();
                  }
                },
                itemBuilder: (context) => [
                  PopupMenuItem(
                        value: 0,
                        child: Row(
                          children: [
                            Icon(
                              Icons.edit,
                              size: 19,color: Theme.of(context).secondaryHeaderColor
                            ),
                            SizedBox(width:10),
                            LocaleText("Edit_profile",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold)),
                            Expanded(child: SizedBox()),
                            Icon(
                              Icons.arrow_forward_ios_sharp,
                              size: 16,color: Theme.of(context).secondaryHeaderColor
                            ),
                          ],
                        ),
                      ),
                  PopupMenuItem(
                    value: 1,
                    child: Row(
                      children: [
                        Icon(
                          Icons.logout,
                          size: 19,color: Theme.of(context).secondaryHeaderColor

                        ),
                        SizedBox(width: 10,),
                        LocaleText("Log out",
                            style: TextStyle(
                                fontWeight: FontWeight.bold)),
                        Expanded(child: SizedBox()),
                        Icon(
                          Icons.arrow_forward_ios_sharp,
                          size: 16,color: Theme.of(context).secondaryHeaderColor
                        ),
                      ],
                    ),
                  ),
                    ])
          ],
        ),
        body: StreamBuilder(
          stream: userDoc.snapshots(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              //this statement checks whether the user has data in the firestore,if true,load the profile page with that user's information
              return Center(
                  child: ListView(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0.0, 0, 70.0),
                    child: Column(children: [
                      Column(
                        children: [
                          SizedBox(height: 30,),
                          CircleAvatar(
                            child: Icon(
                              Icons.person,
                              size: 40,
                              color: Colors.white,
                            ),
                            radius: 35.0,
                          ),
                          SizedBox(height: 10),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("${snapshot.data['username']}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18)),
                              Text("${snapshot.data['address']}",
                                  style: TextStyle(
                                      fontSize: 10)),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 40),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          elevation: 4,
                          child: Column(
                            children: [
                              //row for each details
                              ListTile(
                                leading: Icon(
                                  Icons.email,
                              color: Theme.of(context).secondaryHeaderColor
                                ),
                                title: Text("${snapshot.data['email']}"),
                              ),
                              Divider(
                                height: 0.6,
                                color: Colors.black87,
                              ),
                              ListTile(
                                leading: Icon(Icons.phone,color: Theme.of(context).secondaryHeaderColor),
                                title: Text("${snapshot.data['phone']}"),
                              ),
                              Divider(
                                height: 0.6,
                                color: Colors.black87,
                              ),
                              ListTile(
                                leading: Icon(Icons.location_on,color: Theme.of(context).secondaryHeaderColor),
                                title: Text("${snapshot.data['country']}"),
                              ),
                              Divider(
                                height: 0.6,
                                color: Colors.black87,
                              ),
                              ListTile(
                                leading: Icon(Icons.group_sharp,color: Theme.of(context).secondaryHeaderColor),
                                title: Text("${snapshot.data['gender']}"),
                              ),
                              Divider(
                                height: 0.6,
                                color: Colors.black87,
                              ),
                            ],
                          ),
                        ),
                      )
                    ]),
                  )
                ],
              ));
            }
            return Center(//this widget will be displayed until the page loads the data,it acts as a loading screen
              child: CircularProgressIndicator(
                // color: Color(0xFF4C4CDB),
                strokeWidth: 2,
              ),
            );
          },
        ));
  }
}
