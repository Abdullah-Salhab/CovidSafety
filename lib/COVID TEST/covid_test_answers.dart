import 'package:flutter/material.dart';

class CovidTestAnswers extends ChangeNotifier {
  //these three symptoms boolean variables will have the value true based on the users answers

  //coronavirusMainSymptoms will become true if the user has at least 2 of the main symptoms
  bool coronavirusMainSymptoms = false;
  //coronavirusSecondarySymptoms will become true if the user has at least 1 of the Secondary symptoms
  bool coronavirusSecondarySymptoms = false;
  //coronavirusSevereSymptoms will become true if the user has at least 1 of the Severe symptoms
  bool coronavirusSevereSymptoms = false;
  //this string will have the result of the test
  String result = "";
  //the answers list is filled with user's answers (true and false values) to the covid test
  List<bool> answers = [];
  //the mainSymptoms list match the first three elements of the answers list which are the answers to the questions  about the common symptoms
  List<String> mainSymptoms = [
    "high fever.", //0
    "dry cough.", //1
    "tiredness and exhaustion.", //2
  ];
  //the secondarySymptoms list match the elements of index 3 to 13  elements of the answers list which are the answers to the questions  about the Secondary symptoms
  List<String> secondarySymptoms = [
    "loss of taste and smell.", //3
    "stuffy nose.", //4
    "conjunctivitis (red eyes).", //5
    "sore throat.", //6
    "headache.", //7
    "aches in muscles and joints.", //8
    "various types of rashes.", //9
    "nauseous and vomiting.", //10
    "diarrhea.", //11
    "shivering and dizziness.", //12
    "reduced consciousness." //13
  ];


  //the severeSymptoms list match the elements of index 14 to 18  elements of the answers list which are the answers to the questions  about the Severe symptoms
  List<String> severeSymptoms = [
    "shortness of breath.", //14
    "lack of appetite.", //15
    "confusion.", //16
    "constant pain or a feeling of pressure in the chest.", //17
    "high temperature (more than 38 degrees Celsius)." //18
  ];
//if 2  at least of the first three elements of the answers list they will be added to the mainSymptomsTheUserHas
// it's elements will be displayed to the user as the main symptoms he/she has
  List<String> mainSymptomsTheUserHas = [];

  //if 1  at least of the 3 to 13 indexes elements of the answers list they will be added to the secondarySymptomsTheUserHas
// it's elements will be displayed to the user as the secondary Symptoms he/she has
  List<String> secondarySymptomsTheUserHas = [];

  //if 1  at least of the 14 to 18 indexes elements of the answers list they will be added to the severeSymptomsTheUserHas
// it's elements will be displayed to the user as the severe Symptoms he/she has
  List<String> severeSymptomsTheUserHas = [];


  get getResult {
    return result;
  }
// this method will check for infection based n the user's answers that are filled in the answers list
  //the users must have at least two common covid-19 (two true values of the first three elements in the answers list) to say that he/she is infected
  checkForInfection() {
    coronavirusMainSymptoms = false;
    coronavirusSecondarySymptoms = false;
    coronavirusSevereSymptoms = false;
    mainSymptomsTheUserHas = [];
    secondarySymptomsTheUserHas = [];
    severeSymptomsTheUserHas = [];

    //first case : all common symptom(fever,dry cough,fatigue)s are true
    if (answers[0] == true && answers[1] == true && answers[2] == true) {
      coronavirusMainSymptoms = true;
      mainSymptomsTheUserHas.add(mainSymptoms[0]);
      mainSymptomsTheUserHas.add(mainSymptoms[1]);
      mainSymptomsTheUserHas.add(mainSymptoms[2]);
//if common symptoms(fever,dry cough,fatigue) true then check for secondary symptoms
      for(var index=3;index<=13;index++)
        {
          if (answers[index] == true) {
            coronavirusSecondarySymptoms = true;
            secondarySymptomsTheUserHas.add(secondarySymptoms[index-3]);
          }
        }
//if common symptoms(fever,dry cough,fatigue) true then check for severe symptoms
      for(var index=14;index<=18;index++)
      {
        if (answers[index] == true) {
          coronavirusSevereSymptoms = true;
          severeSymptomsTheUserHas.add(severeSymptoms[index-14]);
        }
      }

    }



    //second case :  (fever and dry cough) common symptoms are true
    else if (answers[0] == true && answers[1] == true) {
      coronavirusMainSymptoms = true;
      mainSymptomsTheUserHas.add(mainSymptoms[0]);
      mainSymptomsTheUserHas.add(mainSymptoms[1]);
//if common symptoms (fever and dry cough) true then check for secondary symptoms
      for(var index=3;index<=13;index++)
      {
        if (answers[index] == true) {
          coronavirusSecondarySymptoms = true;
          secondarySymptomsTheUserHas.add(secondarySymptoms[index-3]);
        }
      }
//if common symptoms (fever and dry cough) true then check for severe symptoms
      for(var index=14;index<=18;index++)
      {
        if (answers[index] == true) {
          coronavirusSevereSymptoms = true;
          severeSymptomsTheUserHas.add(severeSymptoms[index-14]);
        }
      }



    }
    //third case :  (dry cough and tiredness) common symptoms are true
    else if (answers[1] == true && answers[2] == true) {
      coronavirusMainSymptoms = true;
      mainSymptomsTheUserHas.add(mainSymptoms[1]);
      mainSymptomsTheUserHas.add(mainSymptoms[2]);
//if common symptoms  (dry cough and tiredness )  true then check for secondary symptoms
      for(var index=3;index<=13;index++)
      {
        if (answers[index] == true) {
          coronavirusSecondarySymptoms = true;
          secondarySymptomsTheUserHas.add(secondarySymptoms[index-3]);
        }
      }
//if common symptoms  (dry cough and tiredness )  true then check for severe symptoms
      for(var index=14;index<=18;index++)
      {
        if (answers[index] == true) {
          coronavirusSevereSymptoms = true;
          severeSymptomsTheUserHas.add(severeSymptoms[index-14]);
        }
      }



    }
    //fourth case :  (fever and tiredness) common symptoms are true
    else if (answers[0] == true && answers[2] == true) {
      coronavirusMainSymptoms = true;
      mainSymptomsTheUserHas.add(mainSymptoms[0]);
      mainSymptomsTheUserHas.add(mainSymptoms[2]);
//if common symptoms  (fever and tiredness)  true then check for secondary symptoms
      for(var index=3;index<=13;index++)
      {
        if (answers[index] == true) {
          coronavirusSecondarySymptoms = true;
          secondarySymptomsTheUserHas.add(secondarySymptoms[index-3]);
        }
      }
//if common symptoms  (fever and tiredness)  true then check for severe symptoms
      for(var index=14;index<=18;index++)
      {
        if (answers[index] == true) {
          coronavirusSevereSymptoms = true;
          severeSymptomsTheUserHas.add(severeSymptoms[index-14]);
        }
      }


    }

    setResult();
  }
//setResult()  method will use the coronavirusMainSymptoms,coronavirusSecondarySymptoms and coronavirusSevereSymptoms  variables to indicate if there is an infection or not ,and if there is predict the severity of the infection

  setResult() {
    result = "";

    if (coronavirusMainSymptoms == true &&
        coronavirusSecondarySymptoms == true &&
        coronavirusSevereSymptoms == true) {
      result =
          "common, secondary and severe Covid-19 symptoms";
    } else if (coronavirusMainSymptoms == true &&
        coronavirusSecondarySymptoms == true) {
      result =
          "common and secondary Covid-19 symptoms";
    } else if (coronavirusMainSymptoms == true &&
        coronavirusSevereSymptoms == true) {
      result =
          "common and severe Covid-19 symptoms";
    } else if (coronavirusMainSymptoms == true) {
      result =
          "common Covid-19 symptoms";
    } else if (coronavirusMainSymptoms == false) {
      result =
          "you do not have symptoms";
    }
  }
}
