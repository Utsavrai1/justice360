// ignore_for_file: prefer_const_constructors

import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';

class InjuryDetails extends StatefulWidget {
  List? generalreporting;
  int? index;
  InjuryDetails(
      {super.key, required this.generalreporting, required this.index});

  @override
  State<InjuryDetails> createState() =>
      _InjuryDetailsState(generalreporting, index);
}

class _InjuryDetailsState extends State<InjuryDetails> {
  List? generalreporting;
  int? index;

  _InjuryDetailsState(this.generalreporting, this.index);
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
          "Injury Details",
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
              SizedBox(
                height: height / 56,
              ),
              CustomTextFormField(TextInputType.text, "Type of Physical Injury",
                  true, 1, 1, generalreporting![index!]['injury']),
              SizedBox(
                height: 24,
              ),
              CustomTextFormField(TextInputType.text, "Hospital's Name", true,
                  1, 3, generalreporting![index!]['hospitalname']),
              SizedBox(
                height: 24,
              ),
              CustomTextFormField(TextInputType.text, "Doctor's Name", true, 1,
                  3, generalreporting![index!]['doctorname']),
              SizedBox(
                height: 24,
              ),
              CustomTextFormField(
                  TextInputType.phone,
                  "Doctor's Contact Number",
                  true,
                  1,
                  3,
                  generalreporting![index!]['doctornumber']),
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
            hintText: hinttext),
        minLines: minLines,
        maxLines: maxLines,
      ),
    ],
  ));
}
