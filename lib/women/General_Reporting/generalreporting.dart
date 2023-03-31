// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:justice360/components/drawer.dart';
import 'package:justice360/women/General_Reporting/generalfileupload.dart';
import 'package:justice360/women/General_Reporting/perpetrator.dart';

class GeneralReporting extends StatefulWidget {
  const GeneralReporting({super.key});

  @override
  State<GeneralReporting> createState() => _GeneralReportingState();
}

class _GeneralReportingState extends State<GeneralReporting> {
  late SingleValueDropDownController _cnt;
  @override
  void initState() {
    _cnt = SingleValueDropDownController();
    super.initState();
  }

  String? crime;

  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController descController = TextEditingController();

  final _form = GlobalKey<FormState>();
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
          "General Reporting",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      drawer: CustomDrawer(),
      body: Form(
        key: _form,
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.only(
            left: 24,
            right: 24,
            top: 16,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                CustomTextFormField(TextInputType.text, "Your Name", true, 1, 1,
                    nameController),
                SizedBox(height: 24),
                CustomTextFormField(
                    TextInputType.number, "Age", true, 1, 1, ageController),
                SizedBox(height: 24),
                CustomTextFormField(TextInputType.phone, "Contact Number", true,
                    1, 1, numberController),
                SizedBox(height: 24),
                CustomTextFormField(TextInputType.text, "Address", true, 1, 1,
                    addressController),
                SizedBox(height: 24),
                CustomTextFormField(TextInputType.datetime, "Date of Incident",
                    true, 1, 1, dateController),
                SizedBox(height: 24),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Type of Crime",
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
                        dropDownItemCount: 5,
                        dropDownList: const [
                          DropDownValueModel(
                              name: 'Sexual Harassment', value: "value1"),
                          DropDownValueModel(
                              name: 'Domestic Violence', value: "value2"),
                          DropDownValueModel(name: 'Rape', value: "value3"),
                          DropDownValueModel(name: 'Stalking', value: "value4"),
                          DropDownValueModel(
                              name: 'Cyberbullying', value: "value5"),
                          DropDownValueModel(
                              name: 'Acid Attack', value: "value6"),
                          DropDownValueModel(
                              name: 'Forced Marriage', value: "value7"),
                          DropDownValueModel(
                              name: 'Child Marriage', value: "value8"),
                          DropDownValueModel(
                              name: 'Honor Killing', value: "value9"),
                          DropDownValueModel(name: 'Others', value: "value10"),
                        ],
                        onChanged: (val) {
                          setState(() {
                            crime = val.name;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24),
                CustomTextFormField(TextInputType.text, "Location of Incident",
                    true, 1, 3, locationController),
                SizedBox(
                  height: 24,
                ),
                CustomTextFormField(TextInputType.text,
                    "Description of Incident", true, 1, 10, descController),
                SizedBox(height: 56),
                isloading
                    ? CircularProgressIndicator()
                    : ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: Colors.orange.shade500,
                          padding: EdgeInsets.symmetric(
                            horizontal: width / 2.6,
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
                                .collection('General Reporting')
                                .add({
                              'name': nameController.text.toString(),
                              'age': ageController.text.toString(),
                              'number': numberController.text.toString(),
                              'location': locationController.text.toString(),
                              'address': addressController.text.toString(),
                              'desc': descController.text.toString(),
                              'date': dateController.text.toString(),
                              'crime': crime,
                            }).then((value) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: ((context) =>
                                      GeneralFileUpload(id: value.id)),
                                ),
                              );
                            });
                          }
                        },
                        child: const Text('Next'),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget CustomTextFormField(TextInputType inputType, String hintText, bool dense,
    int minLines, int maxLines, var controller) {
  return TextFormField(
    controller: controller,
    keyboardType: inputType,
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
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Enter some text';
      }
      return null;
    },
  );
}
