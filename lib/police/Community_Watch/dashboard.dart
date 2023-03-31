// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:justice360/components/policedrawer.dart';
import 'package:justice360/police/Community_Watch/communitywatch.dart';
import 'package:justice360/police/General_Reporting/generalreporting.dart';

class CommunityDashboard extends StatefulWidget {
  const CommunityDashboard({super.key});

  @override
  State<CommunityDashboard> createState() => _CommunityDashboardState();
}

class _CommunityDashboardState extends State<CommunityDashboard> {
  bool isloading = true;
  List communityreports = List.empty(growable: true);
  getdata() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc('user')
        .collection('Community Watch')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        communityreports.add(element.data());
      });
    }).whenComplete(() {
      setState(() {
        isloading = false;
      });
    });

    print(communityreports);
  }

  @override
  void initState() {
    getdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.orange.shade500,
        ),
        title: Text(
          "Police Dashboard",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      drawer: PoliceCustomDrawer(),
      body: isloading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: communityreports.length,
              itemBuilder: (context, index) => ListTile(
                title: Text(communityreports[index]["name"]),
                trailing: GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CommunityWatch(
                              communityreporting: communityreports,
                              index: index))),
                  child: Icon(Icons.navigate_next_rounded),
                ),
              ),
            ),
    );
  }
}
