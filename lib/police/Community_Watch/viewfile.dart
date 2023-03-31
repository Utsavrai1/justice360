// ignore_for_file: prefer_const_constructors

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:justice360/police/Community_Watch/incidentdetails.dart';

class ViewFile extends StatefulWidget {
  List? communityreporting;
  int? index;
  ViewFile({super.key, required this.communityreporting, required this.index});

  @override
  State<ViewFile> createState() => _ViewFileState(communityreporting, index);
}

class _ViewFileState extends State<ViewFile> {
  List? communityreporting;
  int? index;
  _ViewFileState(this.communityreporting, this.index);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.orange.shade500,
        ),
        title: Text(
          "File Upload",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CarouselSlider(
              items: communityreporting![index!]['link'].map<Widget>((url) {
                return Container(
                  child: Image.network(url),
                );
              }).toList(),
              options: CarouselOptions(
                height: 400.0,
                enlargeCenterPage: true,
                autoPlay: true,
                aspectRatio: 16 / 9,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: false,
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                viewportFraction: 0.8,
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: Colors.orange.shade500,
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width / 2.5,
                  vertical: 16,
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: ((context) => IncidentDetails(
                          communityreporting: communityreporting,
                          index: index,
                        )),
                  ),
                );
              },
              child: const Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}
