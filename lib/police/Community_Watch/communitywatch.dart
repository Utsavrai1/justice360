// ignore_for_file: prefer_const_constructors

import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:justice360/components/policedrawer.dart';
import 'package:justice360/police/Community_Watch/incidentdetails.dart';
import 'package:justice360/police/Community_Watch/viewfile.dart';

class CommunityWatch extends StatefulWidget {
  List? communityreporting;
  int? index;
  CommunityWatch(
      {super.key, required this.communityreporting, required this.index});

  @override
  State<CommunityWatch> createState() =>
      _CommunityWatchState(communityreporting, index);
}

class _CommunityWatchState extends State<CommunityWatch> {
  List? communityreporting;
  int? index;
  _CommunityWatchState(this.communityreporting, this.index);
  late SingleValueDropDownController _cnt;
  @override
  void initState() {
    _cnt = SingleValueDropDownController();
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
          "Community Watch",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      drawer: PoliceCustomDrawer(),
      body: Container(
        padding: EdgeInsets.only(
          left: 24,
          right: 24,
          top: 16,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomTextFormField(TextInputType.text, "Your Name", true, 1, 1,
                  communityreporting![index!]['name']),
              SizedBox(height: 24),
              CustomTextFormField(TextInputType.phone, "Your Contact Number",
                  true, 1, 1, communityreporting![index!]['number']),
              SizedBox(height: 24),
              CustomTextFormField(TextInputType.text, "Your Curent Location",
                  true, 1, 3, communityreporting![index!]['location']),
              SizedBox(height: 24),
              CustomTextFormField(TextInputType.text, "Your Address", true, 1,
                  3, communityreporting![index!]['address']),
              SizedBox(height: 24),
              CustomTextFormField(
                  TextInputType.text,
                  "Relationship with Victim",
                  true,
                  1,
                  1,
                  communityreporting![index!]['relationship']),
              SizedBox(
                height: 56,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Colors.orange.shade500,
                  padding: EdgeInsets.symmetric(
                    horizontal: width / 2.5,
                    vertical: 16,
                  ),
                ),
                onPressed: () {
                  communityreporting![index!]['link'].length != 0
                      ? Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: ((context) => ViewFile(
                                  communityreporting: communityreporting,
                                  index: index,
                                )),
                          ),
                        )
                      : Navigator.push(
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
      ),
    );
  }
}

Widget CustomTextFormField(TextInputType inputType, String hintText, bool dense,
    int minLines, int maxLines, String hinttext) {
  return Container(
      child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        hintText,
        style: TextStyle(
            fontWeight: FontWeight.w500, fontSize: 14, color: Colors.black38),
      ),
      SizedBox(
        height: 8,
      ),
      TextFormField(
        readOnly: true,
        keyboardType: inputType,
        decoration: InputDecoration(
            isDense: dense,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: Colors.orange.shade500,
                style: BorderStyle.solid,
              ),
            ),
            hintText: hinttext),
        minLines: minLines,
        maxLines: maxLines,
      ),
    ],
  ));
}
