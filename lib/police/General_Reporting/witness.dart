// ignore_for_file: prefer_const_constructors

import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:justice360/police/General_Reporting/injurydetails.dart';

class Witness extends StatefulWidget {
  List? generalreporting;
  int? index;
  Witness({super.key, required this.generalreporting, required this.index});

  @override
  State<Witness> createState() => _WitnessState(generalreporting, index);
}

class _WitnessState extends State<Witness> {
  List? generalreporting;
  int? index;
  _WitnessState(this.generalreporting, this.index);
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
          "Witness Details",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.only(
          left: 24,
          right: 24,
          top: 16,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomTextFormField(TextInputType.text, "Witness's Name", true, 1,
                  1, generalreporting![index!]['witnessname']),
              SizedBox(height: 24),
              CustomTextFormField(
                  TextInputType.phone,
                  "Relationship with Witness",
                  true,
                  1,
                  1,
                  generalreporting![index!]['relationship']),
              SizedBox(
                height: 24,
              ),
              CustomTextFormField(
                  TextInputType.phone,
                  "Witness's Contact Number",
                  true,
                  1,
                  1,
                  generalreporting![index!]['witnesscontact']),
              SizedBox(height: 24),
              CustomTextFormField(TextInputType.text, "Witness's Address", true,
                  1, 1, generalreporting![index!]['witnessaddress']),
              SizedBox(height: 24),
              CustomTextFormField(TextInputType.phone, "Witness's Age", true, 1,
                  1, generalreporting![index!]['witnessage']),
              SizedBox(height: 56),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Colors.orange.shade500,
                  padding: EdgeInsets.symmetric(
                    horizontal: width / 2.6,
                    vertical: 16,
                  ),
                ),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: ((context) => InjuryDetails(
                          generalreporting: generalreporting,
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
          hintText: hinttext,
        ),
        minLines: minLines,
        maxLines: maxLines,
      ),
    ],
  ));
}
