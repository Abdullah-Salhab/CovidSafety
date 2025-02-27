
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_locales/flutter_locales.dart';

import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'mysituation.dart';

class Previous extends StatefulWidget {
  const Previous({Key? key}) : super(key: key);

  @override
  _PreviousState createState() => _PreviousState();
}

class _PreviousState extends State<Previous> {
  CollectionReference ref = FirebaseFirestore.instance
      .collection("Users")
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .collection("Tests");
  late Color dayColor;
  int testNumber = 0;

  getDocumentsNumber() async {
    int counter = -1;
    QuerySnapshot qs = await ref.get();
    List<QueryDocumentSnapshot> listdoces = qs.docs;
    for (var item in listdoces) {
      counter++;
    }
    setState(() {
      testNumber = counter;
    });
  }

  @override
  void initState() {
    getDocumentsNumber();
    super.initState();
  }

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
        body: Stack(
          children: [

            SizedBox(height: 100,
              child: Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Center(
                      child: Card(
                        elevation:5,
                      shadowColor: Theme.of(context).secondaryHeaderColor,
                      child: Container(padding:EdgeInsets.all(10),width: 300,
                        child: const LocaleText(
                          "Total Number On Tests",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),

                        ),
                      ),
            ),
                    ),
                  ),  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Center(
                      child: Card( elevation: 5,
                        shadowColor: Theme.of(context).secondaryHeaderColor,
                        child: Container(padding:EdgeInsets.all(10),
                          child: Text(
                            "$testNumber",
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),),

            Container(
              margin: const EdgeInsets.only(top: 110),
              child: FutureBuilder(
                future: ref.orderBy("datetime", descending: true).get(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return ListView.separated(
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (context, i) {
                        dayColor = snapshot.data.docs[i].data()[
                                    'medical help was needed on that day'] ==
                              true
                            ? Color(0xC2FF0000)
                            : Colors.green;

                          print(snapshot.data.docs.length-1==i);
                        return Container(
                          margin: snapshot.data.docs.length-1==i?EdgeInsets.fromLTRB(12,5,12,20):EdgeInsets.symmetric(horizontal: 12),
                          child: MaterialButton(
                            color: dayColor,
                            height: 60,
                            elevation:8,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            splashColor: dayColor,
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(builder: (context) {
                                return MySituation(
                                    snapshot.data.docs[i].data()['date'],
                                    snapshot.data.docs[i].data()['time1']);
                              }));
                            },
                            child: Row(mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                LocaleText(
                                  "${snapshot.data.docs[i].data()['day']}",
                                  style: const TextStyle(
                                      fontSize: 16, color: Colors.white,fontFamily:"fantasy"

                                      ,fontWeight: FontWeight.w600 )),

                                SizedBox(width: 6,),
                                Text(
                                    "${snapshot.data.docs[i].data()['date']}",
                                    style: const TextStyle(
                                        fontSize: 16, color: Colors.white,fontFamily:"fantasy"

                       ,fontWeight: FontWeight.w600 )),
                                SizedBox(width: 6,),
                                Text(
                                    "${snapshot.data.docs[i].data()['time1']}",
                                    style: const TextStyle(
                                        fontSize: 16, color: Colors.white,fontFamily:"fantasy"

                                        ,fontWeight: FontWeight.w600 )),
                                SizedBox(width: 6,),
                                LocaleText(
                                    "${snapshot.data.docs[i].data()['time2']}",
                                    style: const TextStyle(
                                        fontSize: 16, color: Colors.white,fontFamily:"fantasy"

                                        ,fontWeight: FontWeight.w600 )),


                              ],
                            ),
                          ),
                        );

                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const Divider(color: Colors.grey,
                          height: 30,
                          thickness: 1,
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
                                  progressBarColor: Theme.of(context).secondaryHeaderColor,
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
            ),
          ],
        ));
  }
}
