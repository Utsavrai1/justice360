// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:justice360/login.dart';
import 'package:justice360/women/Community_Engagement/communityengagement.dart';
import 'package:justice360/women/Community_Watch/communitywatch.dart';
import 'package:justice360/women/General_Reporting/generalreporting.dart';
import 'package:justice360/women/emergencynotifiactions.dart';
import 'package:justice360/women/nearbyhospital.dart';
import 'package:justice360/women/nearbypolicestation.dart';
import 'package:justice360/women/womendashboard.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

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
                builder: ((context) => WomenDashboard()),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.report),
            title: Text("General Reporting"),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: ((context) => GeneralReporting()),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.remove_red_eye_sharp),
            title: Text("Community Watch"),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: ((context) => CommunityWatch()),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.emergency_rounded),
            title: Text("Emergency Notifications"),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: ((context) => EmergencyNotifications()),
              ),
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CommunityEngagement(),
              ),
            ),
            child: ListTile(
              leading: Icon(Icons.group_rounded),
              title: Text("Community Engagement"),
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NearbyHospitalsPage(),
              ),
            ),
            child: ListTile(
              leading: Icon(Icons.local_hospital_rounded),
              title: Text("Near By Hospital"),
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NearbyPoliceStationsPage(),
              ),
            ),
            child: ListTile(
              leading: Icon(Icons.local_police_rounded),
              title: Text("Near By Police Station"),
            ),
          ),
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
