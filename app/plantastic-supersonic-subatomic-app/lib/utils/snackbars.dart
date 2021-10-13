import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class SnackBars {
  static Flushbar bottomFlushBar(String message){
    return Flushbar(
      message: message,
      margin: EdgeInsets.fromLTRB(0, 0, 0, 60),
      borderRadius: 8,
      duration: Duration(seconds: 3),
      flushbarStyle: FlushbarStyle.FLOATING,
      forwardAnimationCurve: Curves.decelerate,
      reverseAnimationCurve: Curves.easeOut,
    );
  }
}