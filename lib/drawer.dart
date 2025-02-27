
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
// google fonts
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation/Daily%20Test/prevoius.dart';
import 'package:graduation/storage_manager.dart';
import 'package:page_transition/page_transition.dart';
import 'Daily Test/My_situation_chart.dart';
import 'ProfileScreen.dart';
import 'check_connection.dart';
import 'feedback.dart';
import 'login_screen.dart';
import 'myProvider.dart';
import 'settings.dart';
import 'addMedicines.dart';
import 'medicines.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class MainDrawer extends StatefulWidget {

  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  void movePage(BuildContext context ,String route) {
    Navigator.of(context).pushReplacementNamed(route);
  }

  var userName ;
  var userAddress ;

  @override
  void initState() {
    getUser();
    super.initState();
  }

  getUser() async{
      userName = await StorageManager.read("userName");
      userAddress = await StorageManager.read("userAddress");
      setState(() {
      });

  }

  @override
  Widget build(BuildContext context) {


    return Drawer(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 120,
              width: double.infinity,
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.fromLTRB(20,30,20,10),
              color:Theme.of(context).secondaryHeaderColor ,
              child: Row(
                  children: [
                    CircleAvatar(minRadius: 25, backgroundColor: Colors.white,child: Icon(Icons.perm_identity,),),
                    SizedBox(width: 10,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("$userName ",
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                        Text("$userAddress ",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            SizedBox(height: 20,),
            ListTile(
              onTap: (){
                Navigator.push(context,PageTransition(
                  alignment: Alignment.centerRight,
                  curve: Curves.easeInOut,
                  duration: Duration(seconds: 2),
                  type: PageTransitionType.scale,child: Medicines(),),);
                // Navigator.of(context).push(MaterialPageRoute(builder: (context) => Medicines()),);
                },
              leading: Icon(Icons.medical_services,size: 26,color: Theme.of(context).secondaryHeaderColor),
              title: LocaleText("My Medicines",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
            ),
            ListTile(
              // if the user reach the maximum number of adding medicines 10
              onTap: (){
                if(Medicines.medicName.length==10 || Medicines.covidMedicName.length==10)
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.INFO,
                    headerAnimationLoop: false,
                    title:  'Alarm',
                    desc:  'You are reach the maximum number of adding medicines',
                    buttonsTextStyle: TextStyle(color: Colors.black),
                    showCloseIcon: true,
                  )..show();
                else
                  Navigator.push(context,PageTransition(
                    alignment: Alignment.centerRight,
                    curve: Curves.easeInOut,
                    duration: Duration(seconds: 1),
                    type: PageTransitionType.scale,child: AddMedicines(),),);
                },
              leading: Icon(Icons.add_alert_rounded,size: 26,color: Theme.of(context).secondaryHeaderColor,),
              title: LocaleText("Add Medicine",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
            ),
            ListTile(
              onTap: () async{
                if(await getConnection(context))
                Navigator.push(context,PageTransition(
                  alignment: Alignment.centerRight,
                  curve: Curves.easeInOut,
                  duration: Duration(seconds: 1),
                  type: PageTransitionType.scale,child: BarChartSample(),),);
              },
              leading: Icon(Icons.assignment_turned_in,size: 26,color: Theme.of(context).secondaryHeaderColor,),
              title: LocaleText("My Situation",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
            ),
            Divider(thickness: 2,),
            ListTile(
              onTap: () {
                Navigator.push(context,PageTransition(
                  alignment: Alignment.centerRight,
                  curve: Curves.easeInOut,
                  duration: Duration(seconds: 1),
                  type: PageTransitionType.scale,child: FeedbackScreen(),),);
                },
              leading: Icon(Icons.feedback_rounded,size: 26,color: Theme.of(context).secondaryHeaderColor,),
              title: LocaleText("Feedback",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
            ),
            ListTile(
              onTap: (){
                Navigator.push(context,PageTransition(
                  alignment: Alignment.centerRight,
                  curve: Curves.easeInOut,
                  duration: Duration(seconds: 1),
                  type: PageTransitionType.scale,child: Settings(),),);
                } ,
              leading: Icon(Icons.settings,size: 26,color: Theme.of(context).secondaryHeaderColor,),
              title: LocaleText("Settings",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
            ),
            ListTile(
              onTap: ()=>Navigator.push(context,PageTransition(
                alignment: Alignment.centerRight,
                curve: Curves.easeInOut,
                duration: Duration(seconds: 1),
                type: PageTransitionType.scale,child: about(),),),
                  // Navigator.of(context).push(MaterialPageRoute(builder: (context) => about()),),
              leading: Icon(Icons.info,size: 26,color: Theme.of(context).secondaryHeaderColor,),
              title: LocaleText("About",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
            ),
            SizedBox(height: 110,),
            Divider(thickness: 2,),
            ListTile(
              onTap: () async{
              await signOut();
              },
              leading: Icon(Icons.logout,size: 26,color: Theme.of(context).secondaryHeaderColor,),
              title: LocaleText("Logout",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }

  signOut() async{
    //this function is called when the user press the 'log out' in the menu.
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
  showLoading(context) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor:Colors.white,
            content: Container(
                height: 200,
                child: Center(
                  child: CircularProgressIndicator(strokeWidth: 6,),
                )),
          );
        });
  }

  // about Screen
  Widget about(){
    return Scaffold(
      appBar: AppBar(
        title: LocaleText("About",style: GoogleFonts.merienda(textStyle:TextStyle(fontWeight: FontWeight.bold,fontSize: 24)) ,),
        centerTitle: true,
      ),
      body:SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(15,50,15,30),
            child:Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.lightBlue.withOpacity(0.5),
                      Colors.blue.withOpacity(0.5),
                      Colors.lightBlue.withOpacity(0.5),
                      // Colors.lightBlue.withOpacity(0.5),
                    ],
                  )
                ),
                child: LocaleText("about_content",
                  style:GoogleFonts.merienda(textStyle: TextStyle(fontSize: 22)) ,
                ),
              ),
            ),
    );
  }

}
