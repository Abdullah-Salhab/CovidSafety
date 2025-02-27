import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_locales/flutter_locales.dart';

class Advices extends StatefulWidget {
  @override
  _AdvicesState createState() => _AdvicesState();
}

class _AdvicesState extends State<Advices> {
  int _indexCurrent = 0;
  int _indexCurrent2 = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
        body: content());
  }

  // slider
  Widget content() {
    // slider
    List images = [
      'assets/wear_mask.gif',
      'assets/safe-stay.gif',
      'assets/hand-wash.gif',
    ];
    List images2 = [
      'assets/Gloves.gif',
      'assets/medic.gif',
      'assets/social-dist.gif',
    ];
    List advices1 = [
      ['Wear a Mask','Mask_content'],
      ['Stay at Home','StayHome_content'],
      ['Hand Washing','Hand_content'],
    ];
    List advices2 = [
      ['Wear a Gloves','Gloves_content'],
      ['Take your Medicines','TakeMedic_content'],
      ['Social distancing','Distancing_content'],
    ];
    return DefaultTextStyle(
      style: TextStyle(color: Colors.lightBlue,fontSize: 20,),
      child: ListView(
        padding: EdgeInsets.only(bottom: 50),
        children: [
          SizedBox(height: 40,),
          Container(padding: EdgeInsets.symmetric(vertical: 15,),alignment: Alignment.center,decoration: BoxDecoration(
            color: Colors.grey.shade100,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 9,
                offset: Offset(5, 5), // changes position of shadow
              ),
            ],
            borderRadius: BorderRadius.circular(15),
          ),
              margin: EdgeInsets.symmetric(horizontal: 15),
              child: LocaleText("Advices and Tips",style: TextStyle(fontSize: 26,fontWeight: FontWeight.bold),)),
          SizedBox(height: 20,),
          CarouselSlider(
              items: images.map((images) {
                return Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 18),
                  child: Column(
                    children: [
                      SizedBox(height: 10,),
                      Expanded(child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.asset(images, fit: BoxFit.contain,))),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 10,),
                          LocaleText(advices1[_indexCurrent][0],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                          SizedBox(height: 10,),
                          LocaleText(advices1[_indexCurrent][1],style: TextStyle(color: Colors.grey,fontSize: 16),),
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),
              options: CarouselOptions(
                  height: 400,
                  initialPage: 0,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  autoPlayInterval: Duration(seconds: 5),
                  onPageChanged: (index, _) {
                    setState(() {
                      _indexCurrent = index;
                    });
                  }
              )
          ),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              items(0,1),
              items(1,1),
              items(2,1),
            ],
          ),
          SizedBox(height: 20,),
          CarouselSlider(
              items: images2.map((images) {
                return Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 18),
                  child: Column(
                    children: [
                      SizedBox(height: 10,),
                      Expanded(child: ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: Image.asset(images, fit: BoxFit.contain,))),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 10,),
                          LocaleText(advices2[_indexCurrent2][0],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                          SizedBox(height: 10,),
                          LocaleText(advices2[_indexCurrent2][1],style: TextStyle(color: Colors.grey,fontSize: 16),),
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),
              options: CarouselOptions(
                  height: 400,
                  initialPage: 0,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  autoPlayInterval: Duration(seconds: 7),
                  onPageChanged: (index, _) {
                    setState(() {
                      _indexCurrent2 = index;
                    });
                  }
              )
          ),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              items(0,2),
              items(1,2),
              items(2,2),
            ],
          ),
          SizedBox(height: 40,),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 50),
            child: ElevatedButton(onPressed: (){Navigator.of(context).pop();},
              child: LocaleText("Back To Dashboard",style: TextStyle(fontSize: 18),),),
          )
        ],
      ),
    );
  }
  // the content of each CarouselSlider
  Container items (int index,int currentIndex) {
    return Container(
      height: 10,
      width: 10,
      margin: EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: ((currentIndex==1?_indexCurrent:_indexCurrent2) == index) ? Colors.lightBlue : Theme.of(context).hintColor,
      ),
    );
  }
}
