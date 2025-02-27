//this page is where the user enters a new password in case he forgot his current password

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:graduation/LoadingScreen.dart';
import 'check_connection.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<ForgotPassword> {
  var _email;
 var controller=TextEditingController();
  SendLink() async {//this function sends a link to the user's gmail
    var formData = formstate.currentState;
    if (formData!.validate()) {
      if(await getConnection(context)){
        try {
          await FirebaseAuth.instance.sendPasswordResetEmail(email: controller.text).whenComplete((){
            AwesomeDialog(
              context: context,
              dialogType: DialogType.INFO,
              animType: AnimType.BOTTOMSLIDE,
              title:' ',
              desc:
              Locales.string(context,'We have sent a link to your email,check your inbox and set a new password in the link'),
            )..show();
          });
        } on FirebaseAuthException catch (e) {
          if (e.code == "user-not-found") {
            Navigator.of(context).pop();
            AwesomeDialog(
              context: context,
              dialogType: DialogType.WARNING,
              animType: AnimType.BOTTOMSLIDE,
              title: Locales.string(context,'Warning!'),
              desc: Locales.string(context,'User with the email provided does not exist'),
              btnCancelOnPress: () {},
              btnOkOnPress: () {},
            )..show();
          }
        }
      }
    }
  }

  GlobalKey<FormState> formstate = new GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).secondaryHeaderColor),
        backgroundColor: Theme.of(context).canvasColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
       child: Container(
         decoration: BoxDecoration(
             borderRadius: BorderRadius.circular(20),
             boxShadow: [
               BoxShadow(
                 color: Theme.of(context).shadowColor,
                 spreadRadius: 4,
                 blurRadius: 5,
                 offset: Offset(0, 2), // changes position of shadow
               ),
             ],
             color: Colors.white
         ),
         width: double.infinity,
         margin: EdgeInsets.all(20),
         padding: EdgeInsets.symmetric(horizontal: 15,vertical: 30),
         child: Column(children: <Widget>[
           Form(
             key: formstate,
             child: Column(
               children: [
                 Container(
                     child: Image.asset(
                   "assets/LogoApp3.png",
                   width: 210,
                   height: 210,
                 )),
                 LocaleText("Set a new password",
                     style: TextStyle(
                         fontWeight: FontWeight.bold,
                         color: Theme.of(context).secondaryHeaderColor,
                         fontSize: 20.0)),
                 Container(
                   width: 260,
                   margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
                   child: TextFormField(
                     controller: controller,
                     onSaved: (value) {
                       setState(() {
                         _email = value;
                       });
                     },
                     validator: (value) {
                       if (value!.isEmpty) {
                         return Locales.string(context,"please,enter your email");
                       }
                       if (RegExp(r'^[\s]+$').hasMatch(value) ==
                           true) {
                         return Locales.string(context, 'dont leave any field empty');
                       }
                       if ((value.endsWith("@gmail.com")) ==
                           false) {
                         return Locales.string(context,'enter a valid email(gmail)');
                       }
                       if ((value.startsWith("@gmail.com")) ==
                           true) {
                         return Locales.string(context,'enter a valid email(gmail)');
                       }
                       else {
                         value = value.trim();
                       }
                     },
                     decoration: InputDecoration(
                         prefixIcon: Icon(Icons.person,
                             size: 30, color: Theme.of(context).secondaryHeaderColor),
                         hintText: Locales.string(context,"Enter your Email"),
                         hintStyle:
                             TextStyle(color: Theme.of(context).secondaryHeaderColor, fontSize: 14),
                         enabledBorder: UnderlineInputBorder(
                           borderSide: BorderSide(color: Theme.of(context).secondaryHeaderColor),
                         )),
                     keyboardType: TextInputType.emailAddress,
                   ),
                 ),
                 SizedBox(
                   height: 50,
                 ),
                 ElevatedButton(
                     onPressed: () async {
                         await SendLink();
                     },
                     style: ElevatedButton.styleFrom(
                       primary: Theme.of(context).secondaryHeaderColor,
                       padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                     ),
                     child: LocaleText("Send to email",
                         style: TextStyle(fontSize: 18.0))),
               ],
             ),
           ),
         ]),
       ),
      ),
    );
  }
}
