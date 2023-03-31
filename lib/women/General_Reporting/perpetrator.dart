// ignore_for_file: prefer_const_constructors, unnecessary_null_comparison, prefer_if_null_operators

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:justice360/women/General_Reporting/witness.dart';

class PerpetratorDetails extends StatefulWidget {
  String? id;
  PerpetratorDetails({super.key, required this.id});

  @override
  State<PerpetratorDetails> createState() => _PerpetratorDetailsState(id);
}

class _PerpetratorDetailsState extends State<PerpetratorDetails> {
  String? id;
  _PerpetratorDetailsState(this.id);
  late SingleValueDropDownController _cnt;
  late SingleValueDropDownController __cnt;
  late SingleValueDropDownController ___cnt;
  late SingleValueDropDownController ____cnt;
  @override
  void initState() {
    _cnt = SingleValueDropDownController();
    __cnt = SingleValueDropDownController();
    ___cnt = SingleValueDropDownController();
    ____cnt = SingleValueDropDownController();
    super.initState();
  }

  final _form = GlobalKey<FormState>();
  bool isloading = false;

  TextEditingController perperatornameController = TextEditingController();
  TextEditingController perperatorclothingdescController =
      TextEditingController();
  TextEditingController perperatornumberController = TextEditingController();
  TextEditingController perperatoraddressController = TextEditingController();
  TextEditingController perperatorheightController = TextEditingController();
  TextEditingController perperatorweightController = TextEditingController();
  TextEditingController perperatorcomplexionController =
      TextEditingController();
  TextEditingController perperatorageController = TextEditingController();
  TextEditingController perperatorlanguageController = TextEditingController();
  TextEditingController perperatorhaircolorController = TextEditingController();
  TextEditingController perperatorhairlengthController =
      TextEditingController();
  TextEditingController perperatorhairstyleController = TextEditingController();
  String? gender;
  String? direction;
  String? features;
  String? relation;
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
          padding: EdgeInsets.only(
            top: 16,
            right: 24,
            left: 24,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                CustomTextFormField(TextInputType.text, "Perpetrator' Name",
                    true, 1, 1, perperatornameController),
                SizedBox(height: 24),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Relationship with Perpetrator",
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
                          DropDownValueModel(name: 'Spouse', value: "value1"),
                          DropDownValueModel(name: 'Partner', value: "value2"),
                          DropDownValueModel(
                              name: 'Family Member', value: "value3"),
                          DropDownValueModel(name: 'Friend', value: "value4"),
                          DropDownValueModel(name: 'Stranger', value: "value5"),
                          DropDownValueModel(name: 'Others', value: "value6"),
                        ],
                        onChanged: (val) {
                          setState(() {
                            relation = val.name;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                CustomTextFormField(
                    TextInputType.phone,
                    "Perpetrator's Contact Number",
                    true,
                    1,
                    1,
                    perperatornumberController),
                SizedBox(height: 24),
                CustomTextFormField(TextInputType.text, "Perpetrator's Address",
                    true, 1, 1, perperatoraddressController),
                SizedBox(height: 24),
                CustomTextFormField(TextInputType.number, "Height", true, 1, 1,
                    perperatorheightController),
                SizedBox(height: 24),
                CustomTextFormField(TextInputType.number, "Weight", true, 1, 1,
                    perperatorweightController),
                SizedBox(height: 24),
                CustomTextFormField(TextInputType.text, "Complexion", true, 1,
                    1, perperatorcomplexionController),
                SizedBox(height: 24),
                CustomTextFormField(TextInputType.text, "Clothing Description",
                    true, 1, 4, perperatorclothingdescController),
                SizedBox(height: 24),
                CustomTextFormField(TextInputType.number, "Estimated Age", true,
                    1, 1, perperatorageController),
                SizedBox(height: 24),
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
                        controller: __cnt,
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
                            gender = val.name;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                CustomTextFormField(TextInputType.text, "Hair Color", true, 1,
                    1, perperatorhaircolorController),
                SizedBox(height: 24),
                CustomTextFormField(TextInputType.number, "Hair Length", true,
                    1, 1, perperatorhairlengthController),
                SizedBox(height: 24),
                CustomTextFormField(TextInputType.text, "Hair Style", true, 1,
                    1, perperatorhairstyleController),
                SizedBox(height: 24),
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
                        controller: ___cnt,
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
                            features = val.name;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                CustomTextFormField(
                    TextInputType.text,
                    "Language Spoken by Perpetrator",
                    true,
                    1,
                    1,
                    perperatorlanguageController),
                SizedBox(height: 24),
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
                        controller: ____cnt,
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
                  onPressed: () async {
                    final isValid = _form.currentState?.validate();
                    if (!isValid!) {
                      return null;
                    } else {
                      setState(() {
                        isloading = true;
                      });

                      FirebaseFirestore.instance
                          .collection('users')
                          .doc('user')
                          .collection('General Reporting')
                          .doc(id)
                          .set({
                        'perperatorname': perperatornameController.text == null
                            ? ""
                            : perperatornameController.text,
                        'relation': relation == null ? "" : relation,
                        'perperatornumber':
                            perperatornumberController.text == null
                                ? ""
                                : perperatornumberController.text,
                        'perperatoraddress':
                            perperatoraddressController.text == null
                                ? ""
                                : perperatoraddressController.text,
                        'perperatorheight':
                            perperatorheightController.text == null
                                ? ""
                                : perperatorheightController.text,
                        'perperatorweight':
                            perperatorweightController.text == null
                                ? ""
                                : perperatorweightController.text,
                        'perperatorcomplexion':
                            perperatorcomplexionController.text == null
                                ? ""
                                : perperatorcomplexionController.text,
                        'perperatorclothingdesc':
                            perperatorclothingdescController.text == null
                                ? ""
                                : perperatorclothingdescController.text,
                        'perperatorage': perperatorageController.text == null
                            ? ""
                            : perperatorageController.text,
                        'gender': gender == null ? "" : gender,
                        'perperatorhaircolor':
                            perperatorhaircolorController.text == null
                                ? ""
                                : perperatorhaircolorController.text,
                        'perperatorhairlength':
                            perperatorhairlengthController.text == null
                                ? ""
                                : perperatorhairlengthController.text,
                        'perperatorhairstyle':
                            perperatorhairstyleController.text == null
                                ? ""
                                : perperatorhairstyleController.text,
                        'features': features == null ? "" : features,
                        'perperatorlanguage':
                            perperatorlanguageController.text == null
                                ? ""
                                : perperatorlanguageController.text,
                        'direction': direction == null ? "" : direction
                      }, SetOptions(merge: true)).whenComplete(
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: ((context) => Witness(id: id)),
                          ),
                        ),
                      );
                    }
                  },
                  child: const Text('Next'),
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () => FirebaseFirestore.instance
                      .collection('users')
                      .doc('user')
                      .collection('General Reporting')
                      .doc(id)
                      .set({
                    'perperatorname': "",
                    'relation': '',
                    'perperatornumber': "",
                    'perperatoraddress': "",
                    'perperatorheight': "",
                    'perperatorweight': "",
                    'perperatorcomplexion': "",
                    'perperatorclothingdesc': "",
                    'perperatorage': "",
                    'gender': '',
                    'perperatorhaircolor': "",
                    'perperatorhairlength': "",
                    'perperatorhairstyle': "",
                    'features': '',
                    'perperatorlanguage': "",
                    'direction': ''
                  }, SetOptions(merge: true)).whenComplete(
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: ((context) => Witness(id: id)),
                      ),
                    ),
                  ),
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

  Widget CustomTextFormField(
      TextInputType inputType,
      String hintText,
      bool dense,
      int minLines,
      int maxLines,
      TextEditingController controller) {
    return TextFormField(
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
      controller: controller,
      minLines: minLines,
      maxLines: maxLines,
    );
  }
}
