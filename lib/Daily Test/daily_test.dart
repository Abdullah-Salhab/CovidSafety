import 'package:flutter/cupertino.dart';
import 'package:graduation/Daily Test/question_one_two.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'daily_test_answers.dart';

class DailyTest extends StatelessWidget {
  const DailyTest({Key? key}) : super(key: key);

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
        body: Consumer<DailyTestAnswers>(builder: (context, mc, child) {
          return Container(
            height: double.infinity,
            width: double.infinity,
            child: ListView(
              children: [
                Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    const Card(
                      elevation: 5,
                      shadowColor: Color.fromRGBO(40, 112, 200, 1.0),
                      color: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.0,vertical: 10),
                        child: LocaleText(
                          "Daily check-up",
                          style: TextStyle(
                            color: Color.fromRGBO(40, 112, 200, 1.0),
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Image.asset(
                      "assets/images/Daily_Cover.png",
                      width: 300,
                      height: 300,
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(
                          left: 60, right: 50, top: 20, bottom: 20),
                      // ignore: prefer_const_constructors

                      width: double.infinity,

                      child: const Card(
                        elevation:6,
                        shadowColor: Color.fromRGBO(40, 112, 200, 1.0),
                        child: Padding(
                          padding: EdgeInsets.all(12.0),
                          child: LocaleText(
                            "Answer the following daily check-up questions",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                    //this button starts the daily check-up
                    Container(
                        margin: const EdgeInsets.only(
                            top: 10, bottom: 50),
                        child: MaterialButton(
                          padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                          onPressed: () {
                              mc.setInitialValues();
                              Navigator.pushReplacement(context,PageTransition(
                                alignment: Alignment.bottomCenter,
                                curve: Curves.ease,
                                duration: Duration(seconds: 1),
                                type: PageTransitionType.size,child:QuestionOneTwo(),),);
                          },
                          child: const LocaleText(
                            "Do the daily check-up",
                            style: TextStyle(fontSize: 18),
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          splashColor: const Color.fromRGBO(40, 112, 200, 1.0),
                          color: Theme.of(context).secondaryHeaderColor,
                          textColor: Colors.white,
                        )),
                  ],
                ),
              ],
            ),
          );
        }));
  }
}
