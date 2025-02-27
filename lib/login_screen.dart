//this is the page where the user decide to either sign in,sign up,do the corona test or see frequently asked questions
//this page is also where the app will send the user to if he didnt sign in or sign up the app.
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graduation/FrequentQuestions.dart';
import 'package:graduation/SignUpScreen.dart';
import 'package:graduation/sign_in_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_locales/flutter_locales.dart';

import 'COVID TEST/covid_test.dart';
import 'myProvider.dart';
import 'package:provider/provider.dart';

class loginScreen extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<loginScreen> {
  var dropdownValue = "English";

  @override
  Widget build(BuildContext context) {
    dropdownValue =
        Localizations.localeOf(context).toString() == 'ar' ? "عربي" : "English";
    // prevent user to rotate the phone
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromRGBO(24, 20, 97, 0),
        elevation: 0,
        actions: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 3),
            margin: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [

                Icon(Icons.language, size: 16, color: Theme.of(context).secondaryHeaderColor,),
                SizedBox(
                  width: 5,
                ),
                DropdownButton<String>(
                  underline: SizedBox(),
                  value: dropdownValue,
                  iconSize: 24,
                  elevation: 16,
                  onChanged: (newValue) {
                    if (newValue == "English")
                      LocaleNotifier.of(context)!.change('en');
                    else
                      LocaleNotifier.of(context)!.change('ar');
                    setState(() {
                      dropdownValue = newValue!;
                      dropdownValue == "English"
                          ? context.read<MyProvider>().changeLanguage("English")
                          : context.read<MyProvider>().changeLanguage("Arabic");
                    });
                  },
                  items: <String>['English', 'عربي']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(color: Theme.of(context).secondaryHeaderColor,),
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(width: 10,),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: Theme.of(context).canvasColor,
      body: WillPopScope(
        onWillPop: () => showExitPopup(context),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Image.asset(
                "assets/LogoApp3.png",
                width: 260,
                height: 240,
              ),
              //this is the logo of the app
              LocaleText("Welcome",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).secondaryHeaderColor,
                      fontSize: 22.0)),
              SizedBox(
                height: 6.0,
              ),
              LocaleText("Sign in to continue",
                  style: TextStyle(fontSize: 13.0)),
              SizedBox(
                height: 20.0,
              ),
              SizedBox(
                width: 260,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          PageTransition(
                            alignment: Alignment.bottomCenter,
                            curve: Curves.easeInOut,
                            duration: Duration(seconds: 1),
                            type: PageTransitionType.scale,
                            child: signInScreen(),
                          ));
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).secondaryHeaderColor,
                      padding: EdgeInsetsDirectional.only(
                          end: 5.0, start: 5.0, bottom: 5, top: 5),
                    ),
                    child: LocaleText("Sign in",
                        style: TextStyle(fontSize: 21.0))),
              ),
              SizedBox(
                height: 8.0,
              ),
              LocaleText("OR", style: TextStyle(fontSize: 13.0)),
              SizedBox(
                height: 8.0,
              ),
              SizedBox(
                width: 260,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          PageTransition(
                            alignment: Alignment.bottomCenter,
                            curve: Curves.easeInOut,
                            duration: Duration(seconds: 1),
                            type: PageTransitionType.scale,
                            child: SignUp(),
                          ));
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).secondaryHeaderColor,
                      padding: EdgeInsetsDirectional.only(
                          end: 5.0, start: 5.0, bottom: 5, top: 5),
                    ),
                    child: LocaleText("Sign up",
                        style: TextStyle(fontSize: 21.0))),
              ),
              SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment(2.00, 2.00),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 56,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        width: 210,
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushReplacement(context,PageTransition(
                                  alignment: Alignment.center,
                                  curve: Curves.easeInCubic,
                                  duration: Duration(seconds: 1),
                                  type: PageTransitionType.scale,child:CovidTest()),);
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Theme.of(context).secondaryHeaderColor,
                              padding: EdgeInsets.fromLTRB(9, 0, 9, 0),
                            ),
                            child: LocaleText(
                              "Do the Coronavirus test",
                              style: TextStyle(fontSize: 14.0),
                            )),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        width: 210,
                        child: ElevatedButton(
                            onPressed: () {
                              //this function will send the user to the frequently asked questions
                              Navigator.push(
                                  context,
                                  PageTransition(
                                    alignment: Alignment.bottomCenter,
                                    curve: Curves.easeInOut,
                                    duration: Duration(seconds: 1),
                                    type: PageTransitionType.bottomToTop,
                                    child: FrequentlyQuestions(),
                                  ));
                            },
                            style: ElevatedButton.styleFrom(
                                primary: Theme.of(context).secondaryHeaderColor,),
                            child: LocaleText(
                              "Frequently asked questions",
                              style: TextStyle(fontSize: 14.0),
                            )),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // this function will show an alert if the user want to exit the app or not
  Future<bool> showExitPopup(context) async {
    return await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
              height: 90,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Do you want to exit?"),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            print('yes selected');
                            exit(0);
                          },
                          child: LocaleText("Yes"),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.red.shade800),
                        ),
                      ),
                      SizedBox(width: 15),
                      Expanded(
                          child: ElevatedButton(
                        onPressed: () {
                          print('no selected');
                          Navigator.of(context).pop();
                        },
                        child:
                          LocaleText("No", style: TextStyle(color: Colors.black)),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                        ),
                      ))
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  // save the default language in provider when the app start
  // because when we close the app the languages saved the changes but not saved in provider
  void setProviderLanguage(BuildContext context) {
    print(Localizations.localeOf(context).toString());
    print(dropdownValue);
    if (Localizations.localeOf(context).toString() == 'ar' &&
        dropdownValue == "English")
      setState(() {
        dropdownValue = "English";
      });
    else if (Localizations.localeOf(context).toString() == 'en' &&
        dropdownValue == "عربي")
      setState(() {
        dropdownValue = "عربي";
      });
  }
}
