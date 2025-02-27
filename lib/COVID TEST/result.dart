import 'package:flutter/cupertino.dart';
import 'package:graduation/COVID TEST/covid_test_answers.dart';
import 'package:graduation/login_screen.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../SignUpScreen.dart';

class Result extends StatefulWidget {
    @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<Result> {
  bool isMainSymptoms = false;
  bool isSecSymptoms = false;
  bool isSevSymptoms = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          backgroundColor: Theme.of(context).secondaryHeaderColor,
          toolbarHeight: 120,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Expanded(flex: 1, child: Text("")),
              Expanded(
                flex: 2,
                child: Image.asset(
                  "assets/images/CS2.png",
                  width: 110,
                  height: 110,
                ),
              ),
              Expanded(flex: 1, child: Container()),
            ],
          ),
        ),
        body: WillPopScope(onWillPop: () async {
          return false;
        }, child: SafeArea(
            child: Consumer<CovidTestAnswers>(builder: (context, mc, child) {
              isMainSymptoms = mc.coronavirusMainSymptoms;
              isSecSymptoms = mc.coronavirusSecondarySymptoms;
              isSevSymptoms = mc.coronavirusSevereSymptoms;
            // show the content depend on the user symptoms
            return ListView(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).shadowColor,
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: Offset(3, 3), // changes position of shadow
                      ),
                    ],
                    color: Colors.white,
                  ),
                  margin:const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  padding:const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LocaleText(
                        "Result:",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).secondaryHeaderColor,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      LocaleText((isMainSymptoms == true)?"Positive.":"Negative.",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: (isMainSymptoms == true)?Color(0xC2FF0000):Colors.green,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).shadowColor,
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: Offset(3, 3), // changes position of shadow
                      ),
                    ],
                    color: Colors.white,
                  ),
                  padding:const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  child: LocaleText(
                    "${mc.getResult}",
                    style: const TextStyle(
                      color: Color.fromRGBO(40, 112, 200, 1.0),
                      fontSize: 17,
                    ),
                  ),
                ),
                (isMainSymptoms == true)?SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Theme.of(context).shadowColor,
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: Offset(3, 3), // changes position of shadow
                              ),
                            ],
                            color: Colors.white,
                          ),
                          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                          child: LocaleText("Common",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).secondaryHeaderColor,
                              fontSize: 15,
                            ),
                          )),
                      ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: mc.mainSymptomsTheUserHas.length,
                          itemBuilder: (context, i) {
                            return Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Theme.of(context).shadowColor,
                                    spreadRadius: 1,
                                    blurRadius: 5,
                                    offset: Offset(3, 3), // changes position of shadow
                                  ),
                                ],
                              color: Colors.white,
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                              margin: EdgeInsets.symmetric(horizontal: 50,vertical: 5),
                              child: Align(
                                alignment: Alignment.center,
                                child: LocaleText(
                                    "${mc.mainSymptomsTheUserHas[i]}",
                                    style: TextStyle(
                                        color: Theme.of(context).secondaryHeaderColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500)),
                              ),
                            );
                          })
                    ],
                  ),
                ):Container(),
                (isSecSymptoms == true)?SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Theme.of(context).shadowColor,
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: Offset(3, 3), // changes position of shadow
                              ),
                            ],
                            color: Colors.white,
                          ),
                          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                          child: LocaleText("Secondary",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).secondaryHeaderColor,
                              fontSize: 15,
                            ),
                          )),
                      ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: mc.secondarySymptomsTheUserHas.length,
                          itemBuilder: (context, i) {
                            return Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Theme.of(context).shadowColor,
                                    spreadRadius: 1,
                                    blurRadius: 5,
                                    offset: Offset(3, 3), // changes position of shadow
                                  ),
                                ],
                                color: Colors.white,
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                              margin: EdgeInsets.symmetric(horizontal: 50,vertical: 5),
                              child: Align(
                                alignment: Alignment.center,
                                child: LocaleText(
                                    "${mc.secondarySymptomsTheUserHas[i]}",
                                    style: TextStyle(
                                        color: Theme.of(context).secondaryHeaderColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500)),
                              ),
                            );
                          })
                    ],
                  ),
                ):Container(),
                (isSevSymptoms == true)?SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Theme.of(context).shadowColor,
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: Offset(3, 3), // changes position of shadow
                              ),
                            ],
                            color: Colors.white,
                          ),
                          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                          child: LocaleText("Severe",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).secondaryHeaderColor,
                              fontSize: 15,
                            ),
                          )),
                      ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: mc.severeSymptomsTheUserHas.length,
                          itemBuilder: (context, i) {
                            return Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Theme.of(context).shadowColor,
                                    spreadRadius: 1,
                                    blurRadius: 5,
                                    offset: Offset(3, 3), // changes position of shadow
                                  ),
                                ],
                                color: Colors.white,
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                              margin: EdgeInsets.symmetric(horizontal: 50,vertical: 5),
                              child: Align(
                                alignment: Alignment.center,
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 10),
                                  child: LocaleText(
                                      "${mc.severeSymptomsTheUserHas[i]}",
                                      style: TextStyle(
                                          color: Theme.of(context).secondaryHeaderColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500)),
                                ),
                              ),
                            );
                          })
                    ],
                  ),
                ):Container(),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).shadowColor,
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: Offset(3, 3), // changes position of shadow
                      ),
                    ],
                    color: Colors.white,
                  ),
                  padding:const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  margin:const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  child: const LocaleText(
                    "signing up",
                    style: TextStyle(
                      color: Color.fromRGBO(40, 112, 200, 1.0),
                      fontSize: 16,
                    ),
                  ),
                ),
                (isMainSymptoms == true)?
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).shadowColor,
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: Offset(3, 3), // changes position of shadow
                      ),
                    ],
                    color: Colors.white,
                  ),
                  padding:const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  margin:const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  child: const LocaleText("interest",
                    style: TextStyle(
                      color: Color.fromRGBO(40, 112, 200, 1.0),
                      fontSize: 16,
                    ),
                  ),
                ):
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).shadowColor,
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: Offset(3, 3), // changes position of shadow
                      ),
                    ],
                    color: Colors.white,
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  child: const LocaleText(
                    "Negative result Message",
                    style: TextStyle(
                      color: Color.fromRGBO(40, 112, 200, 1.0),
                      fontSize: 16,
                    ),
                  ),
                ),
                Container(
                  margin:const EdgeInsets.symmetric(horizontal: 60),
                  padding:EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: MaterialButton(
                    splashColor: Theme.of(context).secondaryHeaderColor,
                    color: Theme.of(context).secondaryHeaderColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    onPressed: () {Navigator.push(context,PageTransition(
                      alignment: Alignment.center,
                      curve: Curves.easeInOut,
                      duration: Duration(seconds: 2),
                      type: PageTransitionType.scale,child: SignUp(),),);},
                    child: const LocaleText(
                      "Sign up",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: const LocaleText(
                    "Or",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                Container(
                  margin:EdgeInsets.symmetric(horizontal: 60,),
                  padding:EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: MaterialButton(
                    color: Theme.of(context).secondaryHeaderColor,
                    elevation: 10,
                    splashColor: Theme.of(context).secondaryHeaderColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) {
                        return loginScreen();
                      }));
                    },
                    child: LocaleText(
                      "Return to main page",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 40,),
              ],
            );
        }))));
  }
}
