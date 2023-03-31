// ignore_for_file: prefer_const_constructors

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:justice360/police/General_Reporting/perpetrator.dart';

class ViewFile extends StatefulWidget {
  List? generalreporting;
  int? index;
  ViewFile({super.key, required this.generalreporting, required this.index});

  @override
  State<ViewFile> createState() => _ViewFileState(generalreporting, index);
}

class _ViewFileState extends State<ViewFile> {
  List? generalreporting;
  int? index;
  _ViewFileState(this.generalreporting, this.index);
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
              items: generalreporting![index!]['link'].map<Widget>((url) {
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
                    builder: ((context) => PerpetratorDetails(
                          generalreporting: generalreporting,
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
