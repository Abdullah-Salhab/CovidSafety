import 'package:graduation/Daily Test/prevoius.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MySituation extends StatelessWidget {
  var date;
  var time;
  bool highFever = false;
  bool highFeverThreeDays = false;
  bool highFeverSupriseingSpike = false;
  List<String> fever = [" ", " ", " "];
  MySituation(String snap, String time) {
    date = snap;
    this.time = time;
  }

  CollectionReference ref = FirebaseFirestore.instance
      .collection("Users")
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .collection("Tests");

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
                  children: [
                    IconButton(
                      iconSize: 25,
                      color: Color(0xC2FF0000),
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) {
                          return const Previous();
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
            child: SafeArea(
                child: Container(
              margin: EdgeInsets.symmetric(horizontal: 7),
              color: const Color(0xFFECF1FA),
              child: FutureBuilder(
                future: ref
                    .where("date", isEqualTo: date)
                    .where("time1", isEqualTo: time)
                    .get(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (context, i) {
                        highFever = snapshot.data.docs[i]
                            .data()['medicalHelpIsNeededHighFever'];
                        highFeverThreeDays = snapshot.data.docs[i]
                            .data()['medicalHelpIsNeededHighFeverForThreeDays'];
                        highFeverSupriseingSpike = snapshot.data.docs[i].data()[
                            'medicalHelpIsNeededFoundSurprisingSpikeInTemperature'];
                        fever = [" ", " ", " "];
                        if (highFever == true) {
                          fever.insert(
                              0, "High fever above 38.5 C, 101.3 F not safe.");
                        }
                        if (highFeverThreeDays == true) {
                          fever.insert(1,
                              "persists fever above 101 F/38.3 C for 3 days, not safe.");
                        }
                        if (highFeverSupriseingSpike == true) {
                          fever.insert(2,
                              "you had a high fever before, then it went down, and then it rose again today, not safe.");
                        }

                        return Column(
                          children: [
                            //date of test
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  LocaleText(
                                      "${snapshot.data.docs[i].data()['day']}",
                                      style: const TextStyle(
                                          fontSize: 20,
                                          color:
                                              Color.fromRGBO(40, 112, 200, 1.0),
                                          fontFamily: "fantasy",
                                          fontWeight: FontWeight.w400)),
                                  Text(", ",
                                      style: const TextStyle(
                                          fontSize: 16,
                                          color:
                                              Color.fromRGBO(40, 112, 200, 1.0),
                                          fontFamily: "fantasy",
                                          fontWeight: FontWeight.w600)),
                                  SizedBox(
                                    width: 6,
                                  ),
                                  Text(
                                      "${snapshot.data.docs[i].data()['date']}",
                                      style: const TextStyle(
                                          fontSize: 20,
                                          color:
                                              Color.fromRGBO(40, 112, 200, 1.0),
                                          fontFamily: "fantasy",
                                          fontWeight: FontWeight.w400)),
                                  SizedBox(
                                    width: 6,
                                  ),
                                  Text(
                                      "${snapshot.data.docs[i].data()['time1']}",
                                      style: const TextStyle(
                                          fontSize: 20,
                                          color:
                                              Color.fromRGBO(40, 112, 200, 1.0),
                                          fontFamily: "fantasy",
                                          fontWeight: FontWeight.w400)),
                                  SizedBox(
                                    width: 6,
                                  ),
                                  LocaleText(
                                      "${snapshot.data.docs[i].data()['time2']}",
                                      style: const TextStyle(
                                          fontSize: 20,
                                          color:
                                              Color.fromRGBO(40, 112, 200, 1.0),
                                          fontFamily: "fantasy",
                                          fontWeight: FontWeight.w400)),
                                ],
                              ),
                            ),

                            const SizedBox(
                              height: 20,
                            ),

                            SizedBox(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: const Color(0xFFFFFFFF),
                                    borderRadius: BorderRadius.circular(5),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Theme.of(context).shadowColor,
                                        spreadRadius: 4,
                                        blurRadius: 5,
                                        offset: Offset(
                                            0, 5), // changes position of shadow
                                      ),
                                    ]),
                                child: MaterialButton(
                                  padding: const EdgeInsets.only(
                                      top: 15, bottom: 15),
                                  highlightColor:
                                      Color.fromRGBO(191, 220, 255, 1.0),
                                  onPressed: () {},
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        "assets/images/Thermometer.png",
                                        width: 90,
                                        height: 90,
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: const LocaleText(
                                          "Temperature",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                              color: Color.fromRGBO(
                                                  40, 112, 200, 1.0)),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: Text(
                                              " ${snapshot.data.docs[i].data()['temperature']} ",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Color.fromRGBO(
                                                      40, 112, 200, 1.0)),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: LocaleText(
                                              "${snapshot.data.docs[i].data()['temperature unit']}",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Color.fromRGBO(
                                                      40, 112, 200, 1.0)),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: highFever == true ||
                                                  highFeverThreeDays == true ||
                                                  highFeverSupriseingSpike ==
                                                      true
                                              ? Column(
                                                  children: [
                                                    LocaleText(
                                                      fever[0],
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        color:
                                                            Color(0xC2FF0000),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    LocaleText(
                                                      fever[1],
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        color:
                                                            Color(0xC2FF0000),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    LocaleText(
                                                      fever[2],
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        color:
                                                            Color(0xC2FF0000),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              : LocaleText("Safe.",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.green,
                                                  ))),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),

                            SizedBox(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: const Color(0xFFFFFFFF),
                                    borderRadius: BorderRadius.circular(5),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Theme.of(context).shadowColor,
                                        spreadRadius: 4,
                                        blurRadius: 5,
                                        offset: Offset(
                                            0, 5), // changes position of shadow
                                      ),
                                    ]),
                                child: MaterialButton(
                                  padding: const EdgeInsets.only(
                                      top: 15, bottom: 15),
                                  highlightColor:
                                      Color.fromRGBO(191, 220, 255, 1.0),
                                  onPressed: () {},
                                  child: Column(
                                    children: [
                                      Image.asset(
                                        "assets/images/oximeter.png",
                                        width: 90,
                                        height: 90,
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Column(
                                        children: [
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: const LocaleText(
                                              "Oxygen Level",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color.fromRGBO(
                                                      40, 112, 200, 1.0)),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                                " ${snapshot.data.docs[i].data()['oxygen level']}",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Color.fromRGBO(
                                                        40, 112, 200, 1.0))),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        child: snapshot.data.docs[i].data()[
                                                    'medicalHelpIsNeededOxygenLevel'] ==
                                                true
                                            ? Padding(
                                                padding:
                                                    const EdgeInsets.all(2),
                                                child: const LocaleText(
                                                  "Low oxygen level, not safe.",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: Color(0xC2FF0000),
                                                  ),
                                                ),
                                              )
                                            : const LocaleText("Safe.",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.green)),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            symptomValue(
                                Theme.of(context).shadowColor,
                                "assets/images/breathing.png",
                                "Breathing",
                                snapshot.data.docs[i].data()['breathing'],
                                snapshot.data.docs[i]
                                    .data()['medicalHelpIsNeededBreathing']),
                            const SizedBox(
                              height: 20,
                            ),
                            symptomValue(
                                Theme.of(context).shadowColor,
                                "assets/images/cough.png",
                                "Coughing",
                                snapshot.data.docs[i].data()['coughing'],
                                snapshot.data.docs[i]
                                    .data()['medicalHelpIsNeededCough']),
                            const SizedBox(
                              height: 20,
                            ),

                            symptomValue(
                                Theme.of(context).shadowColor,
                                "assets/images/fatigue and tiredness.png",
                                "Fatigue",
                                snapshot.data.docs[i].data()['fatigue'],
                                snapshot.data.docs[i]
                                    .data()['medicalHelpIsNeededFatigue']),

                            const SizedBox(
                              height: 20,
                            ),

                            symptomValue(
                                Theme.of(context).shadowColor,
                                "assets/images/Bluish.png",
                                "Bluish face or lips",
                                snapshot.data.docs[i]
                                    .data()['bluish face or lips'],
                                snapshot.data.docs[i]
                                    .data()['medicalHelpIsNeededBluish']),

                            const SizedBox(
                              height: 20,
                            ),
                            symptomValue(
                                Theme.of(context).shadowColor,
                                "assets/images/chest.png",
                                "Chest pain",
                                snapshot.data.docs[i].data()['chest pain'],
                                snapshot.data.docs[i]
                                    .data()['medicalHelpIsNeededChestPain']),

                            const SizedBox(
                              height: 20,
                            ),

                            symptomValue(
                                Theme.of(context).shadowColor,
                                "assets/images/blood.png",
                                "Coughing up blood",
                                snapshot.data.docs[i]
                                    .data()['coughing up blood'],
                                snapshot.data.docs[i]
                                    .data()['medicalHelpIsNeededCoughBlood']),

                            const SizedBox(
                              height: 20,
                            ),

                            symptomValue(
                                Theme.of(context).shadowColor,
                                "assets/images/part of your body.png",
                                "Loss of feeling in a part of the body",
                                snapshot.data.docs[i].data()[
                                    'loss of feeling in a part of the body'],
                                snapshot.data.docs[i]
                                    .data()['medicalHelpIsNeededBodyPart']),
                            const SizedBox(
                              height: 20,
                            ),
                            symptomValue(
                                Theme.of(context).shadowColor,
                                "assets/images/collapse.png",
                                "Collapse or faint",
                                snapshot.data.docs[i].data()['collapse'],
                                snapshot.data.docs[i]
                                    .data()['medicalHelpIsNeededCollapse']),
                            const SizedBox(
                              height: 20,
                            ),

                            symptomValue(
                                Theme.of(context).shadowColor,
                                "assets/images/diarrhea.png",
                                "Non-stopping diarrhea-causing you dehydration, dizziness, tiredness",
                                snapshot.data.docs[i].data()[
                                    'non stopping diarrhea causing you dehydration, dizziness, tiredness'],
                                snapshot.data.docs[i]
                                    .data()['medicalHelpIsNeededDiarrhea']),
                            const SizedBox(
                              height: 20,
                            ),

                            symptomValue(
                                Theme.of(context).shadowColor,
                                "assets/images/peeing.png",
                                "Peeing",
                                snapshot.data.docs[i].data()['peeing'],
                                snapshot.data.docs[i]
                                    .data()['medicalHelpIsNeededPeeing']),

                            const SizedBox(
                              height: 20,
                            ),

                            symptomValue(
                                Theme.of(context).shadowColor,
                                "assets/images/motionOrSpeaking.png",
                                "Lost your ability to move or speak",
                                snapshot.data.docs[i].data()[
                                    'lost your ability to move or speak'],
                                snapshot.data.docs[i].data()[
                                    'medicalHelpIsNeededLossOfMotionOrSpeak']),

                            const SizedBox(
                              height: 20,
                            ),

                            symptomValue(
                                Theme.of(context).shadowColor,
                                "assets/images/consciousness.png",
                                "Consciousness",
                                snapshot.data.docs[i].data()['consciousness'],
                                snapshot.data.docs[i]
                                    .data()['medicalHelpIsNeededConfusion']),
                            const SizedBox(
                              height: 20,
                            ),

                            symptomValue(
                                Theme.of(context).shadowColor,
                                "assets/images/wake.png",
                                "waking and staying awake without collapsing",
                                snapshot.data.docs[i]
                                    .data()['waking and staying awake'],
                                snapshot.data.docs[i]
                                    .data()['medicalHelpIsNeededWake']),
                            const SizedBox(
                              height: 20,
                            ),

                            SizedBox(
                              width: 400,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: const Color(0xFFFFFFFF),
                                    borderRadius: BorderRadius.circular(5),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Theme.of(context).shadowColor,
                                        spreadRadius: 4,
                                        blurRadius: 5,
                                        offset: Offset(
                                            0, 5), // changes position of shadow
                                      ),
                                    ]),
                                child: MaterialButton(
                                  padding: const EdgeInsets.only(
                                      top: 15, bottom: 15, left: 5, right: 5),
                                  highlightColor:
                                      Color.fromRGBO(191, 220, 255, 1.0),
                                  onPressed: () {},
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        "assets/images/medical.png",
                                        width: 90,
                                        height: 90,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: const LocaleText(
                                          "Medical help was needed on this day",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Color.fromRGBO(
                                                  40, 112, 200, 1.0)),
                                        ),
                                      ),
                                      Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: snapshot.data.docs[i].data()[
                                                      'medical help was needed on that day'] ==
                                                  true
                                              ? LocaleText(
                                                  "Yes.",
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    color: Color.fromRGBO(
                                                        40, 112, 200, 1.0),
                                                  ),
                                                )
                                              : LocaleText(
                                                  "No.",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Color.fromRGBO(
                                                          40, 112, 200, 1.0)),
                                                )),
                                      Container(
                                        child: snapshot.data.docs[i].data()[
                                                    'medical help was needed on that day'] ==
                                                true
                                            ? Padding(
                                                padding:
                                                    const EdgeInsets.all(2),
                                                child: const LocaleText(
                                                  "Not Safe.",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: Color(0xC2FF0000),
                                                  ),
                                                ),
                                              )
                                            : Padding(
                                                padding:
                                                    const EdgeInsets.all(2.0),
                                                child: const LocaleText("Safe.",
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.green)),
                                              ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),

                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        );
                      },
                    );
                  }
                  if (snapshot.hasError) {
                    return const Text("data error");
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return SizedBox(
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SleekCircularSlider(
                            appearance: CircularSliderAppearance(
                              size: 70,
                              spinnerMode: true,
                              infoProperties: InfoProperties(
                                  mainLabelStyle: const TextStyle(
                                      color: Colors.blue, fontSize: 20)),
                              startAngle: 90,
                              angleRange: 330,
                              customWidths: CustomSliderWidths(
                                progressBarWidth: 6,
                              ),
                              customColors: CustomSliderColors(
                                  dotColor: Colors.transparent,
                                  progressBarColor:
                                      Theme.of(context).secondaryHeaderColor,
                                  trackColor: Colors.transparent),
                            ),
                            initialValue: 0,
                            max: 100,
                            onChange: (v) {},
                          ),
                        ],
                      ),
                    );
                  }

                  return const Text("data");
                },
              ),
            ))));
  }

  symptomValue(Color shadow, String image, String symptom, String symptom1,
      bool symptom2) {
    return SizedBox(
      width: double.infinity,
      child: Container(
        decoration: BoxDecoration(
            color: const Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                color: shadow,
                spreadRadius: 4,
                blurRadius: 5,
                offset: Offset(0, 5), // changes position of shadow
              ),
            ]),
        child: MaterialButton(
          padding:
              const EdgeInsets.only(top: 15, bottom: 15, left: 5, right: 5),
          highlightColor: Color.fromRGBO(191, 220, 255, 1.0),
          onPressed: () {},
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                image,
                width: 90,
                height: 90,
              ),
              SizedBox(
                height: 5,
              ),
              LocaleText(
                symptom,
                style: TextStyle(
                    fontSize: 18,
                    color: Color.fromRGBO(40, 112, 200, 1.0),
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: LocaleText(
                    symptom1,
                    style: TextStyle(
                        fontSize: 16, color: Color.fromRGBO(40, 112, 200, 1.0)),
                  )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: symptom2 == true
                    ? Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: LocaleText("Not Safe.",
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xC2FF0000),
                            )),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: const LocaleText("Safe.",
                            style:
                                TextStyle(fontSize: 16, color: Colors.green)),
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
