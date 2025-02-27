import 'package:flutter/cupertino.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:page_transition/page_transition.dart';

import 'question_four.dart';
import 'question_one_two.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'daily_test_answers.dart';

class QuestionThree extends StatefulWidget {
  const QuestionThree({Key? key}) : super(key: key);

  @override
  _QuestionThreeState createState() => _QuestionThreeState();
}

class _QuestionThreeState extends State<QuestionThree> {
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
                              margin: const EdgeInsets.only(
                                  top: 30, left: 20, right: 20),
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
                              width: double.infinity,
                              child: Column(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.all(15.0),
                                    child: LocaleText("How is your breathing?",
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Color.fromRGBO(40, 112, 200, 1.0))),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 20),
                                    child: Image.asset(
                                      "assets/images/breathing.png",
                                      height: 130,
                                      width: 130,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(padding: EdgeInsets.all(8),
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
                                  borderRadius: BorderRadius.circular(20)),
                              margin: const EdgeInsets.only(
                                  top: 30, left: 20, right: 20),
                              child: MaterialButton(
                                  onPressed: () {
                                    mc.setBreathing =
                                        "Normal breathing without feeling breathless.";
                                    mc.setMedicalHelpIsNeededBreathing = false;
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Radio(
                                          activeColor: Theme.of(context).secondaryHeaderColor,
                                          value:
                                              "Normal breathing without feeling breathless.",
                                          groupValue: mc.breathing,
                                          onChanged: (val) {
                                            mc.setBreathing =
                                            "Normal breathing without feeling breathless.";
                                            mc.setMedicalHelpIsNeededBreathing = false;
                                          }),
                                     Expanded(
                                        child: LocaleText(
                                            "Normal",
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: Color.fromRGBO(40, 112, 200, 1.0),
                                              fontWeight: FontWeight.w400,
                                            )),
                                      ),
                                    ],
                                  )),
                            ),
                            Container(padding: EdgeInsets.all(8),
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
                                    mc.setBreathing =
                                        "Feeling more breathless, having difficulty breathing when getting up to go to the toilet for example, or being unable to speak in full sentences due to breathlessness.";
                                    mc.setMedicalHelpIsNeededBreathing = true;
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Radio(
                                          activeColor: Theme.of(context).secondaryHeaderColor,
                                          value:
                                              "Feeling more breathless, having difficulty breathing when getting up to go to the toilet for example, or being unable to speak in full sentences due to breathlessness.",
                                          groupValue: mc.breathing,
                                          onChanged: (val) {
                                            mc.setBreathing =
                                          "Feeling more breathless, having difficulty breathing when getting up to go to the toilet for example, or being unable to speak in full sentences due to breathlessness.";
                                          mc.setMedicalHelpIsNeededBreathing = true;}),
                                      const Expanded(
                                        child: LocaleText(
                                            "Feeling more breathless",
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w400,
                                              color: Color.fromRGBO(40, 112, 200, 1.0),
                                            )),
                                      ),
                                    ],
                                  )),
                            ),
                            Container(padding: EdgeInsets.all(8),
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
                                    mc.setBreathing =
                                        "Unable to complete short sentences when at rest (e.g. while sitting) due to breathlessness, or your breathing suddenly worsens.";
                                    mc.setMedicalHelpIsNeededBreathing = true;
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Radio(
                                          activeColor: Theme.of(context).secondaryHeaderColor,
                                          value:
                                              "Unable to complete short sentences when at rest (e.g. while sitting) due to breathlessness, or your breathing suddenly worsens.",
                                          groupValue: mc.breathing,
                                          onChanged: (value) {
                                            mc.setBreathing =
                                            "Unable to complete short sentences when at rest (e.g. while sitting) due to breathlessness, or your breathing suddenly worsens.";
                                            mc.setMedicalHelpIsNeededBreathing = true;
                                          }),
                                       Expanded(
                                        child: LocaleText(
                                            "Unable to complete short sentences",

                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w400,
                                              color: Color.fromRGBO(40, 112, 200, 1.0),
                                            )),
                                      )
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
                                    Navigator.pushReplacement(context,PageTransition(
                                      alignment: Alignment.bottomCenter,
                                      curve: Curves.ease,
                                      duration: Duration(seconds: 1),
                                      type: PageTransitionType.size,child: QuestionOneTwo(),),);

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
                                    if (mc.getBreathing != "") {
                                      Navigator.pushReplacement(context,PageTransition(
                                        alignment: Alignment.bottomCenter,
                                        curve: Curves.ease,
                                        duration: Duration(seconds: 1),
                                        type: PageTransitionType.size,child: QuestionFour(),),);
                                    }
                                    else{
                                      // If the user don't chose , display a Snack bar.
                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                        content: LocaleText('Please select one of the answers'),
                                        duration: Duration(seconds: 2),
                                      ));
                                    }
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
                                  splashColor: Theme.of(context).secondaryHeaderColor,
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
// Consumer<DailyTestAnswers>(builder: (context, mc, child) {
//       return }),
