import 'package:flutter/material.dart';
import 'package:wastedtalent/screens/chat/chat.dart';
import 'package:wastedtalent/screens/profile/profile.dart';
import '../screens/home.dart';

Future<void> bottom_navigation(int index, BuildContext context) async {
  if (index == 0) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Home(
            )));
  }
  else if(index==1){
    Navigator.push(context, MaterialPageRoute(builder: (builder)=>Chat()));
  }
  else if (index == 2) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
  } else if (index == 3) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Profile()));
  }
}