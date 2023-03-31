// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:justice360/components/drawer.dart';
import 'package:justice360/women/Community_Watch/communityfileupload.dart';
import 'package:justice360/women/Community_Watch/incidentdetails.dart';

class CommunityWatch extends StatefulWidget {
  const CommunityWatch({super.key});

  @override
  State<CommunityWatch> createState() => _CommunityWatchState();
}

class _CommunityWatchState extends State<CommunityWatch> {
  late SingleValueDropDownController _cnt;
  @override
  void initState() {
    _cnt = SingleValueDropDownController();
    _getCurrentLocation();
    super.initState();
  }

  Position? position;

  Future<bool> _requestLocationPermission() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      return false;
    }
    return true;
  }

  Future<String> _getAddressFromLatLng(Position position) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark place = placemarks[0];
      return "${place.name}, ${place.street}, ${place.locality}, ${place.postalCode}, ${place.country}";
    } catch (e) {
      throw 'Error getting address from coordinates: $e';
    }
  }

  String? address;

  Future _getCurrentLocation() async {
    bool isPermissionGranted = await _requestLocationPermission();
    if (isPermissionGranted) {
      Position tempposition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      print(position);
      String tempaddress = await _getAddressFromLatLng(tempposition);
      setState(() {
        position = tempposition;
        address = tempaddress;
      });

      locationController.text = address!;

      print('Address: $address');
    } else {
      print('Location permissions are not granted.');
    }
  }

  String? relationship;

  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController addressController = TextEditingController();

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
          "Community Watch",
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
                  controller: nameController,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter some text';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: "Your Name",
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
                  controller: numberController,
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter some text';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: "Your Contact Number",
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
                  readOnly: true,
                  controller: locationController,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter some text';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: "Your Current Location",
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
                  controller: addressController,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter some text';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: "Your Address",
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
                  height: height / 24,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Relationship with Victim",
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
                          DropDownValueModel(
                              name: 'Neighbour', value: "value5"),
                          DropDownValueModel(name: 'Stranger', value: "value6"),
                        ],
                        onChanged: (val) {
                          setState(() {
                            relationship = val.name;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: height / 14,
                ),
                isloading
                    ? CircularProgressIndicator()
                    : ElevatedButton(
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
                                .add({
                              'name': nameController.text.toString(),
                              'number': numberController.text.toString(),
                              'location': locationController.text.toString(),
                              'address': addressController.text.toString(),
                              'relationship': relationship,
                            }).then((value) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: ((context) =>
                                      CommunityFileUpload(id: value.id)),
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
