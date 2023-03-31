// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:justice360/women/womendashboard.dart';

class Post extends StatefulWidget {
  const Post({super.key});

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  String generateRandomString() {
    final random = Random.secure();
    const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';

    return String.fromCharCodes(Iterable.generate(
        18, (_) => chars.codeUnitAt(random.nextInt(chars.length))));
  }

  String? docid;
  String? crime;
  TextEditingController desccontroller = TextEditingController();
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
          "Share Post",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          GestureDetector(
            onTap: () async {
              String docid = generateRandomString();
              await FirebaseFirestore.instance
                  .collection('users')
                  .doc('user')
                  .collection('Community Engagement')
                  .doc(docid)
                  .set({
                'crimetag': crime,
                'blog': desccontroller.text,
                'likes': [],
                'comments': [],
                'docid': docid,
                'date':
                    "${DateTime.now().day.toString()} - ${DateTime.now().month.toString()} - ${DateTime.now().year.toString()}",
                'time':
                    "${DateTime.now().hour.toString()} : ${DateTime.now().minute.toString()} : ${DateTime.now().second.toString()}"
              }).whenComplete(() async {
                Fluttertoast.showToast(msg: 'Added Sucessfully');
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WomenDashboard(),
                  ),
                );
              });
            },
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 12,
              ),
              child: Text(
                "Post",
                style: TextStyle(
                  color: Colors.orange.shade500,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            SizedBox(
              height: 8,
            ),
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
                    dropDownItemCount: 10,
                    dropDownList: const [
                      DropDownValueModel(
                          name: 'Sexual Harassment', value: "value1"),
                      DropDownValueModel(
                          name: 'Domestic Violence', value: "value2"),
                      DropDownValueModel(name: 'Rape', value: "value3"),
                      DropDownValueModel(name: 'Stalking', value: "value4"),
                      DropDownValueModel(
                          name: 'Cyberbullying', value: "value5"),
                      DropDownValueModel(name: 'Acid Attack', value: "value6"),
                      DropDownValueModel(
                          name: 'Forced Marriage', value: "value7"),
                      DropDownValueModel(
                          name: 'Child Marriage', value: "value8"),
                      DropDownValueModel(
                          name: 'Honor Killing', value: "value9"),
                      DropDownValueModel(name: 'Others', value: "value10"),
                    ],
                    onChanged: (val) {
                      if (mounted) {
                        setState(() {
                          crime = val.name;
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 8,
            ),
            TextFormField(
              controller: desccontroller,
              decoration: InputDecoration(
                hintText: "What do you want to talk about?",
                border: InputBorder.none,
              ),
              maxLines: 30,
            ),
          ],
        ),
      ),
    );
  }
}
