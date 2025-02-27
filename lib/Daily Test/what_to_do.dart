import 'package:flutter_locales/flutter_locales.dart';
import 'package:graduation/Daily%20Test/result_daily.dart';
import 'package:graduation/Dashboard.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
// to make call
import 'package:url_launcher/url_launcher.dart';
import '../map2.dart';
import 'package:page_transition/page_transition.dart';
import 'package:graduation/myProvider.dart';

class WhatToDo extends StatefulWidget {
  const WhatToDo({Key? key}) : super(key: key);

  @override
  _WhatToDoState createState() => _WhatToDoState();
}

class _WhatToDoState extends State<WhatToDo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          toolbarHeight: 110,
          actions: [
            IconButton(
              padding: EdgeInsets.only(right: 10),
              onPressed: () {
                Navigator.pushReplacement(context,PageTransition(
                  alignment: context.read<MyProvider>().language == "English" ?Alignment.topRight:Alignment.topLeft,
                  curve: Curves.easeInOut,
                  duration: Duration(seconds: 2),
                  type: PageTransitionType.scale,child: Dashboard(),),);
              },
              icon: Icon(Icons.home),
            ),
          ],
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 10,
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
        body:  Container(
              height: double.infinity,
              width: double.infinity,
              color: const Color(0xFFECF1FA),
              child: ListView(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(

                        margin: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 10),
                        padding: const EdgeInsets.symmetric(
                            horizontal:6, vertical: 6),
                        child: const LocaleText(
                          "Warning!",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xC2FF0000),
                            fontSize: 26,
                          ),

                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Theme.of(context).shadowColor,
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: Offset(3, 3), // changes position of shadow
                            ),
                          ],
                          color: Colors.white,
                        ),
                        padding: const EdgeInsets.only(
                           top: 20, left: 20,right: 40,bottom: 20),
                        margin: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 10),
                        child:  LocaleText(
                          "You have symptoms that require medical help, so tap on the Show Map button to see the nearest hospital so you can go and get help.",
                          style: TextStyle(fontWeight: FontWeight.w400,
                            color: Theme.of(context).secondaryHeaderColor,
                            fontSize: 20,
                          ),

                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      MaterialButton(
                        color:  Theme.of(context).secondaryHeaderColor,
                        padding: EdgeInsets.symmetric(horizontal: 40,vertical: 5),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        onPressed: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return  Map2();
                          }));
                        },
                        child: const LocaleText(
                          "Show Map",
                          style: TextStyle(fontWeight: FontWeight.w400,
                            color: Colors.white,
                            fontSize: 20,
                          ),

                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Theme.of(context).shadowColor,
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: Offset(3, 3), // changes position of shadow
                            ),
                          ],
                          color: Colors.white,
                        ),
                        padding: const EdgeInsets.only(
                            top: 20, left: 20,right: 40,bottom: 20),
                        margin: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 10),
                        child:  LocaleText("if you feel that your symptoms are severe and you can't go by yourself to a nearby hospital ,or if there is no one can get you there ,then can call emergency ."
                          ,
                          style: TextStyle(fontWeight: FontWeight.w400,
                            color: Theme.of(context).secondaryHeaderColor,
                            fontSize: 20,
                          ),

                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      MaterialButton(
                        color:  Theme.of(context).secondaryHeaderColor,
                        padding: EdgeInsets.symmetric(horizontal: 40,vertical: 8),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        onPressed: () {
                          launch("tel://911");
                        },
                        child: const LocaleText(
                          "Call Emergency",
                          style: TextStyle(fontWeight: FontWeight.w400,
                            color: Colors.white,
                            fontSize: 20,
                          ),

                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                    ],
                  ),
                ],
              ),
            )


        );
  }
}
