// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:justice360/components/drawer.dart';
import 'package:shake/shake.dart';
import 'package:url_launcher/url_launcher.dart';

final List<String> items = [
  'Domestic Violence',
  'Forced Marriage',
  'Acid Attack',
  'Honor Killing',
  'more.......'
];

class WomenDashboard extends StatefulWidget {
  const WomenDashboard({super.key});

  @override
  State<WomenDashboard> createState() => _WomenDashboardState();
}

class _WomenDashboardState extends State<WomenDashboard> {
  String? phonenumber;
  getemergencyphonenumber() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc('user')
        .collection('Data')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      if (mounted) {
        setState(() {
          phonenumber = value.data()!['contactnumber'].toString();
        });
      }

      print(phonenumber);
    });
  }

  void makePhoneCall() async {
    final url = 'tel:$phonenumber';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void onPhoneShake() {
    makePhoneCall();
  }

  void startShakeDetection() {
    ShakeDetector detector = ShakeDetector.autoStart(onPhoneShake: () {
      onPhoneShake();
    });
  }

  @override
  void initState() {
    startShakeDetection();
    getemergencyphonenumber();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height, width;
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.orange.shade500,
        ),
        title: Text(
          "Women Dashboard",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      drawer: CustomDrawer(),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: width / 6,
          vertical: 20,
        ),
        child: Column(
          children: [
            Image.asset(
              "asset/images/splashscreen.png",
              height: height / 4,
            ),
            SizedBox(
              height: 24,
            ),
            Text(
              "Justice",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 28,
                color: Colors.orange.shade500,
              ),
            ),
            Text(
              "for",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(
                    items[index],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.shade500),
                  ),
                );
              },
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "and",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade400,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Women",
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Colors.orange.shade500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
