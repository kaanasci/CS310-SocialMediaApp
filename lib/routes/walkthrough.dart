import 'package:cs310_week5_app/routes/welcome.dart';
import 'package:flutter/material.dart';
import 'package:walkthrough/walkthrough.dart';
import 'package:walkthrough/flutterwalkthrough.dart';

class TestScreen extends StatelessWidget {


  final List<Walkthrough> list = [
    Walkthrough(
      title: "Welcome",
      content: "Welcome to Chakila Social Media App",
      imageIcon: Icons.celebration,

    ),
    Walkthrough(
      title: "Sign Up",
      content: "You can join and meet with others Chakilians!",
      imageIcon: Icons.assignment_sharp,
    ),
    Walkthrough(
      title: "Login",
      content: "You can login easily...",
      imageIcon: Icons.login,
    ),


  ];

  @override
  Widget build(BuildContext context) {
    //here we need to pass the list and route for the next page to be opened after this
    return IntroScreen(
      list,
      MaterialPageRoute(builder: (context) => Welcome()),
    );
  }
}