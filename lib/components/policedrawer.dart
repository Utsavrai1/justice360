// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:justice360/login.dart';
import 'package:justice360/police/Community_Watch/communitywatch.dart';
import 'package:justice360/police/Community_Watch/dashboard.dart';
import 'package:justice360/police/General_Reporting/dashboard.dart';
import 'package:justice360/police/General_Reporting/generalreporting.dart';
import 'package:justice360/police/policedashboard.dart';

class PoliceCustomDrawer extends StatelessWidget {
  const PoliceCustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    double height, width;
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        children: [
          SizedBox(
            height: 20,
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text("Dashboard"),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: ((context) => PoliceDashboard()),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.report),
            title: Text("General Reporting"),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: ((context) => GeneralDashboard()),
              ),
            ),
          ),
          // ListTile(
          //   leading: Icon(Icons.support_agent),
          //   title: Text("Support Groups"),
          // ),
          ListTile(
            leading: Icon(Icons.remove_red_eye_sharp),
            title: Text("Community Watch"),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: ((context) => CommunityDashboard()),
              ),
            ),
          ),
          // ListTile(
          //   leading: Icon(Icons.playlist_add_check_outlined),
          //   title: Text("Personalized Safety Plan"),
          // ),
          // ListTile(
          //   leading: Icon(Icons.report_problem_rounded),
          //   title: Text("Personalized Risk Assessment"),
          // ),
          // ListTile(
          //   leading: Icon(Icons.map_rounded),
          //   title: Text("Smart Mapping"),
          // ),
          // ListTile(
          //   leading: Icon(Icons.cases_rounded),
          //   title: Text("Virtual Legal Clinic"),
          // ),
          GestureDetector(
            onTap: () => FirebaseAuth.instance.signOut().whenComplete(
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginPage(),
                    ),
                  ),
                ),
            child: ListTile(
              leading: Icon(Icons.logout),
              title: Text("Logout"),
            ),
          )
        ],
      ),
    );
  }
}
