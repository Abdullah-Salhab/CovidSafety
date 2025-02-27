
//this is the introduction screen where the loading screen for the app appears to the user
import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:graduation/Dashboard.dart';
import 'package:graduation/ProfileScreen.dart';
import 'COVID TEST/covid_test_answers.dart';
import 'Daily Test/My_situation_chart.dart';
import 'Daily Test/daily_test_answers.dart';
import 'login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'medicines.dart';
import 'myProvider.dart';
import 'package:provider/provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Locales.init(["en", "ar"]);
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MyProvider()),
        //this class is the used main class for the Daily check-up to analyze the user's health situation and give the result
        ChangeNotifierProvider(
          create: (BuildContext context) => DailyTestAnswers(),
        ),
        //this class is the used main class for the Covid-test to analyze the user's answers on the covid-test and check if there is an infection or not
        ChangeNotifierProvider(
          create: (BuildContext context) => CovidTestAnswers(),
        ),
      ],
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  // attribute to save settings
  static double brightness = 50.0;

  @override
  Widget build(BuildContext context) {
    // initialize the language
    return LocaleBuilder(
      builder: (locale) => MaterialApp(
        localizationsDelegates: Locales.delegates,
        supportedLocales: Locales.supportedLocales,
        locale: locale,
        title: 'Covid Safety',
        debugShowCheckedModeBanner: false,
        theme: context.watch<MyProvider>().getTheme,
        darkTheme: ThemeData.dark(),
        home: MyHomePage(),
        routes: {"/medic": (context) => Medicines()},
      ),
    );
  }
}
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
var finalEmail;
  @override
  void initState() {
    getValidationData().whenComplete(() async {
      Timer(
          Duration(seconds: 3),
          () => Navigator.pushReplacement(
              context,
              PageTransition(
                alignment: Alignment.bottomCenter,
                curve: Curves.easeInOut,
                duration: Duration(seconds: 1),
                type: PageTransitionType.bottomToTop,
                child: finalEmail == null ? loginScreen() : Dashboard(),
              )));
    });
    super.initState();
  }

  //this function will get the user's current email,if null,go to login screen,else,go to the profile page
  Future getValidationData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var obtainedEmail = sharedPreferences.getString('email');
    setState(() {
      finalEmail = obtainedEmail;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).secondaryHeaderColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "assets/LogoApp2.png",
              width: 390.0,
              height: 390.0,
              color: Colors.white,
            ),
            SizedBox(
              height: 120.0,
            ),
            SpinKitSpinningLines(
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
