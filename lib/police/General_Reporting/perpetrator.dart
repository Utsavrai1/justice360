// ignore_for_file: prefer_const_constructors

import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:justice360/police/General_Reporting/witness.dart';

class PerpetratorDetails extends StatefulWidget {
  List? generalreporting;
  int? index;
  PerpetratorDetails(
      {super.key, required this.generalreporting, required this.index});

  @override
  State<PerpetratorDetails> createState() =>
      _PerpetratorDetailsState(generalreporting, index);
}

class _PerpetratorDetailsState extends State<PerpetratorDetails> {
  List? generalreporting;
  int? index;

  _PerpetratorDetailsState(this.generalreporting, this.index);
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
              CustomTextFormField(TextInputType.text, "Perpetrator' Name", true,
                  1, 1, generalreporting![index!]['perperatorname']),
              SizedBox(height: 24),
              CustomTextFormField(
                  TextInputType.phone,
                  "Relationship with Perpetrator",
                  true,
                  1,
                  1,
                  generalreporting![index!]['relation']),
              SizedBox(
                height: 24,
              ),
              CustomTextFormField(
                  TextInputType.phone,
                  "Perpetrator's Contact Number",
                  true,
                  1,
                  1,
                  generalreporting![index!]['perperatornumber']),
              SizedBox(height: 24),
              CustomTextFormField(TextInputType.text, "Perpetrator's Address",
                  true, 1, 1, generalreporting![index!]['perperatoraddress']),
              SizedBox(height: 24),
              CustomTextFormField(TextInputType.number, "Height", true, 1, 1,
                  generalreporting![index!]['perperatorheight']),
              SizedBox(height: 24),
              CustomTextFormField(TextInputType.number, "Weight", true, 1, 1,
                  generalreporting![index!]['perperatorweight']),
              SizedBox(height: 24),
              CustomTextFormField(TextInputType.text, "Complexion", true, 1, 1,
                  generalreporting![index!]['perperatorcomplexion']),
              SizedBox(height: 24),
              CustomTextFormField(
                  TextInputType.text,
                  "Clothing Description",
                  true,
                  1,
                  4,
                  generalreporting![index!]['perperatorclothingdesc']),
              SizedBox(height: 24),
              CustomTextFormField(TextInputType.number, "Estimated Age", true,
                  1, 1, generalreporting![index!]['perperatorage']),
              SizedBox(height: 24),
              CustomTextFormField(TextInputType.phone, "Gender", true, 1, 1,
                  generalreporting![index!]['gender']),
              SizedBox(
                height: 24,
              ),
              CustomTextFormField(TextInputType.text, "Hair Color", true, 1, 1,
                  generalreporting![index!]['perperatorhaircolor']),
              SizedBox(height: 24),
              CustomTextFormField(TextInputType.number, "Hair Length", true, 1,
                  1, generalreporting![index!]['perperatorhairlength']),
              SizedBox(height: 24),
              CustomTextFormField(TextInputType.text, "Hair Style", true, 1, 1,
                  generalreporting![index!]['perperatorhairstyle']),
              SizedBox(height: 24),
              CustomTextFormField(
                  TextInputType.phone,
                  "Distinguishing Features (If any)",
                  true,
                  1,
                  1,
                  generalreporting![index!]['features']),
              SizedBox(
                height: 24,
              ),
              CustomTextFormField(
                  TextInputType.text,
                  "Language Spoken by Perpetrator",
                  true,
                  1,
                  1,
                  generalreporting![index!]['perperatorlanguage']),
              SizedBox(height: 24),
              CustomTextFormField(
                  TextInputType.phone,
                  "Direction in which the Perpetrator went after the incident",
                  true,
                  1,
                  1,
                  generalreporting![index!]['direction']),
              SizedBox(
                height: height / 14,
              ),
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
                    builder: ((context) => Witness(
                        generalreporting: generalreporting, index: index)),
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
