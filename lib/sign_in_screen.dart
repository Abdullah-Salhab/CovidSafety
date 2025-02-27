//this is where the user sign in with his account,or click 'forgot your password?' in case he forgot his password and what to set a new one

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graduation/Dashboard.dart';
import 'Forgot_Password.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'LoadingScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_locales/flutter_locales.dart';

import 'check_connection.dart';

class signInScreen extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<signInScreen> {
  bool isVisible = true;
  var email;
  var password;

  signInUser() async {
    //this function signs the user in the app
    var formData = forms.currentState;
    if (formData!.validate() ) {
      if(await getConnection(context)){
        formData.save();
        try {
          showLoading(context);
          UserCredential userCredential = await FirebaseAuth.instance
              .signInWithEmailAndPassword(email: email, password: password);
          return userCredential;
        } on FirebaseAuthException catch (e) {
          if (e.code == "user-not-found") {
            Navigator.of(context).pop();
            AwesomeDialog(
              context: context,
              dialogType: DialogType.WARNING,
              animType: AnimType.BOTTOMSLIDE,
              title: Locales.string(context, 'Warning!'),
              desc: Locales.string(
                  context, "user with the provided email does not exist"),
              btnCancelOnPress: () {},
              btnOkOnPress: () {},
            )..show();
          }
          if (e.code == "wrong-password") {
            Navigator.of(context).pop();
            AwesomeDialog(
              context: context,
              dialogType: DialogType.WARNING,
              animType: AnimType.BOTTOMSLIDE,
              title: Locales.string(context, 'Warning!'),
              desc: Locales.string(
                  context, "wrong password provided for that user"),
              btnCancelOnPress: () {},
              btnOkOnPress: () {},
            )..show();
          }
        }
      }
    } else {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.ERROR,
        animType: AnimType.BOTTOMSLIDE,
        title: Locales.string(context, 'Warning!'),
        desc: Locales.string(context, 'check all of your information again'),
        btnCancelOnPress: () {},
        btnOkOnPress: () {},
      )..show();
    }
  }

  GlobalKey<FormState> forms = new GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).secondaryHeaderColor,),
        backgroundColor: Theme.of(context).canvasColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Center(
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
            margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
            padding: EdgeInsets.all(15),
            child: Form(
            key: forms,
            child: Column(
              children: [
                Container(
                    child: Image.asset(
                  "assets/LogoApp3.png",
                  width: 210,
                  height: 210,
                )),
                LocaleText("Sign in",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).secondaryHeaderColor,
                        fontSize: 20.0)),
                Container(
                  width: 260,
                  margin: EdgeInsets.fromLTRB(0, 40, 0, 0),
                  child: TextFormField(
                    //this field is where the user enter his email
                    onSaved: (value) {
                      setState(() {
                        email = value;
                      });
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return Locales.string(
                            context, "please,enter your email");
                      }
                      if (RegExp(r'^[\s]+$').hasMatch(value) == true) {
                        return Locales.string(
                            context, 'dont leave any field empty');
                      }
                      if ((value.endsWith("@gmail.com")) == false) {
                        return Locales.string(
                            context, 'enter a valid email(gmail)');
                      }
                      if ((value.startsWith("@gmail.com")) == true) {
                        return Locales.string(
                            context, 'enter a valid email(gmail)');
                      } else {
                        value = value.trim();
                      }
                    },
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person,
                            size: 30, color: Theme.of(context).secondaryHeaderColor,),
                        hintText: Locales.string(context, "Email"),
                        hintStyle:
                            TextStyle(color: Theme.of(context).secondaryHeaderColor, fontSize: 14),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Theme.of(context).secondaryHeaderColor,),
                        )),
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
                Container(
                  width: 260,
                  margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
                  child: TextFormField(
                    //this field is where the user enter his password
                    onSaved: (value) {
                      setState(() {
                        password = value!;
                      });
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return Locales.string(
                            context, "please enter your password");
                      }
                      if (RegExp(r'^[\s]+$').hasMatch(value) == true) {
                        return Locales.string(
                            context, "dont leave any field empty");
                      }
                      if (value.length <= 6) {
                        return Locales.string(context,
                            "the password shouldnt be less than 6 characters");
                      } else {
                        value = value.trim();
                      }
                    },
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock,
                            size: 30, color: Theme.of(context).secondaryHeaderColor,),
                        suffixIcon: IconButton(
                          icon: Icon(
                              isVisible
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              size: 20),
                          color: Theme.of(context).secondaryHeaderColor,
                          onPressed: () {
                            setState(() {
                              isVisible = !isVisible;
                            });
                          },
                        ),
                        hintText: Locales.string(context, "Password"),
                        hintStyle:
                            TextStyle(color: Theme.of(context).secondaryHeaderColor, fontSize: 14),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Theme.of(context).secondaryHeaderColor,),
                        )),
                    obscureText: isVisible,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                    onPressed: () async {
                      var response = await signInUser();
                      if (response != null ) {
                        SharedPreferences sharedpreferences =
                            await SharedPreferences.getInstance();
                        sharedpreferences.setString("email", email);
                        Navigator.pushReplacement(
                            context,
                            PageTransition(
                                alignment: Alignment.bottomCenter,
                                curve: Curves.easeInOut,
                                duration: Duration(seconds: 1),
                                type: PageTransitionType.scale,
                                child: Dashboard()));
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).secondaryHeaderColor,
                      padding: EdgeInsets.fromLTRB(67, 10, 67, 10),
                    ),
                    child: LocaleText("Sign in",
                        style: TextStyle(fontSize: 21.0))),
                SizedBox(
                  height: 10,
                ),
                TextButton(
                    onPressed: () {
                        Navigator.push(
                          context,
                          PageTransition(
                              alignment: Alignment.bottomCenter,
                              curve: Curves.easeInOut,
                              duration: Duration(seconds: 1),
                              type: PageTransitionType.scale,
                              child: ForgotPassword()));
                    },
                    child: LocaleText(
                      "Forgot your password?",
                      style: TextStyle(color: Theme.of(context).secondaryHeaderColor,),
                    )),
              ],
            ),
      ),
          ),
        ),
      ),
    );
  }
}
