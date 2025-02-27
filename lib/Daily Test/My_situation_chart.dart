import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'prevoius.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:page_transition/page_transition.dart';

class BarChartSample extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BarChartSampleState();
}

class BarChartSampleState extends State<BarChartSample> {
  bool isLoad = false;
  CollectionReference ref = FirebaseFirestore.instance
      .collection("Users")
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .collection("Tests");
  static List allData=[];
  static String group="Celsius";
  // List Data=[];

  getTemperaturesAndOxygen()async{
    QuerySnapshot data =await ref.orderBy("datetime", descending: true).get();
    // QuerySnapshot data2 =await ref.orderBy("datetime", descending: true).get();
    //     data2.docs.forEach((element) {
    //       setState(() {
    //         Data.add(element.data());
    //       });
    //     });
    setState(() {
        allData = data.docs.map((doc) => doc.data()).toList();
    });
  }

  @override
  void initState() {
    getTemperaturesAndOxygen().whenComplete((){
      setState(() {
        isLoad = true;
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: LocaleText("My Situation",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
        centerTitle: true,
        actions: [
          Row(
            children: [
              IconButton(
                tooltip: "Previous Tests",
                  onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => Previous()),);
              }, icon: Icon(Icons.folder_shared) ),
            ],
          )
        ],
      ),
      body: isLoad?SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20,),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).primaryColor,
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).shadowColor,
                      spreadRadius: 4,
                      blurRadius: 5,
                      offset: Offset(0, 2), // changes position of shadow
                    ),
                  ],
                ),
                child: LocaleText("Temperature",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.white),)),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      group = "Celsius";
                    });
                  },
                  child: Row(
                    children: [
                      Radio(
                          activeColor:
                          Theme.of(context).secondaryHeaderColor,
                          value: "Celsius",
                          groupValue: group,
                          onChanged: (val) {setState(() {
                            group = "Celsius";
                          });}),
                      LocaleText("Celsius",
                          style: TextStyle(
                            fontSize: 18,
                            color: Color.fromRGBO(40, 112, 200, 1.0),
                          )),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      group = "Fahrenheit";
                    });
                  },
                  child: Row(
                    children: [
                      Radio(
                          activeColor:
                          Theme.of(context).secondaryHeaderColor,
                          value: "Fahrenheit",
                          groupValue: group,
                          onChanged: (val) { setState(() {
                            group = "Fahrenheit";
                          }); }),
                      LocaleText("Fahrenheit",
                          style: TextStyle(
                            fontSize: 18,
                            color: Color.fromRGBO(40, 112, 200, 1.0),
                          )),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 10,),

            Container(
              height: 300,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: AspectRatio(
                  aspectRatio:allData.length>15? 3.5:allData.length>7? 2.5:allData.length>4?1.7:1.35,
                  child: Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                    color: const Color(0xff2c4260),
                    child: group=="Celsius"?_BarChart():_BarChart(),
                  ),
                ),
              ),
            ),
            SizedBox(height: 5,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      color: Colors.green,
                      width: 15,
                      height: 15,
                    ),
                    SizedBox(width: 4,),
                    Text("Normal",style: TextStyle(fontSize: 14),),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      color: Colors.red.shade600,
                      width: 15,
                      height: 15,
                    ),
                    SizedBox(width: 4,),
                    Text("Not Normal",style: TextStyle(fontSize: 14),),
                  ],
                ),
              ],
            ),
            SizedBox(height: 25,),
            Divider(thickness: 4,),
            SizedBox(height: 15,),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).primaryColor,
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).shadowColor,
                      spreadRadius: 4,
                      blurRadius: 5,
                      offset: Offset(0, 2), // changes position of shadow
                    ),
                  ],
                ),
                child: LocaleText("Oxygen Level",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.white),)),

            SizedBox(height: 25,),
            Container(
              height: 300,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: AspectRatio(
                  aspectRatio:allData.length>15? 3.5:allData.length>7? 2.5:allData.length>4?1.7:1.35,
                  child: Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                    color: const Color(0xff2c4260),
                    child: _BarChart2(),
                  ),
                ),
              ),
            ),
            SizedBox(height: 5,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      color: Colors.greenAccent,
                      width: 15,
                      height: 15,
                    ),
                    SizedBox(width: 4,),
                    Text("Normal",style: TextStyle(fontSize: 14),),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      color: Colors.redAccent.shade200,
                      width: 15,
                      height: 15,
                    ),
                    SizedBox(width: 4,),
                    Text("Not Normal",style: TextStyle(fontSize: 14),),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20,),
            // Container(
            //   margin: EdgeInsets.symmetric(horizontal: 50),
            //   child: ElevatedButton(onPressed: (){
            //     Navigator.push(context,PageTransition(
            //       alignment: Alignment.center,
            //       curve: Curves.easeInOut,
            //       duration: Duration(seconds: 1),
            //       type: PageTransitionType.size,child: Previous()),);
            //   },
            //     child: LocaleText("previous check-ups",style: TextStyle(fontSize: 18),),),
            // )
            // Column(
            //   children: [
            //     for(int i =0;i<allData.length;i++)
            //       Text("${allData[i]['oxygen level']}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
            //   ],
            // )
          ],
        ),
      ):Center(child: CircularProgressIndicator(strokeWidth: 6)),
    );
  }
}



class _BarChart extends StatelessWidget {

  get allData =>BarChartSampleState.allData;

  get tempType => BarChartSampleState.group;



  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        barTouchData: barTouchData,
        titlesData: titlesData,
        borderData: borderData,
        barGroups: barGroups,
        alignment: BarChartAlignment.spaceAround,
        maxY: (tempType=="Celsius")?47:125,
      ),
    );
  }

  BarTouchData get barTouchData => BarTouchData(
    enabled: false,
    touchTooltipData: BarTouchTooltipData(
      tooltipBgColor: Colors.transparent,
      tooltipPadding: const EdgeInsets.all(0),
      tooltipMargin: 8,
      getTooltipItem: (
          BarChartGroupData group,
          int groupIndex,
          BarChartRodData rod,
          int rodIndex,
          ) {
        return BarTooltipItem(
          rod.y.toString(),
          const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        );
      },
    ),
  );

  FlTitlesData get titlesData => FlTitlesData(
    show: true,
    bottomTitles: SideTitles(
      showTitles: true,
      getTextStyles: (context, value) => const TextStyle(
        color: Color(0xff7589a2),
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
      margin: 20,
      getTitles: (double value) {
        // day
        return value.toInt().toString();
      },
    ),
    leftTitles: SideTitles(showTitles: false),
    topTitles: SideTitles(showTitles: false),
    rightTitles: SideTitles(showTitles: false),
  );

  FlBorderData get borderData => FlBorderData(
    show: false,
  );

  createBarData(xVal , yVal, allDataTest){
    // change to temperature Fahrenheit
    if(yVal>41 && tempType=="Celsius" )
      yVal = ((yVal - 32) * 5/9) ;
    // change to temperature Celsius
    if(yVal<41 && tempType=="Fahrenheit")
      yVal = (yVal * 9/5) + 32 ;
    // make round to 2 digits
    var validLength= yVal.toString().length>7;
    yVal = validLength?double.parse(yVal.toStringAsFixed(2)):yVal;
    // change the color if not safe
    bool notSafe=false;
    if (allDataTest['medicalHelpIsNeededHighFever'] == true ||
        allDataTest['medicalHelpIsNeededHighFeverForThreeDays'] == true ||
        allDataTest['medicalHelpIsNeededFoundSurprisingSpikeInTemperature'] == true ||
        allDataTest['medicalHelpIsNeededLowTemperature'] == true )
      notSafe=true;


    return BarChartGroupData(
      x: xVal,
      barRods: [
        BarChartRodData(
            y: yVal, colors: notSafe?[Colors.green, Color(0xFFA10000)]:[Color(0xFF00A115),Color(0xFFB9BF00) ])
      ],
      showingTooltipIndicators: [0],
    );
  }


  List<BarChartGroupData> get barGroups => [
    for(int i =0;i<allData.length;i++)
    createBarData(int.parse( allData[i]['date'].toString().split('-').first)  , allData[i]['temperature'],allData[i]),
  ];
}

class _BarChart2 extends StatelessWidget {
  get allData =>BarChartSampleState.allData;
  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        barTouchData: barTouchData,
        titlesData: titlesData,
        borderData: borderData,
        barGroups: barGroups,
        alignment: BarChartAlignment.spaceAround,
        maxY: 120,
      ),
    );
  }

  BarTouchData get barTouchData => BarTouchData(
    enabled: false,
    touchTooltipData: BarTouchTooltipData(
      tooltipBgColor: Colors.transparent,
      tooltipPadding: const EdgeInsets.all(0),
      tooltipMargin: 8,
      getTooltipItem: (
          BarChartGroupData group,
          int groupIndex,
          BarChartRodData rod,
          int rodIndex,
          ) {
        return BarTooltipItem(
          rod.y.toString(),
          const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        );
      },
    ),
  );

  FlTitlesData get titlesData => FlTitlesData(
    show: true,
    bottomTitles: SideTitles(
      showTitles: true,
      getTextStyles: (context, value) => const TextStyle(
        color: Color(0xff7589a2),
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
      margin: 20,
      getTitles: (double value) {
        return value.toInt().toString();
        // switch (value.toInt()) {
        //   case 0:
        //     return 'Mn';
        //   case 1:
        //     return 'Te';
        //   case 2:
        //     return 'Wd';
        //   case 3:
        //     return 'Tu';
        //   case 4:
        //     return 'Fr';
        //   case 5:
        //     return 'St';
        //   case 6:
        //     return 'Sn';
        //   default:
        //     return 'Sn';
        // }
      },
    ),
    leftTitles: SideTitles(showTitles: false),
    topTitles: SideTitles(showTitles: false),
    rightTitles: SideTitles(showTitles: false),
  );

  FlBorderData get borderData => FlBorderData(
    show: false,
  );

  createBarData(xVal , yVal, allDataTest){
    // change the color if not safe
    bool notSafe=false;
    if (allDataTest['medicalHelpIsNeededOxygenLevel'] == true )
      notSafe=true;
    return BarChartGroupData(
      x: xVal,
      barRods: [
        BarChartRodData(
            y: yVal, colors: notSafe?[Colors.blueAccent, Colors.red]:[Colors.greenAccent, Color(0xff005ea7)])
      ],
      showingTooltipIndicators: [0],
    );
  }

  List<BarChartGroupData> get barGroups => [
    for(int i =0;i<allData.length;i++)
      createBarData(int.parse( allData[i]['date'].toString().split('-').first)  , allData[i]['oxygen level'] , allData[i]),
  ];
}

