import 'dart:async';

import 'package:alfa/api/database.dart';
import 'package:alfa/api/preference.dart';
import 'package:alfa/views/list.dart';
import 'package:alfa/views/login.dart';
import 'package:flutter/material.dart';

class Opening extends StatefulWidget {
  DataBase handler;
  Opening({this.handler});
  @override
  OpeningState createState() => OpeningState();
}

class OpeningState extends State<Opening> {
  Preferences preferences=Preferences();
  bool isLogin = false;
  bool startAnimation = false;

  @override
  void initState() {
    Timer(Duration(milliseconds: 500), () => changeView());
    super.initState();
  }

  changeView() {
    setState(() {
      startAnimation = true;
    });
    Timer(Duration(milliseconds: 5000), () async {
      preferences.logged
          ? Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => ListUser(handler: widget.handler, title: 'Lista',)))
          : Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => Login(handler:widget.handler)));
    });
  }
   @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
        image: ExactAssetImage("assets/flutter.jpg"),
        fit: BoxFit.contain)
      ),
    );
  }
}
