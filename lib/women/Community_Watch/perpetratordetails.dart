// ignore_for_file: prefer_const_constructors, unnecessary_null_comparison, prefer_if_null_operators

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:justice360/women/womendashboard.dart';

class PerpetratorDetails extends StatefulWidget {
  String? id;
  PerpetratorDetails({super.key, required this.id});

  @override
  State<PerpetratorDetails> createState() => _PerpetratorDetailsState(id);
}

class _PerpetratorDetailsState extends State<PerpetratorDetails> {
  String? id;
  bool isloading = false;
  _PerpetratorDetailsState(this.id);
  late SingleValueDropDownController _cnt;
  late SingleValueDropDownController __cnt;
  late SingleValueDropDownController ___cnt;
  @override
  void initState() {
    _cnt = SingleValueDropDownController();
    __cnt = SingleValueDropDownController();
    ___cnt = SingleValueDropDownController();
    super.initState();
  }

  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController complexionController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  String? perpetratorgender;
  TextEditingController haircolorController = TextEditingController();
  TextEditingController hairlengthController = TextEditingController();
  TextEditingController hairstyleController = TextEditingController();
  String? distinguishing;
  TextEditingController languageController = TextEditingController();
  String? direction;
  final _form = GlobalKey<FormState>();

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
      body: Form(
        key: _form,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 24,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: height / 56,
                ),
                TextFormField(
                  controller: heightController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "Height",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    fillColor: Color(0xFFFAFAFA),
                    filled: true,
                  ),
                ),
                SizedBox(
                  height: height / 32,
                ),
                TextFormField(
                  controller: weightController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "Weight",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    fillColor: Color(0xFFFAFAFA),
                    filled: true,
                  ),
                ),
                SizedBox(
                  height: height / 32,
                ),
                TextFormField(
                  controller: complexionController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: "Complexion",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    fillColor: Color(0xFFFAFAFA),
                    filled: true,
                  ),
                ),
                SizedBox(
                  height: height / 32,
                ),
                TextFormField(
                  controller: descController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: "Description of the Clothing",
                    isDense: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    fillColor: Color(0xFFFAFAFA),
                    filled: true,
                  ),
                  maxLines: 10,
                  minLines: 6,
                ),
                SizedBox(
                  height: height / 32,
                ),
                TextFormField(
                  controller: ageController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: "Estimated Age",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    fillColor: Color(0xFFFAFAFA),
                    filled: true,
                  ),
                ),
                SizedBox(
                  height: height / 32,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Gender",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                        ),
                      ),
                      DropDownTextField(
                        controller: _cnt,
                        clearOption: true,
                        validator: (value) {
                          if (value == null) {
                            return "Required field";
                          } else {
                            return null;
                          }
                        },
                        dropDownItemCount: 3,
                        dropDownList: const [
                          DropDownValueModel(name: 'Male', value: "value1"),
                          DropDownValueModel(name: 'Female', value: "value2"),
                          DropDownValueModel(name: 'Others', value: "value3"),
                        ],
                        onChanged: (val) {
                          setState(() {
                            perpetratorgender = val.name;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: height / 32,
                ),
                TextFormField(
                  controller: haircolorController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: "Hair Color",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    fillColor: Color(0xFFFAFAFA),
                    filled: true,
                  ),
                ),
                SizedBox(
                  height: height / 32,
                ),
                TextFormField(
                  controller: hairlengthController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: "Hair Length",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    fillColor: Color(0xFFFAFAFA),
                    filled: true,
                  ),
                ),
                SizedBox(
                  height: height / 32,
                ),
                TextFormField(
                  controller: hairstyleController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: "Hair Style",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    fillColor: Color(0xFFFAFAFA),
                    filled: true,
                  ),
                ),
                SizedBox(
                  height: height / 32,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Distinguishing Features (if any)",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                        ),
                      ),
                      DropDownTextField(
                        controller: __cnt,
                        clearOption: true,
                        validator: (value) {
                          if (value == null) {
                            return "Required field";
                          } else {
                            return null;
                          }
                        },
                        dropDownItemCount: 5,
                        dropDownList: const [
                          DropDownValueModel(name: 'Tatoos', value: "value1"),
                          DropDownValueModel(
                              name: 'Birthmarks', value: "value2"),
                          DropDownValueModel(name: 'Scars', value: "value3"),
                          DropDownValueModel(
                              name: 'Piercings', value: "value4"),
                          DropDownValueModel(name: 'None', value: "value5"),
                        ],
                        onChanged: (val) {
                          setState(() {
                            distinguishing = val.name;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: height / 32,
                ),
                TextFormField(
                  controller: languageController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: "Language Spoken by Perpetrator",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    fillColor: Color(0xFFFAFAFA),
                    filled: true,
                  ),
                ),
                SizedBox(
                  height: height / 32,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Direction in which perpetrator went after incident",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                        ),
                      ),
                      DropDownTextField(
                        controller: ___cnt,
                        clearOption: true,
                        validator: (value) {
                          if (value == null) {
                            return "Required field";
                          } else {
                            return null;
                          }
                        },
                        dropDownItemCount: 4,
                        dropDownList: const [
                          DropDownValueModel(name: 'East', value: "value1"),
                          DropDownValueModel(name: 'West', value: "value2"),
                          DropDownValueModel(name: 'North', value: "value3"),
                          DropDownValueModel(name: 'South', value: "value4"),
                        ],
                        onChanged: (val) {
                          setState(() {
                            direction = val.name;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: height / 20,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: Colors.orange.shade500,
                    padding: EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 16,
                    ),
                  ),
                  onPressed: () => _dialogBuilder(context),
                  child: const Text('Submit'),
                ),
                SizedBox(
                  height: height / 56,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Are You Sure ?'),
          content: const Text('Do you really want to register this report ?'),
          actions: isloading
              ? [
                  CircularProgressIndicator(),
                ]
              : <Widget>[
                  TextButton(
                    style: TextButton.styleFrom(
                      textStyle: Theme.of(context).textTheme.labelLarge,
                    ),
                    child: const Text('Decline'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      textStyle: Theme.of(context).textTheme.labelLarge,
                    ),
                    child: const Text('Agree'),
                    onPressed: () async {
                      final isValid = _form.currentState?.validate();
                      if (!isValid!) {
                        return null;
                      } else {
                        setState(() {
                          isloading = true;
                        });
                        await FirebaseFirestore.instance
                            .collection('users')
                            .doc('user')
                            .collection('Community Watch')
                            .doc(id)
                            .set({
                          'height': heightController.text == null
                              ? ''
                              : heightController.text,
                          'weight': weightController.text == null
                              ? ''
                              : weightController.text,
                          'complexion': complexionController.text == null
                              ? ''
                              : complexionController.text,
                          'desc': descController.text == null
                              ? ''
                              : descController.text,
                          'age': ageController.text == null
                              ? ''
                              : ageController.text,
                          'perpetratorgender': perpetratorgender == null
                              ? ""
                              : perpetratorgender,
                          'haircolor': haircolorController.text == null
                              ? ''
                              : haircolorController.text,
                          'hairlength': hairlengthController.text == null
                              ? ''
                              : hairlengthController.text,
                          'hairstyle': hairstyleController.text == null
                              ? ''
                              : hairstyleController.text,
                          'distinguishing':
                              distinguishing == null ? "" : distinguishing,
                          'language': languageController.text == null
                              ? ''
                              : languageController.text,
                          'direction': direction == null ? "" : direction
                        }, SetOptions(merge: true)).whenComplete(() {
                          Fluttertoast.showToast(
                              msg: 'Your report has been registered.');
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => WomenDashboard()));
                        });
                      }
                    },
                  ),
                ],
        );
      },
    );
  }
}
