//this page shows the most frequently asked questions about covid-19,this page doesn't need an account to view it

import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';//animation transition page

class FrequentlyQuestions extends StatefulWidget {
  const FrequentlyQuestions({Key? key}) : super(key: key);

  @override
  _FrequentlyQuestionsState createState() => _FrequentlyQuestionsState();
}

class _FrequentlyQuestionsState extends State<FrequentlyQuestions> {
  var questions = [
    //this variable have the first part of questions
    "What is Covid-19?",
    "How does the COVID-19 virus spread?",
    "Are the COVID-19 vaccines safe and effective?",
    "Will my child be able to get the COVID-19 vaccine?",
    "Do the COVID-19 vaccines work against the new variants?",
    "How can I protect myself and others from COVID-19?",
    "Should I wear a medical mask to protect against COVID-19?",
    "Does COVID-19 affect children?",
    "Is it safe for a mother to breastfeed if she is infected with COVID-19?",
  ];
  var Questions1 = [
    //this variable have the second part of questions
    "How can I protect myself and others from COVID-19?",
    "Should I wear a medical mask to protect against COVID-19?",
    "Does COVID-19 affect children?",
    "Is it safe for a mother to breastfeed if she is infected with COVID-19?"
  ];

  var answers = [
    //this variable have the first part of answers
    "COVID-19 is an infectious respiratory illness caused by a newly discovered coronavirus called SARS-CoV-2. "
    " ‘CO’ stands for corona,‘VI’ for virus, and ‘D’ for disease.",
    "COVID-19 virus spread answer",
    "All three vaccines authorized or approved by the Food and Drug Administration (FDA) have been thoroughly tested and found to be safe and effective in preventing severe COVID-19. They continue to undergo continuous and intense safety monitoring.",
    "child be able to get the COVID-19 vaccine answer",
    "Yes. According to the Centers for Disease Control and Prevention (CDC), the COVID-19 vaccines offer protection against infection by most variants. Most important, they have prevented serious illness, hospitalization, and death, even at a time when new variants are spreading around the world.",
  ];

  var Answers1 = [
    //this variable have the second part of answers
    "Get Vaccinated,Wear a mask,Stay 6 feet away from others,Avoid crowds and poorly ventilated spaces,Wash your hands often,Cover coughs and sneezes,Clean and disinfect And Monitor your health daily.",
    "Masks should be used as part of a comprehensive strategy of measures to suppress transmission and save lives; the use of a mask alone is not sufficient to provide an adequate level of protection against COVID-19.",
    "children with COVID-19 have milder effects and better prognoses than adults. However, children are susceptible to multisystem inflammatory syndrome, a rare but life-threatening systemic illness involving persistent fever and extreme inflammation following exposure to the SARS-CoV-2 virus.",
    "Coronavirus has not been found in breast milk. It’s safe to breastfeed if you have COVID-19. But new moms with COVID-19 could spread the virus to their infant through tiny droplets that spread when they talk, cough, or sneeze."
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              SizedBox(height: 50),
              Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 15,
                  ),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.4),
                        spreadRadius: 2,
                        blurRadius: 9,
                        offset: Offset(5, 5), // changes position of shadow
                      ),
                    ],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  child: LocaleText(
                    "COVID-19: Frequently asked questions",
                    style: GoogleFonts.signikaNegative(textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 18,color: Colors.lightBlue,)),
                  )),
              SizedBox(height: 40),
              CreateRowforQuestions(questions[0], answers[0]),
              Divider(
                thickness: 1,
              ),
              CreateRowforQuestions(questions[1], answers[1]),
              Divider(
                thickness: 1,
              ),
              CreateRowforQuestions(questions[2], answers[2]),
              Divider(
                thickness: 1,
              ),
              CreateRowforQuestions(questions[3], answers[3]),
              Divider(
                thickness: 1,
              ),
              CreateRowforQuestions(questions[4], answers[4]),
              Divider(
                thickness: 1,
              ),
              CreateRowforQuestions(Questions1[0], Answers1[0]),
              Divider(
                thickness: 1,
              ),
              CreateRowforQuestions(Questions1[1], Answers1[1]),
              SizedBox(height: 20),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 50),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: LocaleText(
                    "Back To Dashboard",
                    style: GoogleFonts.signikaNegative(textStyle: TextStyle(fontSize: 18,)),
                  ),
                ),
              ),
              SizedBox(height: 20,),
            ],
          ),
        ),
      ),
    );
  }

//this function creates rows for questions
  Widget CreateRowforQuestions(String str1, String str2) {
    return ListTile(
      onTap: () {
        Navigator.push(context,PageTransition(
          alignment: Alignment.center,
          curve: Curves.easeInOut,
          duration: Duration(seconds: 1),
          type: PageTransitionType.size,child: GoToAnswerPage(str1, str2),),);
      },
      title:  Row(
        children: [
          Expanded(
            child: SizedBox(
              child: LocaleText(
                str1,
                style: GoogleFonts.signikaNegative(textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ),
            ),
          ),
          SizedBox(width: 40,),
          Row(
            children: [
              LocaleText("See more",
                  style: GoogleFonts.signikaNegative(textStyle: TextStyle(color: Colors.lightBlue,fontWeight: FontWeight.bold,fontSize: 16))),
              SizedBox(width: 5,),
              Icon(
                  Icons.arrow_forward_ios_sharp,
                  size: 16,color: Colors.lightBlue
              ),
            ],
          ),
        ],
      ),
    );
  }

//this function creates a whole page for the answer of the selected question
  Widget GoToAnswerPage(String str1, String str2) {
    return Scaffold(
      appBar: AppBar(
        title: Text(" "),
        centerTitle: true,
        backgroundColor: Theme.of(context).canvasColor,
        iconTheme: IconThemeData( color: Colors. lightBlue,  ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10 ,horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
      children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: LocaleText(
              str1,
              style: GoogleFonts.signikaNegative(textStyle:TextStyle(fontWeight: FontWeight.bold, fontSize: 18,)),
            ),
          ),
          SizedBox(height: 3),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Divider(
              thickness: 1.5,
              height: 15,
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: LocaleText(
              str2,
              style: GoogleFonts.signikaNegative(textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ),
          ),
      ],
          ),
        ),
      ),
    );
  }
}
