import 'package:flutter/rendering.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:graduation/Daily%20Test/what_to_do.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../Dashboard.dart';
import 'daily_test_answers.dart';

class ResultDaily extends StatefulWidget {
  const ResultDaily({Key? key}) : super(key: key);

  @override
  _ResultDailyState createState() => _ResultDailyState();
}

class _ResultDailyState extends State<ResultDaily> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          toolbarHeight: 110,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: Row(
                  children: [],
                ),
              ),
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
        body: WillPopScope(
          onWillPop: ()async{return false;},
          child: Consumer<DailyTestAnswers>(builder: (context, mc, child) {
            print(mc.getUserNeedsMedicalHelp);
            print(mc.userSymptomsThatRequireMedicalHelp);
            if (mc.getUserNeedsMedicalHelp == true) {
              return Container(
                color: const Color(0xFFECF1FA),
                child: ListView(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 30, left: 30, top: 20),
                      padding: const EdgeInsets.only(
                          right: 5, left: 5, top: 10, bottom: 10),
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          LocaleText("Your Situation: ",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromRGBO(40, 112, 200, 1.0))),
                          LocaleText("Not Safe.",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xC2FF0000),)),
                        ],
                      ),
                    ),
                    Container(

                      margin: const EdgeInsets.only(
                          right: 30, left: 30, top: 20, bottom: 20),
                      padding: const EdgeInsets.only(
                          right: 5, left: 5, top: 5, bottom: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(context).shadowColor,
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: Offset(3, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:  [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: LocaleText(
                                  "based on your answers we saw that you have symptoms that requires medical help:",
                                  style: TextStyle(
                                      color:  Theme.of(context).secondaryHeaderColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount:
                                  mc.userSymptomsThatRequireMedicalHelp.length,
                              itemBuilder: (context, i) {
                                return Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Theme.of(context).shadowColor,
                                          spreadRadius: 1,
                                          blurRadius: 5,
                                          offset: Offset(3, 3), // changes position of shadow
                                        ),
                                      ],
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)),
                                  margin: const EdgeInsets.only(right: 35,left: 35,bottom: 8),
                                  child: Row(
                                    children: [
                                      Text("${i+1}. ",style: TextStyle(color:  Theme.of(context).secondaryHeaderColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),),
                                      Expanded(
                                        child: LocaleText(
                                            "${mc.userSymptomsThatRequireMedicalHelp[i]}",
                                            style: TextStyle(
                                                color:  Theme.of(context).secondaryHeaderColor,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500)),
                                      ),
                                    ],
                                  ),
                                );
                              })
                        ],
                      ),
                    ),
                    Container(
                      margin:
                          const EdgeInsets.only(right: 50, left: 50, bottom: 40,top: 10),
                      child: MaterialButton(
                        color: Color(0xC2FF0000),
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        onPressed: () {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) {
                            return WhatToDo();
                          }));
                        },
                        child: const LocaleText(
                          "What to do?",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
            else if (mc.getUserNeedsMedicalHelp == false) {
              return Container(
                color: const Color(0xFFECF1FA),
                child: ListView(
                  children: [
                    Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          margin: const EdgeInsets.only(right: 30, left: 30),
                          padding: const EdgeInsets.only(
                              right: 5, left: 5, top: 10, bottom: 10),
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              LocaleText("Your Situation: ",
                                  style: TextStyle(
                                      fontSize: 22, fontWeight: FontWeight.w500)),
                              LocaleText("Safe.",
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.green)),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Image.asset(
                          "assets/images/safe.png",
                          width: 200,
                          height: 200,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          margin: const EdgeInsets.only(right: 30, left: 30),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
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
                          child: const Padding(
                            padding: EdgeInsets.only(
                                left: 20, right: 20, top: 20, bottom: 20),
                            child: LocaleText(
                                "There are no dangerous symptoms to worry about, so please stay safe and healthy while you are in sanitary isolation, because your health and safety are all we care about.",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.green)),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          margin: const EdgeInsets.only(right: 30, left: 30),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
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
                          child: const Padding(
                            padding: EdgeInsets.only(
                                left: 20, right: 20, top: 20, bottom: 20),
                            child: LocaleText(
                                "And anytime you feel that your symptoms have worsened or you developed new symptoms that you did not have before please take the daily check immediately to check your health status to see if there is a need to seek medical help.",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                    color: Color.fromRGBO(40, 112, 200, 1.0))),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        MaterialButton(
                          color: Theme.of(context).secondaryHeaderColor,
                          padding: EdgeInsets.symmetric(horizontal: 25,vertical: 10),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(builder: (context) {
                              return Dashboard();
                            }));
                          },
                          child: const LocaleText(
                            "Return to Home page",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 60,
                        ),
                      ],
                    )
                  ],
                ),
              );
            }
            return const Text("");
          }),
        ));
  }
}
