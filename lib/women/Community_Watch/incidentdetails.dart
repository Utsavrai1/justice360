// ignore_for_file: prefer_const_constructors, unnecessary_null_comparison, prefer_if_null_operators

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:justice360/women/Community_Watch/perpetratordetails.dart';

class IncidentDetails extends StatefulWidget {
  String? id;
  IncidentDetails({super.key, required this.id});

  @override
  State<IncidentDetails> createState() => _IncidentDetailsState(id);
}

class _IncidentDetailsState extends State<IncidentDetails> {
  String? id;
  String? weapon;
  String? action;
  _IncidentDetailsState(this.id);
  late SingleValueDropDownController _cnt;
  late SingleValueDropDownController __cnt;
  @override
  void initState() {
    _cnt = SingleValueDropDownController();
    __cnt = SingleValueDropDownController();
    super.initState();
  }

  final _form = GlobalKey<FormState>();

  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController descController = TextEditingController();

  bool isloading = false;

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
        padding: EdgeInsets.symmetric(
          horizontal: 24,
        ),
        child: SingleChildScrollView(
          child: Form(
            key: _form,
            child: Column(
              children: [
                SizedBox(
                  height: height / 56,
                ),
                TextFormField(
                  controller: dateController,
                  keyboardType: TextInputType.datetime,
                  decoration: InputDecoration(
                    hintText: "Date of the Incident",
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
                  controller: timeController,
                  keyboardType: TextInputType.datetime,
                  decoration: InputDecoration(
                    hintText: "Time of the Incident",
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
                  controller: locationController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: "Location of the Incident",
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
                    hintText: "Description of the Incident",
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
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Presence of Weapon",
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
                        dropDownItemCount: 4,
                        dropDownList: const [
                          DropDownValueModel(name: 'Knife', value: "value1"),
                          DropDownValueModel(name: 'Gun', value: "value2"),
                          DropDownValueModel(
                              name: 'Any Other Object', value: "value3"),
                          DropDownValueModel(name: 'None', value: "value4"),
                        ],
                        onChanged: (val) {
                          setState(() {
                            weapon = val.name;
                          });
                        },
                      ),
                    ],
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
                        "Actions taken during the Incident",
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
                        dropDownItemCount: 6,
                        dropDownList: const [
                          DropDownValueModel(
                              name: 'Intervening', value: "value1"),
                          DropDownValueModel(
                              name: 'Calling for help', value: "value2"),
                          DropDownValueModel(
                              name: 'Leaving the Scene', value: "value3"),
                          DropDownValueModel(
                              name: 'Documenting the Incident',
                              value: "value4"),
                          DropDownValueModel(
                              name: 'Reporting the Incident', value: "value5"),
                          DropDownValueModel(
                              name: 'Offering a Ride', value: "value6"),
                          DropDownValueModel(
                              name: 'Providing Shelter', value: "value7"),
                          DropDownValueModel(
                              name:
                                  'Accompanying them to seek Medical Attention',
                              value: "value8"),
                        ],
                        onChanged: (val) {
                          setState(() {
                            action = val.name;
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
                        'dateofincident': dateController.text == null
                            ? ''
                            : dateController.text,
                        'timeofincident': timeController.text == null
                            ? ''
                            : timeController.text,
                        'locationofincident': locationController.text == null
                            ? ''
                            : locationController.text,
                        'descofincident': descController.text == null
                            ? ''
                            : descController.text,
                        'weapon': weapon == null ? "" : weapon,
                        'action': action == null ? "" : action
                      }, SetOptions(merge: true)).whenComplete(
                              () => Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: ((context) =>
                                          PerpetratorDetails(id: id)),
                                    ),
                                  ));
                    }
                  },
                  child: const Text('Next'),
                ),
                SizedBox(
                  height: height / 60,
                ),
                GestureDetector(
                  onTap: () async {
                    await FirebaseFirestore.instance
                        .collection('users')
                        .doc('user')
                        .collection('Community Watch')
                        .doc(id)
                        .set({
                      'dateofincident': '',
                      'timeofincident': '',
                      'locationofincident': '',
                      'descofincident': '',
                      'weapon': '',
                      'action': ''
                    }, SetOptions(merge: true)).whenComplete(
                            () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: ((context) =>
                                        PerpetratorDetails(id: id)),
                                  ),
                                ));
                  },
                  child: Text(
                    "Skip",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
