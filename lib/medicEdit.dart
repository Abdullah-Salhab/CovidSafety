import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'addMedicines.dart';

import 'medicines.dart';
import 'package:provider/provider.dart';
import 'myProvider.dart';

class MedicEdit extends StatefulWidget {
  static var medicName;
  static var medicTimes;
  static var medicNum;
  static var medicType;

  // get the details of the medicine and store it
  MedicEdit(item, medicTimesNum,medicNumber, String type){
    medicName=item;
    medicTimes=medicTimesNum;
    medicNum=medicNumber;
    medicType=type;
  }

  @override
  _MedicEditState createState() => _MedicEditState();
}

class _MedicEditState extends State<MedicEdit> {

  // late FlutterLocalNotificationsPlugin localNotification;

  // store the details in these variables
  TextEditingController _controller = TextEditingController(text: medicName);
  var dropdownValue=medicType=="chronic"?"Chronic Disease":"Covid-19 Medicines";
  var dropdownValue2=medicTimes.length==1?"1 Time at the day":(medicTimes.length==2)?"2 Times at the day":"3 Times at the day";
  TimeOfDay _time = medicTimes[0];
  TimeOfDay _time2 = medicTimes.length>1?medicTimes[1]:TimeOfDay(hour: 14, minute: 30);
  TimeOfDay _time3 = medicTimes.length>2?medicTimes[2]:TimeOfDay(hour: 21, minute: 30);

  static get medicName => MedicEdit.medicName;
  static get medicTimes => MedicEdit.medicTimes;
  static get medicNum => MedicEdit.medicNum;
  static get medicType => MedicEdit.medicType;

  @override
  initState() {
    // TODO: implement initState
    super.initState();
    // initial the notification
    var androidInitialize = new AndroidInitializationSettings('ic_launcher');
    IOSInitializationSettings initializationSettingsIOS =
    IOSInitializationSettings();
    InitializationSettings initializationSettings = InitializationSettings(
      android: androidInitialize,
      iOS: initializationSettingsIOS,
    );
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? payload) async {
          if (payload != null) {
            debugPrint('notification payload: $payload');
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Medicines()),
            );
          }

        });
  }

  void _selectTime(int timeNum) async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: timeNum==1?_time:(timeNum==2)?_time2:_time3,
    );
    if (newTime != null) {
      setState(() {
        if(timeNum==1) {
          _time = newTime;
        }
        else if(timeNum==2) {
          _time2 = newTime;
        }
        else {
          _time3 = newTime;
        }
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: LocaleText("Medic Edit",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top:40),
          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 5,vertical: 15),
                child:TextFormField(
                  controller: _controller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    labelText: Locales.string(context,'Name of the Medicine' ),
                    hintText: Locales.string(context, 'Enter The Name of the Medicine here'),
                    prefixIcon: Icon(Icons.add_comment_outlined,color: Colors.blue,),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                margin: EdgeInsets.symmetric(horizontal: 5,vertical: 15),
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    LocaleText("Medicine Type:",style: TextStyle(fontSize: 18),),
                    DropdownButton<String>(
                      value: dropdownValue,
                      iconSize: 24,
                      elevation: 16,
                      onChanged: (newValue) {
                        setState(() {
                          dropdownValue = newValue!;
                        });
                      },
                      items: <String>['Chronic Disease', 'Covid-19 Medicines']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: LocaleText(value),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                margin: EdgeInsets.symmetric(horizontal: 5,vertical: 15),
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    LocaleText("Number of pills:",style: TextStyle(fontSize: 18),),
                    DropdownButton<String>(
                      value: dropdownValue2,
                      iconSize: 24,
                      elevation: 16,
                      onChanged: (newValue) {
                        setState(() {
                          dropdownValue2 = newValue!;
                        });
                      },
                      items: <String>['1 Time at the day', '2 Times at the day', '3 Times at the day']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: LocaleText(value),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                margin: EdgeInsets.symmetric(horizontal: 5,vertical: 15),
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    LocaleText(
                      'First Dose: ',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      '\t${_time.format(context)}',
                      style: TextStyle(fontSize: 18),
                    ),

                    SizedBox(height: 20.0,),
                    ElevatedButton(
                      onPressed: () => _selectTime(1),
                      child: LocaleText('Select Time'),
                    ),
                  ],
                ),
              ),
              (dropdownValue2=="2 Times at the day"||dropdownValue2=="3 Times at the day")?
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                margin: EdgeInsets.symmetric(horizontal: 5,vertical: 15),
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    LocaleText(
                      'Second Dose:',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      '${_time2.format(context)}',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 20.0,),
                    ElevatedButton(
                      onPressed: () => _selectTime(2),
                      child: LocaleText('Select Time'),
                    ),
                  ],
                ),
              ):Container(),
              dropdownValue2=="3 Times at the day"?Container(
                padding: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                margin: EdgeInsets.symmetric(horizontal: 5,vertical: 15),
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    LocaleText(
                      'Third Dose: ',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      '${_time3.format(context)}',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 20.0,),
                    ElevatedButton(
                      onPressed: () => _selectTime(3),
                      child: LocaleText('Select Time'),
                    ),
                  ],
                ),
              ):Container(),
              ElevatedButton(
                onPressed: () async {
                  if (_controller.text.trim()!="") {
                    // If the form is valid, display a Snack bar.
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: LocaleText('Medic has been Edited')));

                    // if the user choose two times at day
                    bool time2IsTrue = (dropdownValue2 ==
                        "2 Times at the day" ||
                        dropdownValue2 == "3 Times at the day");
                    // if the user choose three times at day
                    bool time3IsTrue = (dropdownValue2 ==
                        "3 Times at the day");

                    if(dropdownValue=="Chronic Disease") {
                      // delete the previous notification for this medicine then add it again
                      for (int i = 0; i <Medicines.medicTimesAdded[medicNum].length; i++)
                        await flutterLocalNotificationsPlugin.cancel(
                            Medicines.medicTimesId[medicNum][i]);

                      Medicines.medicTimesAdded[medicNum] =
                      [
                        _time,
                        if(time2IsTrue)_time2,
                        if(time3IsTrue)_time3,
                      ];
                      Medicines.medicTaken[medicNum] = [
                        false,
                        if(time2IsTrue)false,
                        if(time3IsTrue)false,
                      ];
                      Medicines.medicName[medicNum] = _controller.text;



                      // if the medicine is chronic disease add it
                      print("-----------------------------------************");
                      print("ADD medic chronic from edit");

                      // make new notification for medicine edited after deleted before with same id
                      dailyNotification(_time.hour, _time.minute, Medicines.medicTimesId[medicNum][0]);
                      if (time2IsTrue)
                        dailyNotification(_time2.hour, _time2.minute, Medicines.medicTimesId[medicNum][1]);
                      if (time3IsTrue)
                        dailyNotification(_time3.hour, _time3.minute, Medicines.medicTimesId[medicNum][2]);
                    }
                    else{
                      // delete the previous notification for this medicines then add it again
                      for(int i=0;i< Medicines.covidMedicTimesAdded[medicNum].length;i++)
                        await flutterLocalNotificationsPlugin.cancel(Medicines.covidMedicTimesId[medicNum][i]);

                      Medicines.covidMedicTimesAdded[medicNum] = [
                        _time,
                        if (time2IsTrue) _time2,
                        if (time3IsTrue) _time3,
                      ];
                      Medicines.covidMedicTaken[medicNum]=[false,if(time2IsTrue)false,if(time3IsTrue)false,];
                      Medicines.covidMedicName[medicNum]=_controller.text;

                      // if the medicine is chronic disease add it
                      print("-----------------------------------************");
                      print("ADD medic covid from edit");

                      // make new notification for medicine edited after deleted before with same id

                      dailyNotification(_time.hour, _time.minute, Medicines.covidMedicTimesId[medicNum][0]);
                      if (time2IsTrue)
                        dailyNotification(_time2.hour, _time2.minute, Medicines.covidMedicTimesId[medicNum][1]);
                      if (time3IsTrue)
                        dailyNotification(_time3.hour, _time3.minute, Medicines.covidMedicTimesId[medicNum][2]);
                    }
                    setState(() {
                    });
                    Navigator.of(context).pop("Edit done");
                  }
                  else {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: LocaleText('You have to enter the name')));
                  }
                },
                child: LocaleText("Confirm Edit",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future dailyNotification(hour, minute, id) async {
    print((context.read<MyProvider>().sound == "Sound2"));
    var time = Time(hour, minute, 0);
    // var androidDetails = new AndroidNotificationDetails("channelId",
    //     "local Notification",channelDescription: "Description of notification",
    //     sound: RawResourceAndroidNotificationSound(context.read<MyProvider>().sound == "Sound1"
    //         ? 'notification1'
    //         : (context.read<MyProvider>().sound == "Sound2")
    //         ? 'notification2': 'notification3'),
    //     importance: Importance.high,
    //     enableLights: true,
    //     color: const Color.fromARGB(255, 255, 0, 0),
    //     ledColor: const Color.fromARGB(255, 255, 0, 0),
    //     ledOnMs: 1000,
    //     ledOffMs: 500);
    // for each sound
    var androidDetails1 = new AndroidNotificationDetails('channel ID_notification 1','channel name_notification 1',
        channelDescription: 'channel description_notification 1',playSound: true,
        sound: RawResourceAndroidNotificationSound( 'notification1'),
        importance: Importance.high,
        enableLights: true,
        color: const Color.fromARGB(255, 255, 0, 0),
        ledColor: const Color.fromARGB(255, 255, 0, 0),
        ledOnMs: 1000,
        ledOffMs: 500);
    var androidDetails2 = new AndroidNotificationDetails(
        'channel ID notification_2','channel name notification_2',
        channelDescription: 'channel description notification_2',playSound: true,
        sound: RawResourceAndroidNotificationSound('notification2'),
        importance: Importance.high,
        enableLights: true,
        color: const Color.fromARGB(255, 255, 0, 0),
        ledColor: const Color.fromARGB(255, 255, 0, 0),
        ledOnMs: 1000,
        ledOffMs: 500);
    var androidDetails3 = new AndroidNotificationDetails(
        'channel ID notification_3','channel name notification_3',
        channelDescription: 'channel description notification_3',playSound: true,
        sound: RawResourceAndroidNotificationSound('notification3'),
        importance: Importance.high,
        enableLights: true,
        color: const Color.fromARGB(255, 255, 0, 0),
        ledColor: const Color.fromARGB(255, 255, 0, 0),
        ledOnMs: 1000,
        ledOffMs: 500);
    // initialisation notification for ios
    var iosDetails = new IOSNotificationDetails(sound: 'notification.mp3');
    // var generalNotificationDetails =
    // new NotificationDetails(android: androidDetails, iOS: iosDetails);
    print("id is : $id  and time is : $hour , $minute");

    // this Temporarily for one time at day
    bool futureTime=false;
    if(DateTime.now().hour<hour)
      futureTime=true;
    else if(DateTime.now().hour==hour && DateTime.now().minute<=minute)
      futureTime=true;
    print(futureTime);
    DateTime date = DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day,hour,minute);
    if(futureTime)
      await flutterLocalNotificationsPlugin.schedule(id , "Medicines Reminder", "Take your Medicine that named: ${_controller.text}",
          date, // initialisation notification for android and ios
          new NotificationDetails(
              android: (context.read<MyProvider>().sound == "Sound1")
                  ? androidDetails1
                  : (context.read<MyProvider>().sound == "Sound2")
                  ? androidDetails2
                  : androidDetails3,
              iOS: iosDetails));

    //await localNotification.showDailyAtTime(
    //  id,
    //  'Daily Notification id number $id ${time.hour}-${time.minute} ',
    //  'Daily body Medicine name :${_controller.text} Don\'t forget take it',
    //  time,
    //  generalNotificationDetails,
    //);
    // await localNotification.show(
    //     5, 'Test ', 'test notification ', generalNotificationDetails,
    //     payload: 'custom_sound');
  }

}
