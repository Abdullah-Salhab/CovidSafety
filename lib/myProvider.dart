import 'package:flutter/material.dart';

class MyProvider with ChangeNotifier {
  // dark theme
  final darkTheme = ThemeData(
    // general color
    primarySwatch: Colors.grey,
    // for text
    textTheme: TextTheme(
      bodyText1: TextStyle(),
      bodyText2: TextStyle(),
    ).apply(
      bodyColor: Colors.white,
    ),
    //for app bar and splash(long press in widget )
    primaryColor: Color.fromRGBO(97, 97, 97, 1.0),
    brightness: Brightness.dark,
    // distance in map
    backgroundColor: const Color(0xFF212121),
    // main card
    cardColor: Colors.grey[800],
    // for icons
    bottomAppBarColor: Colors.grey[700],
    // shadow
    shadowColor:Colors.white.withOpacity(0.1),
    // text
    splashColor: Colors.white,
    // limitation color
    accentColor: Colors.white,
    // accentIconTheme: IconThemeData(color: Colors.black),
    dividerColor: Colors.grey[800],
    // radio
    unselectedWidgetColor: Colors.black,
  );

  // light theme
  final lightTheme = ThemeData(
    primarySwatch: Colors.blue,
    secondaryHeaderColor: Color.fromRGBO(40, 112, 200, 1.0),
    cardColor: Colors.white,
    canvasColor: Color.fromRGBO(236, 241, 250, 1.0),
    primaryColor: Color.fromRGBO(40, 112, 200, 1.0),
    brightness: Brightness.light,
    backgroundColor: const Color(0xFFE5E5E5),
    // accentIconTheme: IconThemeData(color: Colors.white),
    accentColor: Colors.blueGrey,
    bottomAppBarColor:Colors.white,
    shadowColor:Colors.grey.withOpacity(0.5),
    // buttonColor: Colors.grey,
    splashColor: Color.fromRGBO(40, 112, 200, 1.0),
      unselectedWidgetColor:const Color(0xFF2870C8),
  );

  // default theme
  ThemeData themeMode = ThemeData(
    primarySwatch: Colors.blue,
    secondaryHeaderColor: Color.fromRGBO(40, 112, 200, 1.0),
    cardColor: Colors.white,
    canvasColor: Color.fromRGBO(236, 241, 250, 1.0),
    primaryColor: Color.fromRGBO(40, 112, 200, 1.0),
    brightness: Brightness.light,
    backgroundColor: const Color(0xFFE5E5E5),
    // accentIconTheme: IconThemeData(color: Colors.white),
    accentColor: Colors.blueGrey,
    bottomAppBarColor:Colors.white,
    shadowColor:Colors.grey.withOpacity(0.5),
    // buttonColor: Colors.grey,
    splashColor: Color.fromRGBO(40, 112, 200, 1.0),
    unselectedWidgetColor: const Color(0xFF2870C8),
  );

  bool isNight=false;
  String language = "English";
  String sound="Sound1";

  get getTheme=>themeMode;
  get getIsNight=>isNight;
  get getLanguage=>language;
  get getSound=>sound;

  void changeLanguage(String newLanguage) {
    language=newLanguage;
    notifyListeners();
  }
  void changeSound(String newSound) {
    sound=newSound;
    notifyListeners();
  }
  void changeNight() {
    isNight =! isNight;
    (isNight)?themeMode=darkTheme:themeMode=lightTheme;
    notifyListeners();
  }

}
