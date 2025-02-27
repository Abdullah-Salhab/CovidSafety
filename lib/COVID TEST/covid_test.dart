import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:page_transition/page_transition.dart';
import '../login_screen.dart';
import 'covid_test_questions.dart';

class CovidTest extends StatefulWidget {
  const CovidTest({Key? key}) : super(key: key);

  @override
  _CovidTestState createState() => _CovidTestState();
}

class _CovidTestState extends State<CovidTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          toolbarHeight: 120,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: Row(
                  children: [
                    IconButton(
                      iconSize: 25,
                      color: Colors.red,
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) {
                          return loginScreen(); //return to main page
                        }));
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Image.asset(
                  "assets/images/CS2.png",
                  width: 100,
                  height: 100,
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
              color: Color(0xFFECF1FA),
              child: ListView(
                children: [
                  Column(
                    children: [
                      Container(
                        margin:
                            const EdgeInsets.only(left: 30, right: 30, top: 20),
                        child: const LocaleText(
                          "Do the following test to know if may you have a coronavirus infection.",
                          style: TextStyle(
                            color: Color.fromRGBO(40, 112, 200, 1.0),fontWeight: FontWeight.w500,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Image.asset(
                        "assets/images/virus.png",
                        width: 160,
                        height: 160,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin:
                            const EdgeInsets.only(top: 40, left: 30, right: 30),
                        child: Column(
                          children: const [
                            LocaleText(
                              "Note!",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin:
                            const EdgeInsets.only(top: 10, left: 30, right: 30),
                        child: Column(
                          children: const [
                            SizedBox(
                              height: 10,
                            ),
                            LocaleText(
                              "This Covid-19 Test will not replace the actual test",
                              style: TextStyle(
                                color: Color.fromRGBO(40, 112, 200, 1.0),fontWeight: FontWeight.w500,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),

                      //This button is used to go to the covid test questions.dart which have all the covid-test questions
                      MaterialButton(
                        padding: EdgeInsets.symmetric(horizontal: 50,vertical: 10),
                        onPressed: () {
                          Navigator.pushReplacement(context,PageTransition(
                            alignment: Alignment.bottomCenter,
                            curve: Curves.ease,
                            duration: Duration(seconds: 1),
                            type: PageTransitionType.size,child: CovidTestQuestions(),),);
                        },
                        child: const LocaleText(
                          "Do the test",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        elevation: 20,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        splashColor: Theme.of(context).secondaryHeaderColor,
                        color: Theme.of(context).secondaryHeaderColor,
                        height: 36,
                        textColor: Colors.white,
                      ),
                      const SizedBox(
                        height: 60,
                      )
                    ],
                  ),
                ],
              )),
        ));
  }
}
