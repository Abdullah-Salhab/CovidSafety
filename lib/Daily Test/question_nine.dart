import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import 'daily_test_answers.dart';
import 'question_eight.dart';
import 'question_ten.dart';

class QuestionNine extends StatefulWidget {
  const QuestionNine({Key? key}) : super(key: key);

  @override
  _QuestionNineState createState() => _QuestionNineState();
}

class _QuestionNineState extends State<QuestionNine> {
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
                                    padding: EdgeInsets.only(top:15.0,left: 25,right: 25,bottom: 15),
                                    child: LocaleText("Do you feel weakness",
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Color.fromRGBO(40, 112, 200, 1.0))),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 20),
                                    child: Image.asset(
                                      "assets/images/part of your body.png",
                                      height: 120,
                                      width: 120,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
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
                                    mc.setBodyPart = "No.";
                                    mc.setMedicalHelpIsNeededBodyPart = false;
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Radio(
                                          activeColor: Theme.of(context).secondaryHeaderColor,
                                          value: "No.",
                                          groupValue: mc.bodyPart,
                                          onChanged: (val) {
                                            mc.setBodyPart = "No.";
                                            mc.setMedicalHelpIsNeededBodyPart = false;}),
                                      const LocaleText("No.",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Color.fromRGBO(40, 112, 200, 1.0),
                                              fontWeight: FontWeight.w400)),
                                    ],
                                  )),
                            ),
                            Container(
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
                                    mc.setBodyPart = "Yes.";
                                    mc.setMedicalHelpIsNeededBodyPart = true;
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Radio(
                                          activeColor: Theme.of(context).secondaryHeaderColor,
                                          value: "Yes.",
                                          groupValue: mc.bodyPart,
                                          onChanged: (val) {
                                            mc.setBodyPart = "Yes.";
                                            mc.setMedicalHelpIsNeededBodyPart = true;}),
                                      const LocaleText("Yes.",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Color.fromRGBO(40, 112, 200, 1.0),
                                              fontWeight: FontWeight.w400)),
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
                                      return const QuestionEight();
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
                                    if (mc.getBodyPart != "") {
                                      Navigator.pushReplacement(context,PageTransition(
                                          alignment: Alignment.bottomCenter,
                                          curve: Curves.ease,
                                          duration: Duration(seconds: 1),
                                          type: PageTransitionType.size,child: const QuestionTen()),);
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
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        size: 16,
                                      ),
                                    ],
                                  ),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30)),
                                  splashColor:  Theme.of(context).secondaryHeaderColor,
                                  height: 50,
                                  minWidth: 110.0,
                                  color: Theme.of(context).secondaryHeaderColor,
                                  textColor: Colors.white,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ))));
  }
}
