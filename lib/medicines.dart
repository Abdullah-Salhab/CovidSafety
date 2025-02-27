import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'storage_manager.dart';
import 'addMedicines.dart';
import 'medicEdit.dart';

// main screen for medicines
class Medicines extends StatefulWidget {

  // list of chronic medicines names
  static List<String> medicName=[
    // Medicine 1
    // Medicine 2
    // Medicine 3
  ];

  // list of times for each chronic medicine
  static  var medicTimesAdded=[
    // [TimeOfDay(hour: 7, minute: 30),TimeOfDay(hour: 9, minute: 20),TimeOfDay(hour: 5, minute: 20)],
    // [TimeOfDay(hour: 8, minute: 30),TimeOfDay(hour: 10, minute: 40)],
    // [TimeOfDay(hour: 9, minute: 15)],
  ];

  // list of boolean for each chronic medicine time if take or not
  static var medicTaken=[
    // [false,false,false],
    // [false,false],
    // [false],
  ];
  // list of id's number for each chronic medicine
  static var medicTimesId=[[1, 2, 3], [4, 5, 6], [7, 8, 9], [10, 11, 12], [13, 14, 15],
    [16, 17, 18], [19, 20, 21], [22, 23, 24], [25, 26, 27], [28, 29, 30]];

  // list of covid medicines names
  static List<String> covidMedicName=[
    // "covid Medicine 1",
  ];
  // list of times for each covid medicine
  static var covidMedicTimesAdded=[
    // [TimeOfDay(hour: 7, minute: 30),TimeOfDay(hour: 9, minute: 20),TimeOfDay(hour: 5, minute: 20)],
  ];
  // list of boolean for each covid medicine time if take or not
  static var covidMedicTaken=[
    // [false,false,false],
  ];
  // list of id's number for each covid medicine
  static var covidMedicTimesId=[[31, 32, 33], [34, 35, 36], [37, 38, 39],
    [40, 41, 42], [43, 44, 45], [46, 47, 48], [49, 50, 51], [52, 53, 54],
    [55, 56, 57], [58, 59, 60]];
  @override
  _MedicinesState createState() => _MedicinesState();
}

class _MedicinesState extends State<Medicines> {
  get listMedic=>Medicines.medicTimesAdded;
  get medicTaken=>Medicines.medicTaken;
  get medicName => Medicines.medicName;
  get medicTimesId => Medicines.medicTimesId;

  get covidMedic=>Medicines.covidMedicTimesAdded;
  get covidMedicTaken=>Medicines.covidMedicTaken;
  get covidMedicName => Medicines.covidMedicName;
  get covidMedicTimesId => Medicines.covidMedicTimesId;


  @override
  void initState() {
    super.initState();
    // set and get the data from shared preferences
    getFromSharedPreferences(false);
  }

  getFromSharedPreferences(isDeletedEnable) async{
  // get the values that saved in cache and set it to variables here
    getAndSetMedicinesNames(isDeletedEnable);
    getAndSetMedicTaken(isDeletedEnable);
    getAndSetCovidMedicTaken(isDeletedEnable);
    getAndSetMedicTimesId();
    getAndSetCovidMedicTimesId();
    getAndSetMedicTimes(isDeletedEnable);
    getAndSetCovidMedicTimes(isDeletedEnable);
    // StorageManager.deleteData("medicTaken");
    // StorageManager.deleteData("covidMedicTaken");
    // StorageManager.deleteData("medicinesNames");
    // StorageManager.deleteData("covidMedicinesNames");
    // StorageManager.deleteData("medicTimesId");
    // StorageManager.deleteData("covidMedicTimesId");
    // StorageManager.deleteData("medicTimes");
    // StorageManager.deleteData("covidMedicTimesAdded");
  }

  getAndSetMedicinesNames(isDeletedEnable) async {
    // save medicines names in shared preferences
    if(medicName.length!=0 || isDeletedEnable) {
      await StorageManager.save("medicinesNames", Medicines.medicName) ;
    }
    if(await StorageManager.readData("medicinesNames")!=null)
      Medicines.medicName = await StorageManager.readData("medicinesNames");
    if(covidMedicName.length!=0 || isDeletedEnable) {
      await StorageManager.save("covidMedicinesNames", Medicines.covidMedicName);
    }
    if(await StorageManager.readData("covidMedicinesNames")!=null)
      Medicines.covidMedicName = await StorageManager.readData("covidMedicinesNames");
    setState(() {
    });
    print(Medicines.medicName);
  }

  getAndSetMedicTaken(isDeletedEnable) async {
    // create list of string if true store 1 and if false store 0
    List<String> members = [];
    for (int i = 0; i < medicTaken.length; i++) {
      String row = "";
      for (int j = 0; j < medicTaken[i].length; j++) {
        if (medicTaken[i][j] == true)
          row += "1";
        else
          row += "0";
      }
        members.add(row);
    }
    if ((medicTaken.length != 0 && members.isNotEmpty) || isDeletedEnable) {
      await StorageManager.save("medicTaken", members);
    }
    // change the members list that store as 1's and 0's and change it to boolean list
    var listTaken = [];
    if (await StorageManager.readData("medicTaken") != null) {
      listTaken = [];
      var members = await StorageManager.readData("medicTaken");
      for (int i = 0; i < members.length; i++) {
        List<bool> row = [];
        for (int j = 0; j < members[i].length; j++) {
          if (members[i].substring(j, j + 1) == "0")
            row.add(false);
          else
            row.add(true);
        }
        listTaken.add(row);
      }
    setState(() {
      Medicines.medicTaken = listTaken;
    });
      print(medicTaken);
    }
  }
  getAndSetCovidMedicTaken(isDeletedEnable) async{
    // for covid
    List<String> members2=[];
    for(int i=0;i<covidMedicTaken.length;i++){
      String row="";
      for(int j=0;j<covidMedicTaken[i].length;j++){
        if(covidMedicTaken[i][j]==true)
          row+="1";
        else
          row+="0";
      }
      members2.add(row);
    }
    if(covidMedicTaken.length!=0 || isDeletedEnable) {
      await StorageManager.save("covidMedicTaken", members2);
    }
    // change the members list that store as 1's and 0's and change it to boolean list
    var listTaken2=[];
    if(await StorageManager.readData("covidMedicTaken")!=null){
      listTaken2=[];
      var members2 = await StorageManager.readData("covidMedicTaken");
      for(int i=0;i<members2.length;i++){
        List<bool> row=[];
        for(int j=0;j<members2[i].length;j++){
          if(members2[i].substring(j,j+1)=="0")
            row.add(false);
          else
            row.add(true);
        }
        listTaken2.add(row);
      }

    setState(() {
        Medicines.covidMedicTaken=listTaken2;
    });
    }
  }

  getAndSetMedicTimesId() async {
    // save medicines id's in shared preferences and update it when changed
    List<String> content=[];
    for(int i=0;i<medicTimesId.length;i++){
      String row="";
      for(int j=0;j<3;j++){
          row+=medicTimesId[i][j].toString();
      }
      content.add(row);
    }
    // if we delete some data from list so i need to know the index
    // no benefit from this but the code work with it correctly ^_^
    if(medicTimesId.length != 10-Medicines.medicName.length) {
      await StorageManager.save("medicTimesId", content);
    }
    // change the content list that store as one string and change it to number list
    List<List<int>> listTaken2=[];
    if(await StorageManager.readData("medicTimesId")!=null){
      listTaken2=[];
      var members2 = await StorageManager.readData("medicTimesId");
      for(int i=0;i<members2.length;i++){
        List<int> row=[];
        for(int j=0;j<members2[i].length;j++){
          if(members2[i].length==3)
            row.add(int.parse(members2[i].substring(j,j+1)));
          else{
            row.add(int.parse(members2[i].substring(j,j+2)));
            j++;
          }
        }
        listTaken2.add(row);
      }
    setState(() {
        Medicines.medicTimesId=listTaken2;
    });
      print(medicTimesId);
    }
  }
  getAndSetCovidMedicTimesId() async {
    // for covid
    List<String> content=[];
    for(int i=0;i<covidMedicTimesId.length;i++){
      String row="";
      for(int j=0;j<3;j++){
          row+=covidMedicTimesId[i][j].toString();
      }
      content.add(row);
    }

    if(covidMedicTimesId.length != 10-Medicines.covidMedicName.length) {
      await StorageManager.save("covidMedicTimesId", content);
    }
    // change the members list that store as 1's and 0's and change it to boolean list
    List<List<int>> listTaken2=[];
    if(await StorageManager.readData("covidMedicTimesId")!=null){
      listTaken2=[];
      var members2 = await StorageManager.readData("covidMedicTimesId");
      for(int i=0;i<members2.length;i++){
        List<int> row=[];
        for(int j=0;j<members2[i].length;j++){
          if(members2[i].length==3)
            row.add(int.parse(members2[i].substring(j,j+1)));
          else{
            row.add(int.parse(members2[i].substring(j,j+2)));
            j++;
          }
        }
        listTaken2.add(row);
      }

    setState(() {
      Medicines.covidMedicTimesId=listTaken2;
    });
    }
  }

  getAndSetMedicTimes(isDeletedEnable)async{
    // medicTimes store as this format
    // [ "7:20|5:15|13:05|", "9:45|", "8:20|5:15|" ]
    List<String> content=[];
    for(int i=0;i<Medicines.medicTimesAdded.length;i++){
      String row="";
      for(int j=0;j<Medicines.medicTimesAdded[i].length;j++){
        String hour = Medicines.medicTimesAdded[i][j].hour.toString();
        String minutes = Medicines.medicTimesAdded[i][j].minute.toString();
        row+=hour+":"+minutes;
        row+="|";
      }
      content.add(row);
    }
    // [ "7:20|5:15|13:05|", "9:45|", "8:20|5:15|" ]

    if(Medicines.medicTimesAdded.length != 0 || isDeletedEnable) {
      await StorageManager.save("medicTimes", content);
    }

    List listTaken=[];
    if(await StorageManager.readData("medicTimes")!=null){
      listTaken=[];
      var content2 = await StorageManager.readData("medicTimes");
      for(int i=0;i<content2.length;i++){
        String allMedicTimes = content2[i];
        var splitTime = allMedicTimes.split("|");
        List<TimeOfDay> times=[];
        // -1 to delete the last one because it it is empty
        for(int j=0;j<splitTime.length-1;j++){
          TimeOfDay _time = TimeOfDay(hour:int.parse(splitTime[j].split(":")[0]),minute: int.parse(splitTime[j].split(":")[1]));
          times.add(_time);
        }
        listTaken.add(times);
      }
      setState(() {
        Medicines.medicTimesAdded=listTaken;
      });
    }
  }
  getAndSetCovidMedicTimes(isDeletedEnable)async{
    // for covid
    List<String> content=[];
    for(int i=0;i<Medicines.covidMedicTimesAdded.length;i++){
      String row="";
      for(int j=0;j<Medicines.covidMedicTimesAdded[i].length;j++){
        String hour = Medicines.covidMedicTimesAdded[i][j].hour.toString();
        String minutes = Medicines.covidMedicTimesAdded[i][j].minute.toString();
        row+=hour+":"+minutes;
        row+="|";
      }
      content.add(row);
    }
    // [ "7:20|5:15|13:05", "9:45", "8:20|5:15" ]

    if(Medicines.covidMedicTimesAdded.length != 0 || isDeletedEnable) {
      await StorageManager.save("covidMedicTimesAdded", content);
    }

    List listTaken=[];
    if(await StorageManager.readData("covidMedicTimesAdded")!=null){
      listTaken=[];
      var content2 = await StorageManager.readData("covidMedicTimesAdded");
      for(int i=0;i<content2.length;i++){
        String allMedicTimes = content2[i];
        var splitTime = allMedicTimes.split("|");
        List<TimeOfDay> times=[];
        for(int j=0;j<splitTime.length-1;j++){
          TimeOfDay _time = TimeOfDay(hour:int.parse(splitTime[j].split(":")[0]),minute: int.parse(splitTime[j].split(":")[1]));
          times.add(_time);
        }
        listTaken.add(times);
      }
      setState(() {
        Medicines.covidMedicTimesAdded=listTaken;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: LocaleText("Medicines",style: TextStyle(fontSize: 24),),
          centerTitle: true,
          bottom: TabBar(
            tabs: <Widget>[
              Tab(icon:Icon(Icons.medication,) , text:Locales.string(context, 'Chronic Disease')),
              Tab(icon:Icon(Icons.coronavirus,) ,text:Locales.string(context, "Covid-19 Medicines" ),),
            ],
          ),
        ),
        body:TabBarView(
          children: [
            Scaffold(
              body: SingleChildScrollView(
                child: Padding(
                    padding: EdgeInsets.all(15),
                    child: getChronicMedic(),
                ),
              ),
            ),
            Scaffold(
              body: SingleChildScrollView(
                child: Padding(
                    padding: EdgeInsets.all(15),
                    child: getCovidMedic(),
                  // child: getData(),
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).splashColor,
          tooltip: 'Add Medicine',
          onPressed: (){
            // if the user reach the maximum number of adding medicines
            if(medicName.length==10 || covidMedicName.length==10)
              AwesomeDialog(
                context: context,
                dialogType: DialogType.INFO,
                headerAnimationLoop: false,
                title:  'Alarm',
                desc:  'You are reach the maximum number of adding medicines',
                buttonsTextStyle: TextStyle(color: Colors.black),
                showCloseIcon: true,
              )..show();
            else
            // go to add medic screen and replace it
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => AddMedicines()),);
          },
          child: Icon(Icons.alarm_add_rounded,size: 30,),
        ),
      ),
    );
  }

  Widget getChronicMedic() {
    // if there medicines show the first container
    // else if there is no any medicines is added show it
    var result =(listMedic.length!=0)?
    Column(
      children: [
         // loops for all the medicines and show them as children in the column
        for(int i =0 ;i<listMedic.length;i++)
          Container(
          decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 4,
                  blurRadius: 5,
                  offset: Offset(0, 2), // changes position of shadow
                ),
              ],
            ),
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.symmetric(vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ClipOval(child: CircleAvatar(minRadius: 30 ,child: Image.asset("assets/medic1.jpg",width: 60,))),
                  Text(medicName[i], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                  PopupMenuButton(
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          child: LocaleText("Edit"),
                          value: 1,
                        ),
                        PopupMenuItem(
                          child: LocaleText("Delete"),
                          value: 2,
                        )
                      ],
                    onSelected: (item) => selectedItem(context, item,i,"chronic"),
                  )
                ],
              ),
              SizedBox(height: 10,),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 2),
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: medicTaken[i][0]?Colors.lightBlueAccent:Color.fromRGBO(
                            234, 234, 234, 0.6),
                      ),
                      child: TextButton(
                        style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: Size(20, 20),
                            alignment: Alignment.center),
                        onPressed: (){
                          setState(() {
                            medicTaken[i][0]=!medicTaken[i][0];
                            getAndSetMedicTaken(false);
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Checkbox(value: medicTaken[i][0], onChanged: (bool? value) { setState(() {
                              medicTaken[i][0]=value!;
                              print(medicTaken);
                            });  },
                            ),
                            Text("${listMedic[i][0].format(context)}", style: TextStyle(
                                 fontSize: 14,color: Colors.black),),
                            SizedBox(width: 10,)
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 5,),
                    listMedic[i].length>=2?Container(
                      padding: EdgeInsets.symmetric(horizontal: 2),
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: medicTaken[i][1]?Colors.greenAccent:Color.fromRGBO(234, 234, 234, 0.6),
                      ),
                      child: TextButton(
                        style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: Size(20, 20),
                            alignment: Alignment.center),
                        onPressed: (){
                          setState(() {
                            medicTaken[i][1]=!medicTaken[i][1];
                            getAndSetMedicTaken(false);
                          });
                        },
                        child: Row(
                          children: [
                            Checkbox(value: medicTaken[i][1], onChanged: (bool? value) {  setState(() {
                              medicTaken[i][1]=value!;
                              print(medicTaken[i][1]);
                            }); }, ),
                            Text("${listMedic[i][1].format(context)}", style: TextStyle(
                                 fontSize: 14,color: Colors.black),),
                            SizedBox(width: 10,)
                          ],
                        ),
                      ),
                    ):Container(),
                    SizedBox(width: 6,),
                    listMedic[i].length>2?Container(
                      height: 50,
                      padding: EdgeInsets.symmetric(horizontal: 2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: medicTaken[i][2]?Colors.lightBlueAccent:Color.fromRGBO(234, 234, 234, 0.6),
                      ),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                            minimumSize: Size(10, 10),
                            alignment: Alignment.bottomRight),
                        onPressed: (){
                          setState(() {
                            medicTaken[i][2]=!medicTaken[i][2];
                            getAndSetMedicTaken(false);
                          });
                        },
                        child: Row(
                          children: [
                            Checkbox(value: medicTaken[i][2], onChanged: (bool? value) { setState(() {
                              medicTaken[i][2]=value!;
                              print(Medicines.medicTaken[i][2]);
                            }); }, ),
                            Text("${listMedic[i][2].format(context)}", style: TextStyle(
                                 fontSize: 14,color: Colors.black),),
                            SizedBox(width: 10,)
                          ],
                        ),
                      ),
                    ):Container(),
                  ],
                ),
              ),
              SizedBox(height: 5,),
            ],
          ),
        ),
      ],
    ):
    Center(
        child: Container(
          width: 350,
          decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20)
          ),
          padding: EdgeInsets.all(20),
          child: LocaleText("NoMedic_content",
            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.grey),),
        ));
    return result;
  }

  Widget getCovidMedic() {
    // for covid same as the previous one
    var result =covidMedic.length!=0?
    Column(
      children: [
        for(int i =0 ;i<covidMedic.length;i++)
          Container(
          decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 4,
                  blurRadius: 5,
                  offset: Offset(0, 2), // changes position of shadow
                ),
              ],
            ),
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.symmetric(vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ClipOval(child: CircleAvatar(minRadius: 30 ,child: Image.asset("assets/medic1.jpg",width: 60,))),
                  Text(covidMedicName[i], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                  PopupMenuButton(
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          child: LocaleText("Edit"),
                          value: 1,
                        ),
                        PopupMenuItem(
                          child: LocaleText("Delete"),
                          value: 2,
                        )
                      ],
                    onSelected: (item) => selectedItem(context, item,i,"covid"),
                  )
                ],
              ),
              SizedBox(height: 10,),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 2),
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: covidMedicTaken[i][0]?Colors.lightBlueAccent:Color.fromRGBO(
                            234, 234, 234, 0.6),
                      ),
                      child: TextButton(
                        style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: Size(20, 20),
                            alignment: Alignment.center),
                        onPressed: (){
                          setState(() {
                            covidMedicTaken[i][0]=!covidMedicTaken[i][0];
                            getAndSetCovidMedicTaken(false);
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Checkbox(value: covidMedicTaken[i][0], onChanged: (bool? value) { setState(() {
                              covidMedicTaken[i][0]=value!;

                            });  },
                            ),
                            Text("${covidMedic[i][0].format(context)}", style: TextStyle(
                                 fontSize: 14,color: Colors.black),),
                            SizedBox(width: 10,)
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 5,),
                    covidMedic[i].length>=2?Container(
                      padding: EdgeInsets.symmetric(horizontal: 2),
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: covidMedicTaken[i][1]?Colors.greenAccent:Color.fromRGBO(234, 234, 234, 0.6),
                      ),
                      child: TextButton(
                        style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: Size(20, 20),
                            alignment: Alignment.center),
                        onPressed: (){
                          setState(() {
                            covidMedicTaken[i][1]=!covidMedicTaken[i][1];
                            getAndSetCovidMedicTaken(false);
                          });
                        },
                        child: Row(
                          children: [
                            Checkbox(value: covidMedicTaken[i][1], onChanged: (bool? value) {  setState(() {
                              covidMedicTaken[i][1]=value!;
                            }); }, ),
                            Text("${covidMedic[i][1].format(context)}", style: TextStyle(
                                 fontSize: 14,color: Colors.black),),
                            SizedBox(width: 10,)
                          ],
                        ),
                      ),
                    ):Container(),
                    SizedBox(width: 6,),
                    covidMedic[i].length>2?Container(
                      height: 50,
                      padding: EdgeInsets.symmetric(horizontal: 2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: covidMedicTaken[i][2]?Colors.lightBlueAccent:Color.fromRGBO(234, 234, 234, 0.6),
                      ),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                            minimumSize: Size(10, 10),
                            alignment: Alignment.bottomRight),
                        onPressed: (){
                          setState(() {
                            covidMedicTaken[i][2]=!covidMedicTaken[i][2];
                            getAndSetCovidMedicTaken(false);
                          });
                        },
                        child: Row(
                          children: [
                            Checkbox(value: covidMedicTaken[i][2], onChanged: (bool? value) { setState(() {
                              covidMedicTaken[i][2]=value!;
                            }); }, ),
                            Text("${covidMedic[i][2].format(context)}", style: TextStyle(
                                 fontSize: 14,color: Colors.black),),
                            SizedBox(width: 10,)
                          ],
                        ),
                      ),
                    ):Container(),
                  ],
                ),
              ),
              SizedBox(height: 5,),
            ],
          ),
        ),
      ],
    ):
    Container(
      width: 350,
      decoration: BoxDecoration(
          color: Colors.blue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20)
      ),
      padding: EdgeInsets.all(20),
      child: LocaleText("NoMedic_content",
        style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.grey),),
    );
    return result;
  }

  // this function for delete and edit medicines
  Future<void> selectedItem(BuildContext context, item ,medicNum, String type) async {
    switch (item) {
      // Edit
      case 1:
        if(type == "chronic"){
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => MedicEdit(medicName[medicNum] ,listMedic[medicNum],medicNum,"chronic"))).then((value) {
            setState(() {
              // this set state to update the screen
              getFromSharedPreferences(false);
            });
          });
        }
        else{
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => MedicEdit(covidMedicName[medicNum] ,covidMedic[medicNum],medicNum,"covid"))).then((value) {
            setState(() {
              // this set state to update the screen
              getFromSharedPreferences(false);
            });
          });
        }

        break;
        // Delete
      case 2:
        if(type == "chronic"){
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: LocaleText('The Medic has been deleted'),duration: Duration(seconds: 2),));
            print("medic chronic at number $medicNum length ${listMedic[medicNum].length}");
            // cancel all the previous notifications fot this line
            for(int i=0;i< listMedic[medicNum].length;i++)
                await flutterLocalNotificationsPlugin.cancel(medicTimesId[medicNum][i]);
          setState(()  {
            medicName.removeAt(medicNum);
            medicTaken.removeAt(medicNum);
            listMedic.removeAt(medicNum);
            // move the list deleted to the end of the medic list taken
            int id = medicTimesId[medicNum][0];
            List<int> listToEnd = [id,id+1,id+2];
            medicTimesId.removeAt(medicNum);
            medicTimesId.add(listToEnd);
            getFromSharedPreferences(true);
          });
        }
        else{
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: LocaleText('The Medic has been deleted'),duration: Duration(seconds: 2),));
            print("medic covid at number $medicNum length ${covidMedic[medicNum].length}");
            for(int i=0;i< covidMedic[medicNum].length;i++)
                await flutterLocalNotificationsPlugin.cancel(covidMedicTimesId[medicNum][i]);
          setState(() {
            covidMedicName.removeAt(medicNum);
            covidMedicTaken.removeAt(medicNum);
            covidMedic.removeAt(medicNum);
            int id = covidMedicTimesId[medicNum][0];
            List<int> listToEnd = [id,id+1,id+2];
            covidMedicTimesId.removeAt(medicNum);
            medicTimesId.add(listToEnd);
            getFromSharedPreferences(true);
          });
        }
        break;
    }
  }

}
