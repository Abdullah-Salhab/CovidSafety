import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:graduation/storage_manager.dart';

class FeedbackScreen extends StatefulWidget {
  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  String dropdownValue = 'General Feedback';
  TextEditingController myController = TextEditingController();
  int charNum=0;

  var feedbackDoc = FirebaseFirestore.instance.collection("Feedback");

  var userName ;
  var userAddress ;

  @override
  void initState() {
    getUser();
    super.initState();
  }

  getUser() async{
    userName = await StorageManager.read("userName");
    userAddress = await StorageManager.read("userAddress");
    setState(() {
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: LocaleText("Feedback",style: GoogleFonts.playfairDisplay(textStyle:TextStyle(fontWeight: FontWeight.bold,fontSize: 24)) ,),
        centerTitle: true,
      ),
      body: DefaultTextStyle(
        style: GoogleFonts.abel(textStyle: TextStyle(color: Colors.black)),
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 70,horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(minRadius: 25, backgroundColor: Theme.of(context).splashColor,
                      child: Icon(
                        Icons.perm_identity,
                        color: Theme.of(context).bottomAppBarColor,),),
                    SizedBox(width: 10,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("$userName ",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).splashColor
                          ),
                        ),
                        Text("$userAddress ",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                              color: Theme.of(context).splashColor),
                        ),
                      ],
                    ),
                  ],
                ),

                Row(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LocaleText("Type",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22,color: Theme.of(context).splashColor),),
                    SizedBox(width: 20,),
                    DropdownButton<String>(
                      value: dropdownValue,
                      iconSize: 24,
                      elevation: 16,
                      underline: Container(
                        height: 2,
                        color: Colors.blueAccent,
                      ),
                      onChanged: (newValue) {
                        setState(() {
                          dropdownValue = newValue!;
                        });
                      },
                      items: <String>['General Feedback', 'Bug Report', 'Suggestion', 'Other']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: LocaleText(value),
                        );
                      }).toList(),
                    ),
                  ],
                ),
                SizedBox(height: 40,),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    labelText: Locales.string(context, 'You can Provide your feedback here'),
                    hintText: Locales.string(context, 'Enter Your Feedback'),
                  ),
                  controller: myController,
                  keyboardType: TextInputType.multiline,
                  minLines: 2,
                  maxLines: 7,
                  maxLength: 2040,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(height: 50,),
                    ElevatedButton(
                      onPressed: () async {
                      if (myController.text.trim()!=""){
                        print(myController.text+" "+dropdownValue);
                        await feedbackDoc.add({
                          'Type':dropdownValue,
                          'body':myController.text,
                        });
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.SUCCES,
                        headerAnimationLoop: false,
                        title: Locales.string(context, 'Result'),
                        desc: Locales.string(context, 'FeedSentResult'),
                        buttonsTextStyle: TextStyle(color: Colors.black),
                        showCloseIcon: true,
                      )..show();
                      myController.text="";
                      dropdownValue='General Feedback';
                      FocusScope.of(context).unfocus();
                      setState(() {
                      });
                      }
                      else{
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.ERROR,
                          headerAnimationLoop: false,
                          title: Locales.string(context, 'Result'),
                          desc: Locales.string(context, 'FeedNotResult'),
                          buttonsTextStyle: TextStyle(color: Colors.black),
                          showCloseIcon: true,
                        )..show();
                        myController.text="";
                        FocusScope.of(context).unfocus();
                      }
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                        child: LocaleText("Send",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
