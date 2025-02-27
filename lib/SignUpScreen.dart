//this is where the user signs up in the app by entering his information
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:graduation/Dashboard.dart';
import 'package:graduation/LoadingScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'check_connection.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool visiblePassword = true;
  bool visibleConfirmPassword = true;
  var _gender = "Male";
  var userName;
  var email;
  var passWord;
  var passWordConfirmed;
  var passWordConfirmedController = TextEditingController();
  var passwordController = TextEditingController();
  var phone;
  var address;
  var country;
  var createDate;

  var countries = [
    "amman",
    "madaba",
    "zarqa",
    "jerash",
    "ma'an",
    "irbid",
    "tafeleh",
    "ajloun",
    "mafra'a",
    "karak",
    "aqaba",
    "balqa'a",
  ];

  addUser() async {
    var formData = formS.currentState;
    if (formData!.validate() ) {
      if(await getConnection(context)){
        formData.save();
        try {
          showLoading(context);
          UserCredential userCredential = await FirebaseAuth.instance
              .createUserWithEmailAndPassword(email: email, password: passWord);
          return userCredential;
        } on FirebaseAuthException catch (e) {
          if (e.code == "weak-password") {
            Navigator.of(context).pop();
            AwesomeDialog(
              context: context,
              dialogType: DialogType.WARNING,
              animType: AnimType.BOTTOMSLIDE,
              title: Locales.string(context, 'Warning!'),
              desc: Locales.string(context, 'your password is too weak'),
              btnCancelOnPress: () {},
              btnOkOnPress: () {},
            )..show();
          }
          if (e.code == "email-already-in-use") {
            Navigator.of(context).pop();
            AwesomeDialog(
              context: context,
              dialogType: DialogType.WARNING,
              animType: AnimType.BOTTOMSLIDE,
              title: Locales.string(context, 'Warning!'),
              desc: Locales.string(context, 'the email entered is already in use'),
              btnCancelOnPress: () {},
              btnOkOnPress: () {},
            )..show();
          }
        }
    }
    } else {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.ERROR,
        animType: AnimType.BOTTOMSLIDE,
        title: Locales.string(context, 'Warning!'),
        desc: Locales.string(context, 'check all of your information again'),
        btnCancelOnPress: () {},
        btnOkOnPress: () {},
      )..show();
    }
  }

  GlobalKey<FormState> formS = new GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).secondaryHeaderColor,),
        backgroundColor: Theme.of(context).canvasColor,
        title: LocaleText(
          "Sign up",
          style:
              TextStyle(color: Theme.of(context).secondaryHeaderColor, fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                    BoxShadow(
                    color: Theme.of(context).shadowColor,
                    spreadRadius: 4,
                    blurRadius: 5,
                    offset: Offset(0, 2), // changes position of shadow
                     ),
                 ],
                color: Colors.white
              ),
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              padding: EdgeInsets.all(15),
              child: Form(
                key: formS,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      onSaved: (value) {
                        setState(() {
                          userName = value!;
                        });
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return Locales.string(
                              context, 'please,enter your username');
                        }
                        if (RegExp(r'^[a-zA-Z0-9_\s]+$').hasMatch(value) ==
                            false) {
                          return Locales.string(context,
                              'Username cant contains special characters other than (_)');
                        }
                        if (RegExp(r'^[\s]+$').hasMatch(value) == true) {
                          return Locales.string(
                              context, 'dont leave any field empty');
                        }
                        if (value.length <= 2) {
                          return Locales.string(context,
                              'the username cannot be less than 2 letters');
                        } else {
                          value = value.trim();
                        }
                      },
                      //text field for the user name
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person,
                            size: 20, color: Theme.of(context).secondaryHeaderColor),
                        hintText: Locales.string(context, "User name"),
                        hintStyle:
                            TextStyle(color: Theme.of(context).secondaryHeaderColor, fontSize: 14),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Theme.of(context).secondaryHeaderColor),
                        ),
                      ),
                      keyboardType: TextInputType.text,
                    ),
                    TextFormField(
                      //text field for the email
                      onSaved: (value) {
                        setState(() {
                          email = value;
                        });
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return Locales.string(
                              context, "please,enter your email");
                        }
                        if (RegExp(r'^[\s]+$').hasMatch(value) == true) {
                          return Locales.string(
                              context, 'dont leave any field empty');
                        }
                        if ((value.endsWith("@gmail.com")) == false) {
                          return Locales.string(
                              context, 'enter a valid email(gmail)');
                        }
                        if ((value.startsWith("@gmail.com")) == true) {
                          return Locales.string(
                              context, 'enter a valid email(gmail)');
                        } else {
                          value = value.trim();
                        }
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.mail_outline,
                            size: 20, color: Theme.of(context).secondaryHeaderColor),
                        hintText: Locales.string(context, "Email"),
                        hintStyle:
                            TextStyle(color: Theme.of(context).secondaryHeaderColor, fontSize: 14),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Theme.of(context).secondaryHeaderColor),
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    TextFormField(
                      //text field for the Password
                      controller: passwordController,
                      onSaved: (value) {
                        setState(() {
                          passWord = value!;
                        });
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return Locales.string(
                              context, "please enter your password");
                        }
                        if (RegExp(r'^[\s]+$').hasMatch(value) == true) {
                          return Locales.string(
                              context, "dont leave any field empty");
                        }
                        if (value.length <= 6) {
                          return Locales.string(context,
                              "the password shouldnt be less than 6 characters");
                        } else {
                          value = value.trim();
                        }
                      },
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock,
                              size: 20, color: Theme.of(context).secondaryHeaderColor),
                          suffixIcon: IconButton(
                            icon: Icon(
                              visiblePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              size: 20,
                              color: Theme.of(context).secondaryHeaderColor,
                            ),
                            onPressed: () {
                              setState(() {
                                visiblePassword = !visiblePassword;
                              });
                            },
                          ),
                          hintText: Locales.string(context, "Password"),
                          hintStyle: TextStyle(
                              color: Theme.of(context).secondaryHeaderColor, fontSize: 14),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Theme.of(context).secondaryHeaderColor),
                          )),
                      obscureText: visiblePassword,
                    ),
                    TextFormField(
                      //text field to confirm Password
                      controller: passWordConfirmedController,
                      onSaved: (value) {
                        setState(() {
                          passWordConfirmed = value!;
                        });
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return Locales.string(
                              context, "please enter your password");
                        }
                        if (RegExp(r'^[\s]+$').hasMatch(value) == true) {
                          return Locales.string(
                              context, "dont leave any field empty");
                        }
                        if (value.length <= 6) {
                          return Locales.string(context,
                              "the password shouldnt be less than 6 characters");
                        }
                        if (passwordController.text !=
                            passWordConfirmedController.text) {
                          return Locales.string(context,
                              "password is not the same as the above");
                        } else {
                          value = value.trim();
                        }
                      },
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock,
                              size: 20, color: Theme.of(context).secondaryHeaderColor),
                          suffixIcon: IconButton(
                            icon: Icon(
                              visibleConfirmPassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              size: 20,
                              color: Theme.of(context).secondaryHeaderColor,
                            ),
                            onPressed: () {
                              setState(() {
                                visibleConfirmPassword = !visibleConfirmPassword;
                              });
                            },
                          ),
                          hintText:
                              Locales.string(context, "Confirm Password"),
                          hintStyle: TextStyle(
                              color: Theme.of(context).secondaryHeaderColor, fontSize: 14),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Theme.of(context).secondaryHeaderColor),
                          )),
                      obscureText: visibleConfirmPassword,
                    ),
                    TextFormField(
                      //text field for the phone number
                      enableInteractiveSelection: false,
                      onSaved: (value) {
                        setState(() {
                          phone = value!;
                        });
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return Locales.string(
                              context, "please,enter your phone number");
                        }
                        if (value.contains(".") || value.contains("-")) {
                          return Locales.string(
                              context, 'please,enter numbers only');
                        }
                        if (RegExp(r'^[\s]+$').hasMatch(value) == true) {
                          return Locales.string(
                              context, 'dont leave any field empty');
                        }
                        if ((value.startsWith("079") ||
                                value.startsWith("078") ||
                                value.startsWith("077")) ==
                            false) {
                          return Locales.string(context,
                              "your number should start with 079 or 078 or 077");
                        }
                        if (value.length != 10) {
                          return Locales.string(context,
                              "your number must be exactly 10 digits");
                        } else {
                          value = value.trim();
                        }
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.phone,
                            size: 20, color: Theme.of(context).secondaryHeaderColor),
                        hintText: Locales.string(context, "Phone Number"),
                        hintStyle:
                            TextStyle(color: Theme.of(context).secondaryHeaderColor, fontSize: 14),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Theme.of(context).secondaryHeaderColor),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    TextFormField(
                      //text field for the address
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.location_on,
                            size: 20, color: Theme.of(context).secondaryHeaderColor),
                        hintText: Locales.string(context, "Address"),
                        hintStyle:
                            TextStyle(color: Theme.of(context).secondaryHeaderColor, fontSize: 14),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Theme.of(context).secondaryHeaderColor),
                        ),
                      ),
                      keyboardType: TextInputType.text,
                      onSaved: (value) {
                        address = value;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return Locales.string(
                              context, "please,enter your address");
                        }
                        if (RegExp(r'^[\s]+$').hasMatch(value) == true) {
                          return Locales.string(
                              context, 'dont leave any field empty');
                        } else {
                          value = value.trim();
                        }
                      },
                    ),
                    TextFormField(
                      //text field for the user name
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.location_city,
                            size: 20, color: Theme.of(context).secondaryHeaderColor),
                        hintText: Locales.string(context, "Country"),
                        hintStyle:
                            TextStyle(color: Theme.of(context).secondaryHeaderColor, fontSize: 14),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Theme.of(context).secondaryHeaderColor),
                        ),
                      ),
                      keyboardType: TextInputType.text,

                      onSaved: (value) {
                        country = value;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return Locales.string(
                              context, "please,enter your country");
                        }
                        if (RegExp(r'^[\s]+$').hasMatch(value) == true) {
                          return Locales.string(
                              context, 'dont leave any field empty');
                        }
                        if ((countries.contains(value.toLowerCase()) ||
                                value.toLowerCase() == "madaba" ||
                                value.toLowerCase() == "zarqa" ||
                                countries.contains(value.trim())) ==
                            false) {
                          return Locales.string(context,
                              "hint:amman,zarqa,mafra'a,madaba,balqa'a,tafeleh");
                        } else {
                          value = value.trim();
                        }
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    LocaleText(
                      "Gender",
                      style:
                          TextStyle(color: Theme.of(context).secondaryHeaderColor, fontSize: 21),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _gender = "Male";
                        });
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                  color: Theme.of(context).secondaryHeaderColor, width: 1),
                              color: Color.fromRGBO(236, 241, 250, 1.0),
                              boxShadow: [
                                BoxShadow(
                                    color: Theme.of(context).canvasColor,
                                    spreadRadius: 1),
                              ]),
                          child: SizedBox(
                              height: 30,
                              width: 250,
                              child: Row(
                                children: [
                                  Radio(
                                    value: "Male",
                                    groupValue: _gender,
                                    onChanged: (String? value) {
                                      setState(() {
                                        _gender = value!;
                                      });
                                    },
                                    activeColor: Theme.of(context).secondaryHeaderColor,
                                    toggleable: true,
                                  ),
                                  LocaleText("Male",
                                      style: TextStyle(
                                          color: Theme.of(context).secondaryHeaderColor)),
                                ],
                              ))),
                    ),
                    SizedBox(height: 9),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _gender = "Female";
                        });
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                  color: Theme.of(context).secondaryHeaderColor, width: 1),
                              color: Color.fromRGBO(236, 241, 250, 1.0),
                              boxShadow: [
                                BoxShadow(
                                    color: Theme.of(context).canvasColor,
                                    spreadRadius: 1),
                              ]),
                          child: SizedBox(
                              height: 30,
                              width: 250,
                              child: Row(
                                children: [
                                  Radio(
                                    value: "Female",
                                    groupValue: _gender,
                                    onChanged: (String? value) {
                                      setState(() {
                                        _gender = value!;
                                      });
                                    },
                                    activeColor: Theme.of(context).secondaryHeaderColor,
                                    toggleable: true,
                                  ),
                                  LocaleText(
                                    "Female",
                                    style:
                                        TextStyle(color: Theme.of(context).secondaryHeaderColor),
                                  ),
                                ],
                              ))),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            createDate = DateTime.now();
                          });
                          UserCredential response = await addUser();
                          if (response != null ) {
                            SharedPreferences sharedpreferences =
                                await SharedPreferences.getInstance();
                            sharedpreferences.setString("email", email);
                            DocumentReference userRef = FirebaseFirestore
                                .instance
                                .collection("Users")
                                .doc(FirebaseAuth.instance.currentUser?.uid);
                            await userRef.collection("Tests").add({});
                            await userRef.set({
                              "username": userName,
                              "email": email,
                              "password": passWord,
                              "phone": phone,
                              "address": address,
                              "gender": _gender,
                              "country": country,
                              "firstDate": createDate.toString(),
                            });
                            Navigator.pushReplacement(
                                context,
                                PageTransition(
                                  alignment: Alignment.bottomCenter,
                                  curve: Curves.easeInOut,
                                  duration: Duration(seconds: 1),
                                  type: PageTransitionType.scale,
                                  child: Dashboard(),
                                ));
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Theme.of(context).secondaryHeaderColor,
                          padding: EdgeInsets.fromLTRB(50, 10, 50, 10),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        child: LocaleText(
                          "Sign up",
                          style: TextStyle(fontSize: 17),
                        )),
                    SizedBox(height: 20,)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
