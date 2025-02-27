import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:graduation/Dashboard.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'daily_test_answers.dart';
import 'question_three.dart';

class QuestionOneTwo extends StatefulWidget {
  @override
  _QuestionOneTwoState createState() => _QuestionOneTwoState();
}

class _QuestionOneTwoState extends State<QuestionOneTwo> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          toolbarHeight: 110,
          title: Image.asset(
            "assets/images/CS2.png",
            width: 110,
            height: 110,
          ),
        ),
        body: WillPopScope(
            onWillPop: () => showExitPopup(context),
            child: Container(
              child: ListView(
                children: [
                  Column(
                    children: [
                      Container(
                        margin:
                            const EdgeInsets.only(top: 30, left: 20, right: 20),
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
                              padding: EdgeInsets.only(
                                  top: 15.0, left: 25, right: 25, bottom: 15),
                              child: LocaleText("Take your temperature",
                                  style: TextStyle(
                                      fontSize: 20, color: Color.fromRGBO(40, 112, 200, 1.0))),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 20, bottom: 20),
                              child: Image.asset(
                                "assets/images/Thermometer.png",
                                height: 100,
                                width: 100,
                              ),
                            ),
                            Consumer<DailyTestAnswers>(
                                builder: (context, mc, child) {
                              return Column(
                                children: [
                                  Text("${mc.getTemperature}",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Color.fromRGBO(40, 112, 200, 1.0))),
                                  Slider(
                                      activeColor: Colors.red,
                                      inactiveColor: Colors.yellow,
                                      divisions: mc.sliderDivision,
                                      min: mc.sliderMin,
                                      max: mc.sliderMax,
                                      value: mc.temperature,
                                      onChanged: (double value) {
                                        mc.setTemperature = value;
                                      }),
                                  Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Theme.of(context).secondaryHeaderColor,
                                            width: 1),
                                        color: const Color(0xffefefef),
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    margin: const EdgeInsets.only(
                                        top: 20, left: 30, right: 30),
                                    child: MaterialButton(
                                        onPressed: () {
                                          mc.setTemperatureUnit = "Celsius";
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Radio(
                                                activeColor:
                                                    Theme.of(context).secondaryHeaderColor,
                                                value: "Celsius",
                                                groupValue: mc.temperatureUnit,
                                                onChanged: (val) {mc.setTemperatureUnit = "Celsius";}),
                                            const LocaleText("Celsius",
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  color: Color.fromRGBO(40, 112, 200, 1.0),
                                                )),
                                          ],
                                        )),
                                  ),
                                  Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Theme.of(context).secondaryHeaderColor,
                                            width: 1),
                                        color: Color(0xffefefef),
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    margin: const EdgeInsets.only(
                                        top: 10, left: 30, right: 30),
                                    child: MaterialButton(
                                        onPressed: () {
                                          mc.setTemperatureUnit = "Fahrenheit";
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Radio(
                                                activeColor:
                                                    Theme.of(context).secondaryHeaderColor,
                                                value: "Fahrenheit",
                                                groupValue: mc.temperatureUnit,
                                                onChanged: (val) {mc.setTemperatureUnit = "Fahrenheit";}),
                                            const LocaleText("Fahrenheit",
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  color: Color.fromRGBO(40, 112, 200, 1.0),
                                                )),
                                          ],
                                        )),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  )
                                ],
                              );
                            }),
                          ],
                        ),
                      ),
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
                                padding: EdgeInsets.only(
                                    top: 15.0, left: 25, right: 25, bottom: 15),
                                child: LocaleText("Measure your oxygen level",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Color.fromRGBO(40, 112, 200, 1.0))),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 20, bottom: 40),
                                child: Image.asset(
                                  "assets/images/oximeter.png",
                                  height: 120,
                                  width: 120,
                                ),
                              ),
                              Consumer<DailyTestAnswers>(
                                  builder: (context, mc, child) {
                                return Column(
                                  children: [
                                    Text("${(mc.getOxygenLevel).round()}",
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Color.fromRGBO(40, 112, 200, 1.0))),
                                    Slider(
                                        activeColor: Colors.blue,
                                        inactiveColor: Colors.blue[200],
                                        divisions: 40,
                                        min: 60,
                                        max: 100,
                                        value: mc.oxygenLevel,
                                        onChanged: (double value) {
                                          mc.setOxygenLevel = value;
                                        }),
                                  ],
                                );
                              }),
                            ],
                          )),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Consumer<DailyTestAnswers>(
                              builder: (context, mc, child) {
                            return MaterialButton(
                              onPressed: () {
                                mc.setTemperatureStatus();
                                Navigator.pushReplacement(
                                  context,
                                  PageTransition(
                                    alignment: Alignment.bottomCenter,
                                    curve: Curves.ease,
                                    duration: Duration(seconds: 1),
                                    type: PageTransitionType.size,
                                    child: QuestionThree(),
                                  ),
                                );
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
                              splashColor: Theme.of(context).secondaryHeaderColor,
                              height: 50,
                              minWidth: 110.0,
                              color: Theme.of(context).secondaryHeaderColor,
                              textColor: Colors.white,
                            );
                          })
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ],
              ),
            )));
  }
}
// this function will show an alert if the user want to exit test or not
Future<bool> showExitPopup(context) async{
  return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            height: 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: LocaleText("Do you want to exit the daily check-up?")),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          print('yes selected');
                          Navigator.push(context,PageTransition(
                            alignment: Alignment.center,
                            curve: Curves.easeInOut,
                            duration: Duration(seconds: 1),
                            type: PageTransitionType.fade,child: Dashboard(),),);
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
                          child: LocaleText("No", style: TextStyle(color: Colors.black)),
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
