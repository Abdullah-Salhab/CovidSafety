import 'package:flutter/material.dart';

showLoading(context) {
  return showDialog(
    barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor:Colors.white,
          content: Container(
              height: 200,
              child: Center(
                child: CircularProgressIndicator(color:Color.fromRGBO(40, 112, 200, 1.0),strokeWidth: 6,),
              )),
        );
      });
}