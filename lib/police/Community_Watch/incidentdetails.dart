// ignore_for_file: prefer_const_constructors

import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:justice360/police/Community_Watch/perpetratordetails.dart';

class IncidentDetails extends StatefulWidget {
  List? communityreporting;
  int? index;
  IncidentDetails(
      {super.key, required this.communityreporting, required this.index});

  @override
  State<IncidentDetails> createState() =>
      _IncidentDetailsState(communityreporting, index);
}

class _IncidentDetailsState extends State<IncidentDetails> {
  List? communityreporting;
  int? index;
  _IncidentDetailsState(this.communityreporting, this.index);
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
          "Incident Details",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.only(
          right: 24,
          left: 24,
          top: 16,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomTextFormField(TextInputType.datetime, "Date of Incident",
                  true, 1, 1, communityreporting![index!]['dateofincident']),
              SizedBox(height: 24),
              CustomTextFormField(TextInputType.datetime, "Time of Incident",
                  true, 1, 1, communityreporting![index!]['timeofincident']),
              SizedBox(height: 24),
              CustomTextFormField(
                  TextInputType.text,
                  "Location of Incident",
                  true,
                  1,
                  3,
                  communityreporting![index!]['locationofincident']),
              SizedBox(height: 24),
              CustomTextFormField(TextInputType.text, "Description of Incident",
                  true, 1, 3, communityreporting![index!]['descofincident']),
              SizedBox(height: 24),
              CustomTextFormField(TextInputType.text, "Presence of Weapon",
                  true, 1, 3, communityreporting![index!]['weapon']),
              SizedBox(
                height: height / 32,
              ),
              CustomTextFormField(
                  TextInputType.text,
                  "Actions taken during incident",
                  true,
                  1,
                  3,
                  communityreporting![index!]['action']),
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
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: ((context) => PerpetratorDetails(
                          communityreporting: communityreporting,
                          index: index,
                        )),
                  ),
                ),
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
        keyboardType: inputType,
        readOnly: true,
        decoration: InputDecoration(
          isDense: dense,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: Colors.orange.shade500,
              style: BorderStyle.solid,
            ),
          ),
          hintText: hinttext,
        ),
        minLines: minLines,
        maxLines: maxLines,
      ),
    ],
  ));
}
