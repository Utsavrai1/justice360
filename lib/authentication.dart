import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:justice360/login.dart';
import 'package:justice360/onboarding.dart';
import 'package:justice360/police/policedashboard.dart';
import 'package:justice360/women/womendashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Authenticate extends StatefulWidget {
  String? usertype;
  Authenticate({super.key, required this.usertype});
  @override
  State<Authenticate> createState() => _AuthenticateState(usertype);
}

class _AuthenticateState extends State<Authenticate> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  bool? firstvisit = true;

  checkfirstvisit() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.getBool('firsttime') != null) {
      setState(() {
        firstvisit = prefs.getBool('firsttime');
      });
    }
  }

  @override
  void initState() {
    checkfirstvisit();
    super.initState();
  }

  String? usertype;
  _AuthenticateState(this.usertype);

  @override
  Widget build(BuildContext context) {
    if (auth.currentUser != null) {
      if (usertype != null) {
        if (usertype == 'Women') {
          return WomenDashboard();
        } else if (usertype == "Police") {
          return PoliceDashboard();
        } else {
          return WomenDashboard();
        }
      } else {
        return WomenDashboard();
      }
    } else {
      if (firstvisit == true) {
        return OnboardingScreen();
      } else {
        return LoginPage();
      }
    }
  }
}
