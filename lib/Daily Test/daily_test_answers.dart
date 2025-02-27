import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

//this calss is the main class for the daily check-up ,where the user answer's will be analyzed
//each question will have set,get and setStatus methods
//set methods that insert the values from the user
//get methods to return the values or use these values in other functions such setStatus methods and in the setAnswers method that inser the values to the database (Cloud fire store)
//setStatus methods are used to analyze each answer for every question about a specific symptom
//setStatus will check whether that symptom will make the medicalHelpIsNeeded variable for that symptom true or false
class DailyTestAnswers extends ChangeNotifier {
  //first we declare all the variables , and each symptom have at least one variable related to it
  //and all theses variables have an initial values
  //these variables have values as numbers and strings
  double temperature = 37;
  String temperatureUnit = "Celsius";
  double sliderMin = 28;
  double sliderMax = 40;
  int sliderDivision = 120;
  double oxygenLevel = 96;
  String breathing = "";
  String cough = "";
  String fatigue = "";
  String bluish = "";
  String chestPain = "";
  String coughingBlood = "";
  String bodyPart = "";
  String collapse = "";
  String diarrhea = "";
  String peeing = "";
  String motionOrSpeak = "";
  String confusion = "";
  String wake = "";

  //all the symptoms that make the user needs medical help will be added to this list and will be showed for the user let know what symptoms he/she had that made his situation not safe
  List userSymptomsThatRequireMedicalHelp = [];

//these medicalHelpIsNeeded variables will be used to identify if the user needs medical help or not ,and will be used later to when showing the values for each previous test to color the values with green(safe) and red(not safe) depending on the value
  bool medicalHelpIsNeededHighFever = false;
  bool medicalHelpIsNeededHighFeverForThreeDays = false;
  bool medicalHelpIsNeededFoundSurprisingSpikeInTemperature = false;
  bool medicalHelpIsNeededOxygenLevel = false;
  bool medicalHelpIsNeededBreathing = false;
  bool medicalHelpIsNeededCough = false;
  bool medicalHelpIsNeededFatigue = false;
  bool medicalHelpIsNeededBluish = false;
  bool medicalHelpIsNeededChestPain = false;
  bool medicalHelpIsNeededCoughBlood = false;
  bool medicalHelpIsNeededBodyPart = false;
  bool medicalHelpIsNeededCollapse = false;
  bool medicalHelpIsNeededDiarrhea = false;
  bool medicalHelpIsNeededPeeing = false;
  bool medicalHelpIsNeededLossOfMotionOrSpeak = false;
  bool medicalHelpIsNeededConfusion = false;
  bool medicalHelpIsNeededWake = false;
  bool userNeedsMedicalHelp = false;

//this reference will be used to reach the database and enter each daily check-up test values and result for that specific user
  CollectionReference databaseReference = FirebaseFirestore.instance
      .collection("Users")
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .collection("Tests");

//this method will set the values to initial values every time before the user do the daily check-up test
  setInitialValues() {
    temperature = 37;
    temperatureUnit = "Celsius";
    sliderMin = 28;
    sliderMax = 40;
    sliderDivision = 120;
    oxygenLevel = 96;
    breathing = "";
    cough = "";
    fatigue = "";
    bluish = "";
    chestPain = "";
    coughingBlood = "";
    bodyPart = "";
    collapse = "";
    diarrhea = "";
    peeing = "";
    motionOrSpeak = "";
    confusion = "";
    wake = "";
    userSymptomsThatRequireMedicalHelp = [];
    medicalHelpIsNeededHighFever = false;
    medicalHelpIsNeededHighFeverForThreeDays = false;
    medicalHelpIsNeededFoundSurprisingSpikeInTemperature = false;
    medicalHelpIsNeededOxygenLevel = false;
    medicalHelpIsNeededBreathing = false;
    medicalHelpIsNeededCough = false;
    medicalHelpIsNeededFatigue = false;
    medicalHelpIsNeededBluish = false;
    medicalHelpIsNeededChestPain = false;
    medicalHelpIsNeededCoughBlood = false;
    medicalHelpIsNeededBodyPart = false;
    medicalHelpIsNeededCollapse = false;
    medicalHelpIsNeededDiarrhea = false;
    medicalHelpIsNeededPeeing = false;
    medicalHelpIsNeededLossOfMotionOrSpeak = false;
    medicalHelpIsNeededConfusion = false;
    medicalHelpIsNeededWake = false;
    userNeedsMedicalHelp = false;
    notifyListeners();
  }

  set setTemperature(double temperature) {
    this.temperature = temperature;
    notifyListeners();
  }

  get getTemperature {
    return temperature;
  }

//Celsius and Fahrenheit units are different from each other so this method will show the right range of temperature values on the slider so the user can choose his temperature based on his choice of temperatureUnit Celsius or Fahrenheit
  set setTemperatureUnit(String temperatureUnit) {
    this.temperatureUnit = temperatureUnit;
    if (this.temperatureUnit == "Celsius") {
      setTemperature = 37;
      sliderMin = 28;
      sliderMax = 40;
      sliderDivision = 120;
    } else if (this.temperatureUnit == "Fahrenheit") {
      setTemperature = 98.6;
      sliderMin = 82; //6 83 ////10  84 //200 104
      sliderMax = 104;
      sliderDivision = 220;
    }
    notifyListeners();
  }

  get getTemperatureUnit {
    return temperatureUnit;
  }

//this method will analyze the user's temperature
  //and check for HighFever, HighFeverForThreeDays, FoundSurprisingSpikeInTemperature and LowTemperature
  setTemperatureStatus() {
    if (getTemperatureUnit == "Celsius") {
      if (getTemperature > 38.5) {
        setMedicalHelpIsNeededHighFever = true;
        setMedicalHelpIsNeededHighFeverForThreeDays();
        setMedicalHelpIsNeededFoundSurprisingSpikeInTemperature();
      } else if (getTemperature >= 38.3) {
        setMedicalHelpIsNeededHighFever = false;
        setMedicalHelpIsNeededHighFeverForThreeDays();
        setMedicalHelpIsNeededFoundSurprisingSpikeInTemperature();
      }
    } else if (getTemperatureUnit == "Fahrenheit") {
      if (getTemperature > 101.3) {
        setMedicalHelpIsNeededHighFever = true;
        setMedicalHelpIsNeededHighFeverForThreeDays();
        setMedicalHelpIsNeededFoundSurprisingSpikeInTemperature();
      } else if (getTemperature >= 101) {
        setMedicalHelpIsNeededHighFever = false;
        setMedicalHelpIsNeededHighFeverForThreeDays();
        setMedicalHelpIsNeededFoundSurprisingSpikeInTemperature();
      }
    }
  }
  set setMedicalHelpIsNeededHighFever(bool medicalHelpIsNeededHighFever) {
    this.medicalHelpIsNeededHighFever = medicalHelpIsNeededHighFever;
    notifyListeners();
  }
  get getMedicalHelpIsNeededHighFever {
    return medicalHelpIsNeededHighFever;
  }




  //check if the user had a fever >=38.3 C ,101 F for three days
  setMedicalHelpIsNeededHighFeverForThreeDays() async {
    medicalHelpIsNeededHighFeverForThreeDays = false;
    int dayOneNumberOfTests = 0;
    int dayTwoNumberOfTests = 0;
    int dayThreeNumberOfTests = 0;

    int dayOneNumberOfTestsHavingHighFever = 0;
    int dayTwoNumberOfTestsHavingHighFever = 0;
    int dayThreeNumberOfTestsHavingHighFever = 0;

    String thirdDay = Jiffy(DateTime.now().subtract(const Duration(days: 1)))
        .format('MMM do yyyy');
    String secondDay = Jiffy(DateTime.now().subtract(const Duration(days: 2)))
        .format('MMM do yyyy');
    String firstDay = Jiffy(DateTime.now().subtract(const Duration(days: 3)))
        .format('MMM do yyyy');

    QuerySnapshot queryThree =
        await databaseReference.where("date", isEqualTo: thirdDay).get();
    List<QueryDocumentSnapshot> thirdDayListOfDocs = queryThree.docs;

    QuerySnapshot queryTwo =
        await databaseReference.where("date", isEqualTo: secondDay).get();
    List<QueryDocumentSnapshot> secondDayListOfDocs = queryTwo.docs;

    QuerySnapshot queryFirst =
        await databaseReference.where("date", isEqualTo: firstDay).get();
    List<QueryDocumentSnapshot> firstDayListOfDocs = queryFirst.docs;

    for (var element in thirdDayListOfDocs) {
      dayThreeNumberOfTests++;
      print(" ${element['temperature']}      ${element['date']}");
      if (element['temperature unit'] == "Celsius") {
        if (element['temperature'] >= 38.3) {
          dayThreeNumberOfTestsHavingHighFever++;
        }
      } else if (element['temperature unit'] == "Fahrenheit") {
        if (element['temperature'] >= 101) {
          dayThreeNumberOfTestsHavingHighFever++;
        }
      }
    }

    for (var element in secondDayListOfDocs) {
      dayTwoNumberOfTests++;
      print(" ${element['temperature']}      ${element['date']}");
      if (element['temperature unit'] == "Celsius") {
        if (element['temperature'] >= 38.3) {
          dayTwoNumberOfTestsHavingHighFever++;
        }
      } else if (element['temperature unit'] == "Fahrenheit") {
        if (element['temperature'] >= 101) {
          dayTwoNumberOfTestsHavingHighFever++;
        }
      }
    }

    for (var element in firstDayListOfDocs) {
      dayOneNumberOfTests++;
      print(" ${element['temperature']}      ${element['date']}");

      if (element['temperature unit'] == "Celsius") {
        if (element['temperature'] >= 38.3) {
          dayOneNumberOfTestsHavingHighFever++;
        }
      } else if (element['temperature unit'] == "Fahrenheit") {
        if (element['temperature'] >= 101) {
          dayOneNumberOfTestsHavingHighFever++;
        }
      }
    }
    print("dayOneNumberOfTests  $dayOneNumberOfTests");
    print(
        "dayOneNumberOfTestsHavingHighFever  $dayOneNumberOfTestsHavingHighFever");
    print("dayTwoNumberOfTests  $dayTwoNumberOfTests");
    print(
        "dayTwoNumberOfTestsHavingHighFever  $dayTwoNumberOfTestsHavingHighFever");
    print("dayThreeNumberOfTests $dayThreeNumberOfTests");
    print(
        "dayThreeNumberOfTestsHavingHighFever  $dayThreeNumberOfTestsHavingHighFever");

    if (dayOneNumberOfTestsHavingHighFever == dayOneNumberOfTests &&
        dayOneNumberOfTestsHavingHighFever != 0 &&
        dayOneNumberOfTests != 0 &&
        dayTwoNumberOfTestsHavingHighFever == dayTwoNumberOfTests &&
        dayTwoNumberOfTestsHavingHighFever != 0 &&
        dayTwoNumberOfTests != 0 &&
        dayThreeNumberOfTestsHavingHighFever == dayThreeNumberOfTests &&
        dayThreeNumberOfTestsHavingHighFever != 0 &&
        dayThreeNumberOfTests != 0) {
      medicalHelpIsNeededHighFeverForThreeDays = true;
    }

    print("3 days $medicalHelpIsNeededHighFeverForThreeDays");
    notifyListeners();
  }
  get getMedicalHelpIsNeededHighFeverForThreeDays {
    return medicalHelpIsNeededHighFeverForThreeDays;
  }

  //check if the user had a fever >=38.3 C ,101 F and then dropped down to natural limit then rose again today
  setMedicalHelpIsNeededFoundSurprisingSpikeInTemperature() async {
    medicalHelpIsNeededFoundSurprisingSpikeInTemperature = false;
    bool wasHighFeverBefore = false;

    QuerySnapshot query =
        await databaseReference.orderBy("datetime", descending: false).get();

    List<QueryDocumentSnapshot> listOfDocs = query.docs;

    for (var element in listOfDocs) {

      if (element['temperature unit'] == "Celsius") {
        if (element['temperature'] >= 38.3) {
          wasHighFeverBefore = true;
        } else if (element['temperature'] <= 37.8) {
          if (wasHighFeverBefore == true) {
            medicalHelpIsNeededFoundSurprisingSpikeInTemperature = true;
            break;
          }
        }
      } else if (element['temperature unit'] == "Fahrenheit") {
        if (element['temperature'] >= 101) {
          wasHighFeverBefore = true;
        } else if (element['temperature'] <= 100) {
          if (wasHighFeverBefore == true) {
            medicalHelpIsNeededFoundSurprisingSpikeInTemperature = true;
            break;
          }
        }
      }
    }
    print("Surprise $getMedicalHelpIsNeededFoundSurprisingSpikeInTemperature");
    notifyListeners();
  }
  get getMedicalHelpIsNeededFoundSurprisingSpikeInTemperature {
    return medicalHelpIsNeededFoundSurprisingSpikeInTemperature;
  }
//setTempStatus() add to the userSymptomsThatRequireMedicalHelp list the not safe symptoms related to the temperature
  setTempStatus() {
    if (getMedicalHelpIsNeededHighFever == true) {
      if (getTemperatureUnit == "Celsius") {
        userSymptomsThatRequireMedicalHelp.add("high fever above 38.5 C.");
      } else if (getTemperatureUnit == "Fahrenheit") {
        userSymptomsThatRequireMedicalHelp.add("high fever above 101.3 F.");
      }
    }

    if (getMedicalHelpIsNeededHighFeverForThreeDays == true) {
      userSymptomsThatRequireMedicalHelp
          .add("persists fever above 101 F/38.3 C for 3 days.");
    }

    if (getMedicalHelpIsNeededFoundSurprisingSpikeInTemperature == true) {
      userSymptomsThatRequireMedicalHelp.add(
          "you had a high fever before, then it went down, and then it rose again today.");
    }
  }


  set setOxygenLevel(double oxygenLevel) {
    this.oxygenLevel = oxygenLevel;
    notifyListeners();
  }
  get getOxygenLevel {
    return oxygenLevel;
  }
  set setMedicalHelpIsNeededOxygenLevel(bool medicalHelpIsNeededOxygenLevel) {
    this.medicalHelpIsNeededOxygenLevel = medicalHelpIsNeededOxygenLevel;
    notifyListeners();
  }
  get getMedicalHelpIsNeededOxygenLevel {
    return medicalHelpIsNeededOxygenLevel;
  }
//check for if user's oxygen level safe or not
  setOxygenStatus() {
    if (getOxygenLevel < 95) {
      setMedicalHelpIsNeededOxygenLevel = true;
      userSymptomsThatRequireMedicalHelp
          .add("low oxygen level (below 95%) on room air.");
    }
    notifyListeners();
  }


  set setBreathing(String breathing) {
    this.breathing = breathing;
    notifyListeners();
  }
  get getBreathing {
    return breathing;
  }
  set setMedicalHelpIsNeededBreathing(bool medicalHelpIsNeededBreathing) {
    this.medicalHelpIsNeededBreathing = medicalHelpIsNeededBreathing;
    notifyListeners();
  }
  get getMedicalHelpIsNeededBreathing {
    return medicalHelpIsNeededBreathing;
  }
// check for if user's breathing safe or not
  setBreathingStatus() {
    if (getMedicalHelpIsNeededBreathing == true) {
      userSymptomsThatRequireMedicalHelp.add("Breathing problems.");
    }
    notifyListeners();
  }

  set setCough(String cough) {
    this.cough = cough;
    notifyListeners();
  }
  get getCough {
    return cough;
  }
  set setMedicalHelpIsNeededCough(bool medicalHelpIsNeededCough) {
    this.medicalHelpIsNeededCough = medicalHelpIsNeededCough;
    notifyListeners();
  }
  get getMedicalHelpIsNeededCough {
    return medicalHelpIsNeededCough;
  }
  // check for if user's coughing safe or not
  setCoughStatus() {
    if (getMedicalHelpIsNeededCough == true) {
      userSymptomsThatRequireMedicalHelp
          .add("Severe and persistent cough that affects breathing.");
    }
    notifyListeners();
  }


  set setFatigue(String fatigue) {
    this.fatigue = fatigue;
    notifyListeners();
  }
  get getFatigue {
    return fatigue;
  }
  set setMedicalHelpIsNeededFatigue(bool medicalHelpIsNeededFatigue) {
    this.medicalHelpIsNeededFatigue = medicalHelpIsNeededFatigue;
    notifyListeners();
  }
  get getMedicalHelpIsNeededFatigue {
    return medicalHelpIsNeededFatigue;
  }
  // check for if user's fatigue safe or not
  setFatigueStatus() {
    if (getMedicalHelpIsNeededFatigue == true) {
      userSymptomsThatRequireMedicalHelp.add("Extreme tiredness and fatigue.");
    }
    notifyListeners();
  }

  set setBluish(String bluish) {
    this.bluish = bluish;
    notifyListeners();
  }
  get getBluish {
    return bluish;
  }
  set setMedicalHelpIsNeededBluish(bool medicalHelpIsNeededBluish) {
    this.medicalHelpIsNeededBluish = medicalHelpIsNeededBluish;
    notifyListeners();
  }
  get getMedicalHelpIsNeededBluish {
    return medicalHelpIsNeededBluish;
  }
  // check for if the user has Bluish face or lips
  setBluishStatus() {
    if (getMedicalHelpIsNeededBluish == true) {
      userSymptomsThatRequireMedicalHelp.add("Bluish face or lips.");
    }
    notifyListeners();
  }


  set setChestPain(chestPain) {
    this.chestPain = chestPain;
    notifyListeners();
  }
  get getChestPain {
    return chestPain;
  }
  set setMedicalHelpIsNeededChestPain(bool medicalHelpIsNeededChestPain) {
    this.medicalHelpIsNeededChestPain = medicalHelpIsNeededChestPain;
    notifyListeners();
  }
  get getMedicalHelpIsNeededChestPain {
    return medicalHelpIsNeededChestPain;
  }
  // check for if the user has chest pain
  setChestPainStatus() {
    if (getMedicalHelpIsNeededChestPain == true) {
      userSymptomsThatRequireMedicalHelp.add("Chest pain.");
    }
    notifyListeners();
  }


  set setCoughBlood(coughingBlood) {
    this.coughingBlood = coughingBlood;
    notifyListeners();
  }
  get getCoughBlood {
    return coughingBlood;
  }
  set setMedicalHelpIsNeededCoughBlood(bool medicalHelpIsNeededCoughBlood) {
    this.medicalHelpIsNeededCoughBlood = medicalHelpIsNeededCoughBlood;
    notifyListeners();
  }
  get getMedicalHelpIsNeededCoughBlood {
    return medicalHelpIsNeededCoughBlood;
  }
  // check if the user coughing Blood
  setCoughBloodStatus() {
    if (getMedicalHelpIsNeededCoughBlood == true) {
      userSymptomsThatRequireMedicalHelp.add("Coughing up blood.");
    }
    notifyListeners();
  }


  set setBodyPart(bodyPart) {
    this.bodyPart = bodyPart;
    notifyListeners();
  }
  get getBodyPart {
    return bodyPart;
  }
  set setMedicalHelpIsNeededBodyPart(bool medicalHelpIsNeededBodyPart) {
    this.medicalHelpIsNeededBodyPart = medicalHelpIsNeededBodyPart;
    notifyListeners();
  }
  get getMedicalHelpIsNeededBodyPart {
    return medicalHelpIsNeededBodyPart;
  }
  // check if the user has Lost feeling in any part of the body
  setBodyPartStatus() {
    if (getMedicalHelpIsNeededBodyPart == true) {
      userSymptomsThatRequireMedicalHelp
          .add("Loss of feeling in any part of the body.");
    }
    notifyListeners();
  }

  set setCollapse(String collapse) {
    this.collapse = collapse;
    notifyListeners();
  }
  get getCollapse {
    return collapse;
  }
  set setMedicalHelpIsNeededCollapse(bool medicalHelpIsNeededCollapse) {
    this.medicalHelpIsNeededCollapse = medicalHelpIsNeededCollapse;
    notifyListeners();
  }
  get getMedicalHelpIsNeededCollapse {
    return medicalHelpIsNeededCollapse;
  }
  // check if the user Collapse or faint.
  setCollapseStatus() {
    if (getMedicalHelpIsNeededCollapse == true) {
      userSymptomsThatRequireMedicalHelp.add("Collapse or faint.");
    }
    notifyListeners();
  }



  set setDiarrhea(String diarrhea) {
    this.diarrhea = diarrhea;
    notifyListeners();
  }
  get getDiarrhea {
    return diarrhea;
  }
  set setMedicalHelpIsNeededDiarrhea(bool medicalHelpIsNeededDiarrhea) {
    this.medicalHelpIsNeededDiarrhea = medicalHelpIsNeededDiarrhea;
    notifyListeners();
  }
  get getMedicalHelpIsNeededDiarrhea {
    return medicalHelpIsNeededDiarrhea;
  }
  // check if the user has non Stopping diarrhea-causing you dehydration, dizziness, tiredness
  setDiarrheaStatus() {
    if (getMedicalHelpIsNeededDiarrhea == true) {
      userSymptomsThatRequireMedicalHelp.add(
          "Non Stopping diarrhea-causing you dehydration, dizziness, tiredness.");
    }
    notifyListeners();
  }


  set setPeeing(String peeing) {
    this.peeing = peeing;
    notifyListeners();
  }
  get getPeeing {
    return peeing;
  }
  set setMedicalHelpIsNeededPeeing(bool medicalHelpIsNeededPeeing) {
    this.medicalHelpIsNeededPeeing = medicalHelpIsNeededPeeing;
    notifyListeners();
  }
  get getMedicalHelpIsNeededPeeing {
    return medicalHelpIsNeededPeeing;
  }
  // check if the user has non Stopping diarrhea-causing you dehydration, dizziness, tiredness
  setPeeingStatus() {
    if (getMedicalHelpIsNeededPeeing == true) {
      userSymptomsThatRequireMedicalHelp.add(getPeeing);
    }
    notifyListeners();
  }


  set setMotionOrSpeak(String motionOrSpeak) {
    this.motionOrSpeak = motionOrSpeak;
    notifyListeners();
  }
  get getMotionOrSpeak {
    return motionOrSpeak;
  }
  set setMedicalHelpIsNeededLossOfMotionOrSpeaking( bool medicalHelpIsNeededLossOfMotionOrSpeak) {
    this.medicalHelpIsNeededLossOfMotionOrSpeak =
        medicalHelpIsNeededLossOfMotionOrSpeak;
    notifyListeners();
  }
  get getMedicalHelpIsNeededLossOfMotionOrSpeak {
    return medicalHelpIsNeededLossOfMotionOrSpeak;
  }
  // check if the user has Lost ability to move or speak
  setMotionOrSpeakStatus() {
    if (getMedicalHelpIsNeededLossOfMotionOrSpeak == true) {
      userSymptomsThatRequireMedicalHelp
          .add("Lost your ability to move or speak.");
    }
    notifyListeners();
  }


  set setConfusion(String confusion) {
    this.confusion = confusion;
    notifyListeners();
  }
  get getConfusion {
    return confusion;
  }
  set setMedicalHelpIsNeededConfusion(bool medicalHelpIsNeededConfusion) {
    this.medicalHelpIsNeededConfusion = medicalHelpIsNeededConfusion;
    notifyListeners();
  }
  get getMedicalHelpIsNeededConfusion {
    return medicalHelpIsNeededConfusion;
  }
  // check if the user has reduced consciousness and awareness
  setConfusionStatus() {
    if (getMedicalHelpIsNeededConfusion == true) {
      userSymptomsThatRequireMedicalHelp
          .add("reduced consciousness and awareness.");
    }
    notifyListeners();
  }

  set setWake(String wake) {
    this.wake = wake;
    notifyListeners();
  }
  get getWake {
    return wake;
  }
  set setMedicalHelpIsNeededWake(bool medicalHelpIsNeededWake) {
    this.medicalHelpIsNeededWake = medicalHelpIsNeededWake;
    notifyListeners();
  }
  get getMedicalHelpIsNeededWake {
    return medicalHelpIsNeededWake;
  }
  // check if the user has problems waking up and not being able to stay awake without collapsing
  setWakeStatus() {
    if (getMedicalHelpIsNeededWake == true) {
      userSymptomsThatRequireMedicalHelp.add(
          "problems waking up and not being able to stay awake without collapsing.");
    }
    notifyListeners();
  }


  set setUserNeedsMedicalHelp(bool userNeedsMedicalHelp) {
    this.userNeedsMedicalHelp = userNeedsMedicalHelp;
    notifyListeners();
  }
  get getUserNeedsMedicalHelp {
    return userNeedsMedicalHelp;
  }
  //based on the user's answers to all the questions ,the analyzing each symptom in its own setStatus method, we will identify if the user need medical help if at least one medical help is needed has the value true

  setTheUserSituation() {
    setUserNeedsMedicalHelp = false;

    if (getMedicalHelpIsNeededHighFever == true ||
        getMedicalHelpIsNeededHighFeverForThreeDays == true ||
        getMedicalHelpIsNeededFoundSurprisingSpikeInTemperature == true ||
        getMedicalHelpIsNeededOxygenLevel == true ||
        getMedicalHelpIsNeededBreathing == true ||
        getMedicalHelpIsNeededCough == true ||
        getMedicalHelpIsNeededFatigue == true ||
        getMedicalHelpIsNeededBluish == true ||
        getMedicalHelpIsNeededChestPain == true ||
        getMedicalHelpIsNeededCoughBlood == true ||
        getMedicalHelpIsNeededBodyPart == true ||
        getMedicalHelpIsNeededCollapse == true ||
        getMedicalHelpIsNeededDiarrhea == true ||
        getMedicalHelpIsNeededPeeing == true ||
        getMedicalHelpIsNeededLossOfMotionOrSpeak == true ||
        getMedicalHelpIsNeededConfusion == true ||
        getMedicalHelpIsNeededWake == true) {
      setUserNeedsMedicalHelp = true;
    } else {
      setUserNeedsMedicalHelp = false;
    }

    notifyListeners();
  }

//return the list that contains the dangerous symptoms that user has
  getUserSymptomsThatRequireMedicalHelp() {
    return userSymptomsThatRequireMedicalHelp;
  }

//this method insert the answers of the answers of the daily check-up to the database using the databaseReference
  void setAnswers() async {
    databaseReference.add({
      "date": Jiffy(DateTime.now()).format('dd-MM-yyyy'),
      "time1": Jiffy(DateTime.now()).format('h:mm'),
      "time2": Jiffy(DateTime.now()).format('a'),
      "day": Jiffy(DateTime.now()).format('EEEE'),
      "datetime": DateTime.now(),
      "temperature": getTemperature,
      "temperature unit": getTemperatureUnit,
      "oxygen level": getOxygenLevel,
      "breathing": getBreathing,
      "fatigue": getFatigue,
      "coughing": getCough,
      "bluish face or lips": getBluish,
      "chest pain": getChestPain,
      "coughing up blood": getCoughBlood,
      "loss of feeling in a part of the body": getBodyPart,
      "collapse": getCollapse,
      "non stopping diarrhea causing you dehydration, dizziness, tiredness":
          getDiarrhea,
      "peeing": getPeeing,
      "lost your ability to move or speak": getMotionOrSpeak,
      "consciousness": getConfusion,
      "waking and staying awake": getWake,
      "medical help was needed on that day": getUserNeedsMedicalHelp,
      "medicalHelpIsNeededHighFever": getMedicalHelpIsNeededHighFever,
      "medicalHelpIsNeededHighFeverForThreeDays":
          getMedicalHelpIsNeededHighFeverForThreeDays,
      "medicalHelpIsNeededFoundSurprisingSpikeInTemperature":
          getMedicalHelpIsNeededFoundSurprisingSpikeInTemperature,
      "medicalHelpIsNeededOxygenLevel": getMedicalHelpIsNeededOxygenLevel,
      "medicalHelpIsNeededBreathing": getMedicalHelpIsNeededBreathing,
      "medicalHelpIsNeededCough": getMedicalHelpIsNeededCough,
      "medicalHelpIsNeededFatigue": getMedicalHelpIsNeededFatigue,
      "medicalHelpIsNeededBluish": getMedicalHelpIsNeededBluish,
      "medicalHelpIsNeededChestPain": getMedicalHelpIsNeededChestPain,
      "medicalHelpIsNeededCoughBlood": getMedicalHelpIsNeededCoughBlood,
      "medicalHelpIsNeededBodyPart": getMedicalHelpIsNeededBodyPart,
      "medicalHelpIsNeededCollapse": getMedicalHelpIsNeededCollapse,
      "medicalHelpIsNeededDiarrhea": getMedicalHelpIsNeededDiarrhea,
      "medicalHelpIsNeededPeeing": getMedicalHelpIsNeededPeeing,
      "medicalHelpIsNeededLossOfMotionOrSpeak":
          getMedicalHelpIsNeededLossOfMotionOrSpeak,
      "medicalHelpIsNeededConfusion": getMedicalHelpIsNeededConfusion,
      "medicalHelpIsNeededWake": getMedicalHelpIsNeededWake,
    });
  }
}
