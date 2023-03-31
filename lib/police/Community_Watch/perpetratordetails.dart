// ignore_for_file: prefer_const_constructors

import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';

class PerpetratorDetails extends StatefulWidget {
  List? communityreporting;
  int? index;
  PerpetratorDetails(
      {super.key, required this.communityreporting, required this.index});

  @override
  State<PerpetratorDetails> createState() =>
      _PerpetratorDetailsState(communityreporting, index);
}

class _PerpetratorDetailsState extends State<PerpetratorDetails> {
  List? communityreporting;
  int? index;
  _PerpetratorDetailsState(this.communityreporting, this.index);
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
          "Perpetrator Details",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.only(
          top: 16,
          right: 24,
          left: 24,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 24),
              CustomTextFormField(TextInputType.number, "Height", true, 1, 1,
                  communityreporting![index!]['height']),
              SizedBox(height: 24),
              CustomTextFormField(TextInputType.number, "Weight", true, 1, 1,
                  communityreporting![index!]['weight']),
              SizedBox(height: 24),
              CustomTextFormField(TextInputType.text, "Complexion", true, 1, 1,
                  communityreporting![index!]['complexion']),
              SizedBox(height: 24),
              CustomTextFormField(TextInputType.text, "Clothing Description",
                  true, 1, 4, communityreporting![index!]['desc']),
              SizedBox(height: 24),
              CustomTextFormField(TextInputType.number, "Estimated Age", true,
                  1, 1, communityreporting![index!]['age']),
              SizedBox(height: 24),
              CustomTextFormField(TextInputType.text, "Gender", true, 1, 1,
                  communityreporting![index!]['perpetratorgender']),
              SizedBox(
                height: 24,
              ),
              CustomTextFormField(TextInputType.text, "Hair Color", true, 1, 1,
                  communityreporting![index!]['haircolor']),
              SizedBox(height: 24),
              CustomTextFormField(TextInputType.number, "Hair Length", true, 1,
                  1, communityreporting![index!]['hairlength']),
              SizedBox(height: 24),
              CustomTextFormField(TextInputType.text, "Hair Style", true, 1, 1,
                  communityreporting![index!]['hairstyle']),
              SizedBox(height: 24),
              CustomTextFormField(
                  TextInputType.text,
                  "Distinguishing Features (If any)",
                  true,
                  1,
                  1,
                  communityreporting![index!]['distinguishing']),
              SizedBox(
                height: 24,
              ),
              CustomTextFormField(
                  TextInputType.text,
                  "Language Spoken by Perpetrator",
                  true,
                  1,
                  1,
                  communityreporting![index!]['language']),
              SizedBox(height: 24),
              CustomTextFormField(
                  TextInputType.text,
                  "Direction in which the perpetrator went after incident",
                  true,
                  1,
                  1,
                  communityreporting![index!]['direction']),
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
