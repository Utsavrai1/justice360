// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables

import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:justice360/backend/auth.dart';
import 'package:justice360/login.dart';
import 'package:justice360/women/womendashboard.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool termandcondition = false;
  String? userType;
  late SingleValueDropDownController _cnt;
  String? gender;
  Position? position;

  TextEditingController locationController = TextEditingController();
  TextEditingController aadharController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    _cnt = SingleValueDropDownController();
    _getCurrentLocation();
    super.initState();
  }

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

  bool isChecked = false;
  final _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double height, width;
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      } else {
        return Colors.green;
      }
    }

    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _form,
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: 30,
              vertical: 24,
            ),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.orange.shade300,
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    "asset/images/splashscreen.png",
                    height: height / 5,
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                  "Welcome",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange.shade500,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  "Let's get you onboard",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: Colors.black45,
                  ),
                ),
                SizedBox(
                  height: height / 40,
                ),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: "Email Address",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter the email';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: height / 30,
                ),
                TextFormField(
                  controller: aadharController,
                  decoration: InputDecoration(
                    labelText: "Aadhar",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      if (address == 'null') {
                        return 'Enter the Loaction';
                      }
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: height / 30,
                ),
                DropDownTextField(
                  controller: _cnt,
                  // clearOption: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Select an Item";
                    } else {
                      return null;
                    }
                  },
                  dropDownItemCount: 2,
                  dropDownList: const [
                    DropDownValueModel(name: 'Women', value: "value1"),
                    DropDownValueModel(
                      name: 'Police',
                      value: "value2",
                    ),
                  ],
                  onChanged: (val) {
                    setState(() {
                      userType = val.name.toString();
                    });
                    print(userType);
                  },
                ),
                SizedBox(
                  height: height / 30,
                ),
                TextFormField(
                  readOnly: true,
                  controller: locationController,
                  decoration: InputDecoration(
                      hintText:
                          address == null ? "Location" : address.toString()),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      if (address == 'null') {
                        return 'Enter the Loaction';
                      }
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: height / 30,
                ),
                TextFormField(
                  controller: passwordController,
                  decoration: InputDecoration(labelText: "Password"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter the password';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: height / 50,
                ),
                Row(
                  children: [
                    Flexible(
                      child: Checkbox(
                        checkColor: Colors.white,
                        fillColor: MaterialStateProperty.resolveWith(getColor),
                        value: isChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            isChecked = value!;
                            termandcondition = value;
                          });
                          print(termandcondition);
                        },
                      ),
                    ),
                    Text("I have accepted the "),
                    Text(
                      "Terms and Conditions",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade700,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: height / 60,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (userType == 'Women') {
                      if (int.parse(aadharController.text[10]).isEven) {
                        AuthUser().register(
                            context,
                            _form,
                            emailController.text,
                            passwordController.text,
                            locationController.text,
                            userType,
                            termandcondition);
                      } else {
                        Fluttertoast.showToast(
                            msg:
                                'Warning! you are not allowed to use this app');
                      }
                    } else {
                      AuthUser().register(
                          context,
                          _form,
                          emailController.text,
                          passwordController.text,
                          locationController.text,
                          userType,
                          termandcondition);
                    }
                  },
                  child: Text(
                    "Register",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    padding: EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 16,
                    ),
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an Account ? "),
                    GestureDetector(
                      child: Text(
                        "Sign In",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.blue.shade700,
                        ),
                      ),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: ((context) => LoginPage()),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
