import 'package:flutter_locales/flutter_locales.dart';
import 'package:provider/provider.dart';
import 'package:screen/screen.dart'; // for brightness
import 'package:flutter/material.dart';
import 'package:graduation/main.dart';

import 'myProvider.dart';


class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
var sliderVal=MyApp.brightness;
var dropdownValue="English" ;
var isNight=false;
var dropdownValue3="Sound1";
  @override
  Widget build(BuildContext context) {
    dropdownValue = context.read<MyProvider>().getLanguage;
    dropdownValue3= context.read<MyProvider>().getSound;
    isNight= context.read<MyProvider>().getIsNight;
    return Scaffold(
      appBar: AppBar(
        title: LocaleText("Settings",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24),),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40,horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            LocaleText("Brightness",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
            Slider(
              value: sliderVal,
              onChanged: (val) {
                setState(() {
                  sliderVal = val;
                  MyApp.brightness=val;
                  // Set the brightness:
                  Screen.setBrightness(sliderVal/100);
                });
              },
              label: "${Locales.string(context, 'Brightness')} ${sliderVal ~/ 10}",
              min: 0,
              max: 100,
              divisions: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(Icons.dark_mode),
                Icon(Icons.light_mode),
              ],
            ),
            SizedBox(height: 10,),
            Container(
              padding: EdgeInsets.symmetric(vertical: 5,horizontal: 3),
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  LocaleText("Language",style: TextStyle(fontSize: 18),),
                  DropdownButton<String>(
                    value: dropdownValue,
                    iconSize: 24,
                    elevation: 16,
                    onChanged: (newValue) {
                      if(newValue=="English")
                        LocaleNotifier.of(context)!.change('en');
                      else
                        LocaleNotifier.of(context)!.change('ar');
                      setState(() {
                        dropdownValue = newValue!;
                        context.read<MyProvider>().changeLanguage(newValue);
                        print(context.read<MyProvider>().getLanguage);
                      });
                    },
                    items: <String>['English', 'Arabic']
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
              padding: EdgeInsets.symmetric(vertical: 5,horizontal: 3),
              margin: EdgeInsets.symmetric(vertical: 10,horizontal: 40),
              child: SwitchListTile(
                  title: LocaleText("Dark Mode",style: TextStyle(fontSize: 18),),
                  value: isNight,
                  onChanged: (newValue) {
                    setState(() {
                      isNight = newValue;
                      context.read<MyProvider>().changeNight();
                    });

                  }),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 5,horizontal: 3),
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  LocaleText("Notification Sounds",style: TextStyle(fontSize: 18),),
                  DropdownButton<String>(
                    value: dropdownValue3,
                    iconSize: 24,
                    elevation: 16,
                    onChanged: (newValue) {
                      setState(() {
                        dropdownValue3 = newValue!;
                        context.read<MyProvider>().changeSound(newValue);
                        print(context.read<MyProvider>().getSound);
                      });
                    },
                    items: <String>['Sound1', 'Sound2', 'Sound3']
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
          ],
        ),
      ),
    );
  }
}
