import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:graduation/COVID%20TEST/covid_test.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'covid_test_answers.dart';
import 'loading.dart';

class CovidTestQuestions extends StatefulWidget {
  const CovidTestQuestions({Key? key}) : super(key: key);

  @override
  _CovidTestQuestionsState createState() => _CovidTestQuestionsState();
}

class _CovidTestQuestionsState extends State<CovidTestQuestions> {
  //questionNumber is and index used to view the questions in the listOfQuestions list and listOfImages list
  //and this value ( questionNumber ) will be used to fill the answers List with the answers of each question either with true (if the user have the symptom) or false(if the user doesn't have the symptom)
  int questionNumber = 0;
  CarouselController carouselController = CarouselController();
//The list of questions the user will be asked to verify if there is a covid-19 infection
  List listOfQuestions = [
    "Do you have a high fever?",
    "Do you have a dry cough?",
    "Do you feel very tired and exhausted?",
    "Do you suffer from loss of smell and taste?",
    "Do you have a stuffy nose?",
    "Do you have conjunctivitis (red eyes)?",
    "Do you have a sore throat?",
    "Do you have a headache?",
    "Do you have aches in your muscles and joints?",
    "Has any kind of rash appeared on your body?",
    "Do you feel nauseous and vomiting?",
    "Do you have diarrhea?",
    "Do you have shivering and dizziness?",
    "Did you feel that your consciousness has Reduced lately?",
    "Do you have Shortness of breath?",
    "Do you have a lack appetite?",
    "Do you have confusion and foggy thinking?",
    "Do you feel Constant pain or a feeling of pressure in the chest?",
    "Did you have a High temperature (more than 38 degrees Celsius)?",
  ];
//The list of Images of each question , and a slider will show each image simultaneously with the question related to it
  List listOfImages = [
    "assets/images/high fever.png",
    "assets/images/cough.png",
    "assets/images/tiredness and exhaustion.png",
    "assets/images/loss of smell and taste.png",
    "assets/images/stuffy nose.png",
    "assets/images/red eyes.png",
    "assets/images/sore throat.png",
    "assets/images/headache.png",
    "assets/images/aches in muscles and joints.png",
    "assets/images/rashes.png",
    "assets/images/nauseous.png",
    "assets/images/diarrhea.png",
    "assets/images/shivering and dizziness.png",
    "assets/images/consciousness.png",
    "assets/images/shortness of breath.png",
    "assets/images/appetite.png",
    "assets/images/confusion.png",
    "assets/images/chest.png",
    "assets/images/Thermometer.png",
  ];

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
                            return CovidTest(); //return to main page
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
    child:Container(
        color: const Color(0xFFECF1FA),
        child: Column(
          children: [
            //this Widget will show the Question
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(
                    right: 20, left: 20, top: 30, bottom: 5),
                child: LocaleText(
                  "${listOfQuestions[questionNumber]}",
                  style: const TextStyle(
                      color: Color.fromRGBO(40, 112, 200, 1.0),
                      fontSize: 20,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ),
            //this Widget will show the image related to the question simultaneously
            Expanded(
              child: Stack(
                children: [
                  CarouselSlider(
                    carouselController: carouselController,
                    options: CarouselOptions(
                        height: 200, initialPage: 0, enlargeCenterPage: true),
                    items: listOfImages.map((e) {
                      return Container(
                        width: double.infinity,
                        child: Image.asset(
                          e,
                          width: 110,
                          height: 110,
                        ),
                      );
                    }).toList(),
                  ),
                  Opacity(
                    child: Container(
                        width: double.infinity,
                        height: 250,
                        color: Colors.black),
                    opacity: 0,
                  )
                ],
              ),
            ),

            //this Widget will show the question number
            Expanded(
              child: Container(
                  margin: const EdgeInsets.only(
                      top: 30, bottom: 20, right: 60, left: 60),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LocaleText(
                        "Question",
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        " ",
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        "${questionNumber + 1}",
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        " ",
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      LocaleText(
                        "of",
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        " ",
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        "19",
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  )),
            ),

            //this Widget will show the question number but as a colored circle not text
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildContainer(0),
                buildContainer(1),
                buildContainer(2),
                buildContainer(3),
                buildContainer(4),
                buildContainer(5),
                buildContainer(6),
                buildContainer(7),
                buildContainer(8),
                buildContainer(9),
                buildContainer(10),
                buildContainer(11),
                buildContainer(12),
                buildContainer(13),
                buildContainer(14),
                buildContainer(15),
                buildContainer(16),
                buildContainer(17),
                buildContainer(18),
              ],
            ),


//This consumer is used to call a specific provider class and interact with it
//here we call the CovidTestAnswers class so we can insert the answers of the covid test  and analyze it when finished
            Consumer<CovidTestAnswers>(builder: (context, mc, child) {
//this if statement will clear the answers list which could include values from previous tests
              if (questionNumber == 0) {
                mc.answers.clear();
              }
              return Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                        height: 60,
                        width: 100,
                        child: MaterialButton(
                          onPressed: () {
                            //if the user reached the last question (question 19) which have the index 18 will add the last answer  and that is false
                            //and then the checkForInfection() method will be called to check the users answers while loading screen appears
                            setState(() {
                              if (questionNumber == 18) {
                                mc.answers.add(false);
                                mc.checkForInfection();
                                Navigator.pushReplacement(context,PageTransition(
                                    alignment: Alignment.center,
                                    curve: Curves.ease,
                                    type: PageTransitionType.fade,child:Loading()),);

                              }
                              //if the user didn't reached the last question  will add answer false to that question and then increase the index to move to the next question
                              else if (questionNumber <= 18) {
                                carouselController.nextPage(
                                    curve: Curves.easeInExpo);
                                mc.answers.add(false);
                                questionNumber++;
                              }
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.cancel,
                                color: Colors.white,
                              ),
                              SizedBox(width: 5,),
                              LocaleText(
                                "No",
                                style: TextStyle(fontSize: 22),
                              ),
                            ],
                          ),
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          splashColor: Colors.red,
                          color: const Color(0xFFFF522B),
                          textColor: Colors.white,
                        )),
                    Container(
                        width: 100,
                        height: 60,
                        child: MaterialButton(
                          onPressed: () {
                            setState(() {
                              //if the user reached the last question (question 19) which have the index 18 will add the last answer and that is true
                              //and then the checkForInfection() method will be called to check the users answers while loading screen appears
                              if (questionNumber == 18) {
                                mc.answers.add(true);
                                mc.checkForInfection();
                                Navigator.pushReplacement(context,PageTransition(
                                    alignment: Alignment.center,
                                    curve: Curves.ease,
                                    type: PageTransitionType.fade,child:Loading()),);
                              }

                              //if the user didn't reached the last question  will add answer true to that question and then increase the index to move to the next question
                              else if (questionNumber <= 18) {
                                carouselController.nextPage(
                                    curve: Curves.easeInExpo);
                                mc.answers.add(true);
                                questionNumber++;
                              }
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.check_circle_sharp,
                                color: Colors.white,
                              ),
                              SizedBox(width: 5,),
                              LocaleText(
                                "Yes",
                                style: TextStyle(fontSize: 22),
                              ),
                            ],
                          ),
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          splashColor: Colors.green,
                          color: Colors.green,
                          height: 64,
                          textColor: Colors.white,
                        )),
                  ],
                ),
              );
            }),
          ],
        )),)


    );
  }
//this method will color one circle with a unique color that will indicate which question the user reached
  Container buildContainer(int questionIndex) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 1),
      width: 10,
      height: 10,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: questionIndex == questionNumber
              ? Theme.of(context).secondaryHeaderColor
              : Color(0xFFD2D2D2)),
    );
  }
}
