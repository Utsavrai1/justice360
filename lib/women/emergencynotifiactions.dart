// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:justice360/backend/user.dart';
import 'package:justice360/components/drawer.dart';
import 'package:location/location.dart' as loc;

class EmergencyNotifications extends StatefulWidget {
  @override
  _EmergencyNotificationsState createState() => _EmergencyNotificationsState();
}

class _EmergencyNotificationsState extends State<EmergencyNotifications> {
  String _currentCity = '';
  String _currentColony = '';
  double _latitude = 0.0;
  double _longitude = 0.0;

  TextEditingController nameController = TextEditingController();
  TextEditingController relationController = TextEditingController();
  TextEditingController numberController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    final location = loc.Location();
    try {
      final _locationData = await location.getLocation();
      await _getAddressFromLatLng(_locationData);
    } catch (e) {
      print('Could not get location: $e');
    }
  }

  Future<void> _getAddressFromLatLng(loc.LocationData _locationData) async {
    final placemarks = await GeocodingPlatform.instance
        .placemarkFromCoordinates(
            _locationData.latitude!, _locationData.longitude!);

    setState(() {
      _currentCity = placemarks[0].locality!;
      _currentColony = placemarks[0].subLocality!;
      _latitude = _locationData.latitude!;
      _longitude = _locationData.longitude!;
    });
  }

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
          "Emergency Notifications",
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
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: 24,
          ),
          child: Container(
            child: Column(
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: height / 32,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter some text';
                        }
                        return null;
                      },
                      controller: numberController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        hintText: "Emergency Contact Number",
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter some text';
                        }
                        return null;
                      },
                      controller: nameController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: "Contact Person Name",
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter some text';
                        }
                        return null;
                      },
                      controller: relationController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: "Relationship with Contact Person",
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
                      height: height / 12,
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
                  ],
                ),
                SizedBox(
                  height: height / 6,
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.orange.shade100,
                      )),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Current City: ',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            '$_currentCity',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.orange.shade500,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Current Colony: ',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            '$_currentColony',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.orange.shade500,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Latitude: ',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            '$_latitude',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.orange.shade500,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Longitude: ',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            '$_longitude',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.orange.shade500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
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
          content: const Text(
              'Do you really want to register this contact number as your emergency contact number ?'),
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
              onPressed: () => Userfunc().setemergency(
                  context,
                  _form,
                  numberController,
                  nameController,
                  relationController,
                  _currentCity,
                  _currentColony,
                  _latitude,
                  _longitude),
            ),
          ],
        );
      },
    );
  }
}
