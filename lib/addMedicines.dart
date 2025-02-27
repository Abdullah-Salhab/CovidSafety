import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'medicines.dart';
import 'myProvider.dart';
import 'package:provider/provider.dart';

import 'dart:async';

// for notification all screens use it medicines and edit medicines
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

class AddMedicines extends StatefulWidget {
  @override
  _AddMedicinesState createState() => _AddMedicinesState();
}

class _AddMedicinesState extends State<AddMedicines> {
  TextEditingController _controller = TextEditingController();
  var dropdownValue = "Chronic Disease";
  var dropdownValue2 = "1 Time at the day";

  // times
  TimeOfDay _time = TimeOfDay(hour: 7, minute: 30);
  TimeOfDay _time2 = TimeOfDay(hour: 14, minute: 30);
  TimeOfDay _time3 = TimeOfDay(hour: 21, minute: 30);
  // initialisation notification
  // late FlutterLocalNotificationsPlugin localNotification;

  // show time picker and set the values in times variables
  void _selectTime(int timeNum) async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: timeNum == 1
          ? _time
          : (timeNum == 2)
              ? _time2
              : _time3,
    );
    if (newTime != null) {
      setState(() {
        if (timeNum == 1) {
          _time = newTime;
        } else if (timeNum == 2) {
          _time2 = newTime;
        } else {
          _time3 = newTime;
        }
      });
    }
  }

  // create the daily notification by send the time and id
  Future dailyNotification(hour, minute, id) async {
    var time = Time(hour, minute, 0);
    // initialisation notification for android
    // var androidDetails = new AndroidNotificationDetails('channel ID notification ','channel name notification ',
    //     channelDescription: 'channel description notification ',playSound: true,
    //     sound: RawResourceAndroidNotificationSound(context.read<MyProvider>().sound == "Sound1"
    //         ? 'notification1'
    //         : (context.read<MyProvider>().sound == "Sound2")
    //         ? 'notification2'
    //         : 'notification3'),
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


    // this Temporarily for one time at day
    bool futureTime=false;
    if(DateTime.now().hour<hour)
      futureTime=true;
    else if(DateTime.now().hour==hour && DateTime.now().minute<=minute)
      futureTime=true;
    print(futureTime);
    DateTime date = DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day,hour,minute);
    if(futureTime)
      await flutterLocalNotificationsPlugin.schedule(
          id,
          "Medicines Reminder",
          "Take your Medicine that named: ${_controller.text}",
          date,
          // initialisation notification for android and ios depend on the sound
          new NotificationDetails(
              android: (context.read<MyProvider>().sound == "Sound1")
                  ? androidDetails1
                  : (context.read<MyProvider>().sound == "Sound2")
                      ? androidDetails2
                      : androidDetails3,
              iOS: iosDetails));

    // function to make the notification daily
    // await flutterLocalNotificationsPlugin.showDailyAtTime(
    //   id,
    //   'ID : $id ${time.hour}-$minute ',
    //   'Name :${_controller.text} Don\'t forget take it',
    //   time,
    //   new NotificationDetails(
    //       android: (context.read<MyProvider>().sound == "Sound1")
    //           ? androidDetails1
    //           : (context.read<MyProvider>().sound == "Sound2")
    //           ? androidDetails2
    //           : androidDetails3,
    //       iOS: iosDetails),
    // );
  }
  void selectNotification(String? payload) async {
    print(payload);
    if (payload != null) {
      debugPrint('notification payload: $payload');
    }
    await Navigator.push(
      context,
      MaterialPageRoute<void>(builder: (context) => Medicines()),
    );
  }

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
    flutterLocalNotificationsPlugin.initialize(initializationSettings,onSelectNotification: selectNotification);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: LocaleText(
          "Add Medicine",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 40),
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 5, vertical: 15),
                child: TextFormField(
                  controller: _controller,
                  autofocus: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    labelText: Locales.string(context,'Name of the Medicine' ),
                    hintText: Locales.string(context, 'Enter The Name of the Medicine here'),
                    prefixIcon: Icon(
                      Icons.add_comment_outlined,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                margin: EdgeInsets.symmetric(horizontal: 5, vertical: 15),
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    LocaleText(
                      "Medicine Type:",
                      style: TextStyle(fontSize: 18),
                    ),
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
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                margin: EdgeInsets.symmetric(horizontal: 5, vertical: 15),
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    LocaleText(
                      "Number of pills:",
                      style: TextStyle(fontSize: 18),
                    ),
                    DropdownButton<String>(
                      value: dropdownValue2,
                      iconSize: 24,
                      elevation: 16,
                      onChanged: (newValue) {
                        setState(() {
                          dropdownValue2 = newValue!;
                        });
                      },
                      items: <String>[
                        '1 Time at the day',
                        '2 Times at the day',
                        '3 Times at the day'
                      ].map<DropdownMenuItem<String>>((String value) {
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
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                margin: EdgeInsets.symmetric(horizontal: 5, vertical: 15),
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
                    SizedBox(
                      height: 20.0,
                    ),
                    ElevatedButton(
                      onPressed: () => _selectTime(1),
                      child: LocaleText('Select Time'),
                    ),
                  ],
                ),
              ),
              // show the container if the user select more than one time else show empty container
              (dropdownValue2 == "2 Times at the day" ||
                      dropdownValue2 == "3 Times at the day")
                  ? Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 15),
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
                          SizedBox(
                            height: 20.0,
                          ),
                          ElevatedButton(
                            onPressed: () => _selectTime(2),
                            child: LocaleText('Select Time'),
                          ),
                        ],
                      ),
                    )
                  : Container(),
              dropdownValue2 == "3 Times at the day"
                  ? Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 15),
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
                          // format show the time format
                          Text(
                            '${_time3.format(context)}',
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          ElevatedButton(
                            onPressed: () => _selectTime(3),
                            child: LocaleText('Select Time'),
                          ),
                        ],
                      ),
                    )
                  : Container(),
              ElevatedButton(
                onPressed: () {
                  if (_controller.text.trim() != "") {
                    // If the form is valid, display a Snack bar.
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: LocaleText('The Medic has been added'),
                      duration: Duration(seconds: 2),
                    ));

                    // if the user choose two times at day
                    bool time2IsTrue=(dropdownValue2 == "2 Times at the day" ||
                        dropdownValue2 == "3 Times at the day");
                    // if the user choose three times at day
                    bool time3IsTrue=(dropdownValue2 == "3 Times at the day");

                    // if the medicine is chronic disease add it
                    if(dropdownValue=="Chronic Disease"){
                      print("-----------------------------------************");
                      print("ADD medic chronic from add medic");
                      int index =Medicines.medicName.length;

                      // You can only add 30 notification and no problem in editing them but if
                      // you want to add more than 30 it will intersect with covid notification id
                      // so you have 10 medicines
                      // create the first notification
                      dailyNotification(_time.hour, _time.minute,Medicines.medicTimesId[index][0]);
                      // create the second notification
                      if (time2IsTrue)
                        dailyNotification(_time2.hour, _time2.minute,Medicines.medicTimesId[index][1]);
                      // create the third notification
                      if (time3IsTrue)
                        dailyNotification(_time3.hour, _time3.minute,Medicines.medicTimesId[index][2]);

                      // add to the times notification list
                      Medicines.medicTimesAdded.add([
                        _time,
                        if (time2IsTrue) _time2,
                        if (time3IsTrue) _time3,
                      ]);
                      // add to the taken notification list
                      Medicines.medicTaken.add([
                        false,
                        if (time2IsTrue) false,
                        if (time3IsTrue) false,
                      ]);
                      // add to the names notification list
                      Medicines.medicName.add(_controller.text);


                    }
                    else{
                      int index =Medicines.covidMedicName.length;
                      // the id for covid medicine start from 31
                      dailyNotification(_time.hour, _time.minute,Medicines.covidMedicTimesId[index][0]);
                      if (time2IsTrue)
                        dailyNotification(_time2.hour, _time2.minute,Medicines.covidMedicTimesId[index][1]);
                      if (time3IsTrue)
                        dailyNotification(_time3.hour, _time3.minute,Medicines.covidMedicTimesId[index][2]);

                      // add to the covid times notification list
                      Medicines.covidMedicTimesAdded.add([
                        _time,
                        if (time2IsTrue)  _time2,
                        if (time3IsTrue) _time3,
                      ]);
                      // add to the covid medic notification list
                      Medicines.covidMedicTaken.add([
                        false,
                        if (time2IsTrue)      false,
                        if (time3IsTrue) false,
                      ]);
                      // add to the covid names notification list
                      Medicines.covidMedicName.add(_controller.text);

                    }
                    setState(() {});
                    // pop the add medic screen and push to medicines screen
                    Navigator.of(context).popAndPushNamed("/medic");
                  } else {
                    // if the name is empty
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: LocaleText('You have to enter the name')));
                  }
                },
                child: LocaleText(
                  "ADD",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
