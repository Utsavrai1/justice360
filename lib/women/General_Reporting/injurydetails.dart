// ignore_for_file: prefer_const_constructors, prefer_if_null_operators, unnecessary_null_comparison

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:justice360/women/womendashboard.dart';

class InjuryDetails extends StatefulWidget {
  String? id;
  InjuryDetails({super.key, required this.id});

  @override
  State<InjuryDetails> createState() => _InjuryDetailsState(id);
}

class _InjuryDetailsState extends State<InjuryDetails> {
  String? id;
  _InjuryDetailsState(this.id);
  late SingleValueDropDownController _cnt;
  @override
  void initState() {
    _cnt = SingleValueDropDownController();
    super.initState();
  }

  String? injury;
  TextEditingController hospitalnameController = TextEditingController();
  TextEditingController doctornameController = TextEditingController();
  TextEditingController doctornumberController = TextEditingController();
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
          "Injury Details",
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
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Type of Physical Injury",
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
                        dropDownItemCount: 4,
                        dropDownList: const [
                          DropDownValueModel(name: 'Cuts', value: "value1"),
                          DropDownValueModel(name: 'Bruises', value: "value2"),
                          DropDownValueModel(
                              name: 'Broken Bones', value: "value3"),
                          DropDownValueModel(
                              name: 'Other Injuries', value: "value4"),
                        ],
                        onChanged: (val) {
                          setState(() {
                            injury = val.name;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                CustomTextFormField(TextInputType.text, "Hospital's Name", true,
                    1, 3, hospitalnameController),
                SizedBox(
                  height: 24,
                ),
                CustomTextFormField(TextInputType.text, "Doctor's Name", true,
                    1, 3, doctornameController),
                SizedBox(
                  height: 24,
                ),
                CustomTextFormField(
                    TextInputType.text,
                    "Doctor's Contact Number",
                    true,
                    1,
                    3,
                    doctornumberController),
                SizedBox(
                  height: 40,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: Colors.orange.shade500,
                    padding: EdgeInsets.symmetric(
                      horizontal: width / 2.7,
                      vertical: 16,
                    ),
                  ),
                  onPressed: () => _dialogBuilder(context),
                  child: const Text('Submit'),
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
          actions: <Widget>[
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
                  await FirebaseFirestore.instance
                      .collection('users')
                      .doc('user')
                      .collection('General Reporting')
                      .doc(id)
                      .set({
                    'injury': injury == null ? "" : injury,
                    'hospitalname': hospitalnameController.text == null
                        ? ''
                        : hospitalnameController.text,
                    'doctorname': doctornameController.text == null
                        ? ''
                        : doctornameController.text,
                    'doctornumber': doctornumberController.text == null
                        ? ''
                        : doctornumberController.text,
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

  Widget CustomTextFormField(
      TextInputType inputType,
      String hintText,
      bool dense,
      int minLines,
      int maxLines,
      TextEditingController controller) {
    return TextFormField(
      keyboardType: inputType,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        isDense: dense,
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
      minLines: minLines,
      maxLines: maxLines,
    );
  }
}
