import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

import 'result_daily.dart';

class LoadingTwo extends StatefulWidget {
  const LoadingTwo({Key? key}) : super(key: key);

  @override
  _LoadingTwoState createState() => _LoadingTwoState();
}

class _LoadingTwoState extends State<LoadingTwo> {
  Future getResult() async {
    Future.delayed(const Duration(seconds: 10), () {
      Navigator.pushReplacement(context,PageTransition(
          alignment: Alignment.center,
          curve: Curves.ease,
          type: PageTransitionType.bottomToTop,child:ResultDaily()),);
    });
  }

  @override
  void initState() {
    getResult();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: Container(
              width: double.infinity,
              color: Theme.of(context).secondaryHeaderColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Image.asset(
                    "assets/images/CS2.png",
                    width: 230,
                    height: 230,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  LocaleText(
                    "Analyzing your answers",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
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
                          progressBarColor: Colors.white,
                          trackColor: Colors.transparent),
                    ),
                    initialValue: 0,
                    max: 100,
                    onChange: (v) {},
                  ),
                  LocaleText(
                    "Please wait",
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            )));
  }
}
