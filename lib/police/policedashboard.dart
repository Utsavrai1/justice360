// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:justice360/components/policedrawer.dart';

final List<String> items = [
  'Domestic Violence',
  'Forced Marriage',
  'Acid Attack',
  'Honor Killing',
  'more.......'
];

class PoliceDashboard extends StatefulWidget {
  const PoliceDashboard({super.key});

  @override
  State<PoliceDashboard> createState() => _PoliceDashboardState();
}

class _PoliceDashboardState extends State<PoliceDashboard> {
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
          "Police Dashboard",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      drawer: PoliceCustomDrawer(),
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
