import 'package:graduation/Daily%20Test/question_fourteen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import 'daily_test_answers.dart';
import 'question_sixteen.dart';

class QuestionFifteen extends StatefulWidget {
  const QuestionFifteen({Key? key}) : super(key: key);

  @override
  _QuestionFifteenState createState() => _QuestionFifteenState();
}

class _QuestionFifteenState extends State<QuestionFifteen> {
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
            onWillPop: () async {
              return false;
            },
            child: Container(
                child: Consumer<DailyTestAnswers>(
                  builder: (context, mc, child) {
                    return ListView(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: const Color(0xFFFFFFFF),
                                  boxShadow: [
                                      BoxShadow(
                                      color: Theme.of(context).shadowColor,
                                      spreadRadius: 4,
                                      blurRadius: 5,
                                      offset: Offset(0, 2), // changes position of shadow
                                       ),
                                   ],
                                  borderRadius: BorderRadius.circular(30)),
                              margin: const EdgeInsets.only(
                                  top: 30, left: 20, right: 20),
                              width: double.infinity,
                              child: Column(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.all(15.0),
                                    //
                                    child:  LocaleText(
                                        "Do you feel that you are absent and unaware of yourself and your actions?",

                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Color.fromRGBO(40, 112, 200, 1.0))),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 20),
                                    child: Image.asset(
                                      "assets/images/confusion.png",
                                      height: 130,
                                      width: 130,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(padding: EdgeInsets.all(5),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: const Color(0xFFFFFFFF),
                                  boxShadow: [
                                      BoxShadow(
                                      color: Theme.of(context).shadowColor,
                                      spreadRadius: 4,
                                      blurRadius: 5,
                                      offset: Offset(0, 2), // changes position of shadow
                                       ),
                                   ],
                                  borderRadius: BorderRadius.circular(30)),
                              margin: const EdgeInsets.only(
                                  top: 30, left: 20, right: 20),
                              child: MaterialButton(
                                  onPressed: () {
                                    mc.setConfusion =
                                        "I am fully aware and conscious of myself and my actions.";
                                    mc.setMedicalHelpIsNeededConfusion = false;
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Radio(
                                          activeColor: Theme.of(context).secondaryHeaderColor,
                                          value:
                                              "I am fully aware and conscious of myself and my actions.",
                                          groupValue: mc.confusion,
                                          onChanged: (val) {
                                            mc.setConfusion =
                                            "I am fully aware and conscious of myself and my actions.";
                                            mc.setMedicalHelpIsNeededConfusion = false;}),
                                      const Expanded(
                                        child:  LocaleText(
                                            "I am fully aware and conscious of myself and my actions.",

                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Color.fromRGBO(40, 112, 200, 1.0),
                                                fontWeight: FontWeight.w400)),
                                      ),
                                    ],
                                  )),
                            ),
                            Container(padding: EdgeInsets.all(5),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: const Color(0xFFFFFFFF),
                                  boxShadow: [
                                      BoxShadow(
                                      color: Theme.of(context).shadowColor,
                                      spreadRadius: 4,
                                      blurRadius: 5,
                                      offset: Offset(0, 2), // changes position of shadow
                                       ),
                                   ],
                                  borderRadius: BorderRadius.circular(30)),
                              margin: const EdgeInsets.only(
                                  top: 20, left: 20, right: 20),
                              child: MaterialButton(
                                  onPressed: () {
                                    mc.setConfusion =
                                        "I am feeling unconscious and unaware of myself.";
                                    mc.setMedicalHelpIsNeededConfusion = true;
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Radio(
                                          activeColor: Theme.of(context).secondaryHeaderColor,
                                          value:
                                              "I am feeling unconscious and unaware of myself.",
                                          groupValue: mc.confusion,
                                          onChanged: (val) {
                                            mc.setConfusion =
                                            "I am feeling unconscious and unaware of myself.";
                                            mc.setMedicalHelpIsNeededConfusion = true;}),
                                      const Expanded(
                                        child:  LocaleText(
                                            "I am feeling unconscious and unaware of myself.",

                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Color.fromRGBO(40, 112, 200, 1.0),
                                                fontWeight: FontWeight.w400)),
                                      ),
                                    ],
                                  )),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                MaterialButton(
                                  onPressed: () {
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(builder: (context) {
                                      return const QuestionFourteen();
                                    }));
                                    //     indexed_Stack_Chosen_Widget = 1;
                                  },
                                  child: Row(
                                    children: const [
                                      Icon(
                                        Icons.arrow_back_ios,
                                        size: 16,
                                      ),
                                      LocaleText(
                                        "Previous",
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30)),
                                  splashColor: Theme.of(context).secondaryHeaderColor,
                                  height: 50,
                                  minWidth: 110.0,
                                  color: Theme.of(context).secondaryHeaderColor,
                                  textColor: Colors.white,
                                ),
                                MaterialButton(
                                  onPressed: () {
                                    if (mc.getConfusion != ""){
                                      Navigator.pushReplacement(context,PageTransition(
                                          alignment: Alignment.bottomCenter,
                                          curve: Curves.ease,
                                          duration: Duration(seconds: 1),
                                          type: PageTransitionType.size,child: const QuestionSixteen()),);
                                    }
                                    else{
                                      // If the user don't chose , display a Snack bar.
                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                        content: LocaleText('Please select one of the answers'),
                                        duration: Duration(seconds: 2),
                                      ));
                                    }
                                    //     indexed_Stack_Chosen_Widget = 1;
                                  },
                                  child: Row(
                                    children: const [
                                      LocaleText(
                                        "Next",
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      Icon(Icons.arrow_forward_ios, size: 16),
                                    ],
                                  ),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30)),
                                  splashColor: Theme.of(context).secondaryHeaderColor,
                                  height: 50,
                                  minWidth: 110.0,
                                  color: Theme.of(context).secondaryHeaderColor,
                                  textColor: Colors.white,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ))));
  }
}
