import 'package:graduation/Daily%20Test/question_fifteen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import 'daily_test_answers.dart';
import 'loading_daily.dart';

class QuestionSixteen extends StatefulWidget {
  const QuestionSixteen({Key? key}) : super(key: key);

  @override
  _QuestionSixteenState createState() => _QuestionSixteenState();
}

class _QuestionSixteenState extends State<QuestionSixteen> {
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
                                    child: LocaleText(
                                        "Do you find yourself unable to wake up as if you were in a coma, for example?",
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Color.fromRGBO(40, 112, 200, 1.0))),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 20),
                                    child: Image.asset(
                                      "assets/images/wake.png",
                                      height: 130,
                                      width: 130,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(8),
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
                                    mc.setWake =
                                        "I Wake Up Normally in the morning without problems.";
                                    mc.setMedicalHelpIsNeededWake = false;
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Radio(
                                          activeColor: Theme.of(context).secondaryHeaderColor,
                                          value:
                                              "I Wake Up Normally in the morning without problems.",
                                          groupValue: mc.wake,
                                          onChanged: (val) {
                                            mc.setWake =
                                            "I Wake Up Normally in the morning without problems.";
                                            mc.setMedicalHelpIsNeededWake = false;}),
                                      const Expanded(
                                        child: LocaleText("I Wake Up Normally",
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Color.fromRGBO(40, 112, 200, 1.0),
                                                fontWeight: FontWeight.w400)),
                                      ),
                                    ],
                                  )),
                            ),
                            Container(
                              padding: EdgeInsets.all(8),
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
                                    mc.setWake =
                                        "Having problems waking up like you are in a coma for example  and not being able to stay awake without collapsing or fainting.";

                                    mc.setMedicalHelpIsNeededWake = true;
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Radio(
                                          activeColor: Theme.of(context).secondaryHeaderColor,
                                          value:
                                              "Having problems waking up like you are in a coma for example  and not being able to stay awake without collapsing or fainting.",
                                          groupValue: mc.wake,
                                          onChanged: (val) {
                                            mc.setWake =
                                            "Having problems waking up like you are in a coma for example  and not being able to stay awake without collapsing or fainting.";

                                            mc.setMedicalHelpIsNeededWake = true;}),
                                      const Expanded(
                                        child: LocaleText(
                                            "Having problems waking up",
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
                                      return const QuestionFifteen();
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
                                    if (mc.getWake != "") {
                                      mc.setTempStatus();
                                      mc.setOxygenStatus();
                                      mc.setBreathingStatus();
                                      mc.setCoughStatus();
                                      mc.setFatigueStatus();
                                      mc.setBluishStatus();
                                      mc.setChestPainStatus();
                                      mc.setCoughBloodStatus();
                                      mc.setBodyPartStatus();
                                      mc.setCollapseStatus();
                                      mc.setDiarrheaStatus();
                                      mc.setPeeingStatus();
                                      mc.setMotionOrSpeakStatus();
                                      mc.setConfusionStatus();
                                      mc.setWakeStatus();
                                      mc.setTheUserSituation();
                                      mc.setAnswers();
                                      Navigator.pushReplacement(
                                        context,
                                        PageTransition(
                                            alignment: Alignment.center,
                                            curve: Curves.ease,
                                            type: PageTransitionType.fade,
                                            child: LoadingTwo()),
                                      );
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
                                        "Finish",
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        size: 16,
                                      ),
                                    ],
                                  ),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  splashColor: Theme.of(context).secondaryHeaderColor,
                                  color: const Color(0xFF0077FF),
                                  height: 50,
                                  minWidth: 100.0,
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
