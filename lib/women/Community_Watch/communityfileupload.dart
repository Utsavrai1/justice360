// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:justice360/components/drawer.dart';
import 'package:justice360/women/Community_Watch/incidentdetails.dart';
import 'package:justice360/women/General_Reporting/perpetrator.dart';

// Create an instance of Firebase storage and Firestore
FirebaseStorage storage = FirebaseStorage.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;

class CommunityFileUpload extends StatefulWidget {
  String? id;
  CommunityFileUpload({super.key, required this.id});

  @override
  _CommunityFileUploadState createState() => _CommunityFileUploadState(id);
}

class _CommunityFileUploadState extends State<CommunityFileUpload> {
  String? id;
  _CommunityFileUploadState(this.id);
  // Create a list to hold the URLs of the picked files
  List<String> pickedFileUrls = [];

  // Create a function to pick the files and upload them to Firebase storage
  Future<void> pickAndUploadFiles() async {
    List<String> downloadUrls = [];
    pickedFileUrls.clear();
    // Use the file picker plugin to pick multiple files
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: true);

    // Loop through the picked files and upload them to Firebase storage
    if (result != null) {
      for (PlatformFile file in result.files) {
        // Create a unique file name for the file
        String fileName =
            DateTime.now().millisecondsSinceEpoch.toString() + '_' + file.name;
        // Create a reference to the file in Firebase storage
        Reference ref = storage.ref().child(fileName);
        // Upload the file to Firebase storage
        TaskSnapshot task = await ref.putFile(File(file.path!));
        String downloadUrl = await task.ref.getDownloadURL();
        downloadUrls.add(downloadUrl);
      }
    }

    // Set the "pickedFileUrls" list to the download URLs of the uploaded files
    setState(() {
      pickedFileUrls = downloadUrls;
    });
  }

  // Create a function to save the list of URLs to Firebase Firestore
  Future<void> saveUrls(List<String> urls) async {
    // Create a new document in the "files" collection of Firestore
    firestore
        .collection('users')
        .doc('user')
        .collection('Community Watch')
        .doc(id)
        .set({'link': urls}, SetOptions(merge: true)).whenComplete(
            () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => IncidentDetails(
                          id: id,
                        ))));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 246, 243, 243),
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
      body: Container(
        padding: EdgeInsets.only(left: 24, right: 24),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Text(
                    "Upload any proof if any",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                // Display the carousel slider with the picked files
                CarouselSlider(
                  items: pickedFileUrls.map((url) {
                    return Container(
                      child: Image.network(url),
                    );
                  }).toList(),
                  options: CarouselOptions(
                    height: 400.0,
                    enlargeCenterPage: true,
                    autoPlay: true,
                    aspectRatio: 16 / 9,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enableInfiniteScroll: false,
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    viewportFraction: 0.8,
                  ),
                ),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: Colors.orange.shade500,
                    padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width / 2.9,
                      right: MediaQuery.of(context).size.width / 2.9,
                      top: 16,
                      bottom: 16,
                    ),
                  ),
                  child: Text('Select File'),
                  onPressed: pickAndUploadFiles,
                ),
                SizedBox(height: 20.0),
// Display a button to save the URLs to Firebase Firestore
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: Colors.orange.shade500,
                    padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width / 2.6,
                      right: MediaQuery.of(context).size.width / 2.6,
                      top: 16,
                      bottom: 16,
                    ),
                  ),
                  child: Text('Next'),
                  onPressed: () {
                    saveUrls(pickedFileUrls);
                  },
                ),
                SizedBox(height: 20.0),
                GestureDetector(
                  onTap: () {
                    firestore
                        .collection('users')
                        .doc('user')
                        .collection('General Reporting')
                        .doc(id)
                        .set(
                            {'link': ''},
                            SetOptions(
                                merge: true)).whenComplete(() => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => IncidentDetails(
                                      id: id,
                                    ))));
                  },
                  child: Text(
                    "Skip",
                    style: TextStyle(
                        color: Colors.blueAccent, fontWeight: FontWeight.w500),
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
