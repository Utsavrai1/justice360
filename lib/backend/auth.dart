// ignore_for_file: use_build_context_synchronously, duplicate_ignore, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:justice360/login.dart';
import 'package:justice360/police/policedashboard.dart';
import 'package:justice360/register.dart';
import 'package:justice360/women/womendashboard.dart';

class AuthUser {
  register(BuildContext context, var _form, var email, var password,
      var location, var userType, var termandcondition) async {
    if (termandcondition) {
      final isValid = _form.currentState?.validate();
      if (!isValid) {
        return null;
      } else {
        try {
          // Fetch sign-in methods for the email address
          final list =
              await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
          if (list.isNotEmpty) {
            Fluttertoast.showToast(msg: 'E-mail already exists');
            // ignore: use_build_context_synchronously
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => LoginPage()));
            return true;
          } else {
            try {
              await FirebaseAuth.instance
                  .createUserWithEmailAndPassword(
                      email: email, password: password)
                  .then((value) async {
                User? user = FirebaseAuth.instance.currentUser!;
                await FirebaseFirestore.instance
                    .collection('users')
                    .doc('user')
                    .collection('Data')
                    .doc(user.uid.toString())
                    .set({
                  'uid': user.uid,
                  'email': user.email,
                  'location': location.toString(),
                  'user': userType,
                }).whenComplete(() async {
                  if (userType == 'Women') {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WomenDashboard()));
                  } else if (userType == "Police") {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PoliceDashboard()));
                  }
                });
              });
            } catch (e) {}
          }
        } catch (e) {
          print(e);
        }
      }
    } else {
      return null;
    }
  }

  login(BuildContext context, var _form, var email, var password) async {
    String? usertype;
    final isValid = _form.currentState?.validate();
    if (!isValid) {
      return null;
    } else {
      try {
        // Fetch sign-in methods for the email address
        final list =
            await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
        if (list.isNotEmpty) {
          try {
            await FirebaseAuth.instance
                .signInWithEmailAndPassword(email: email, password: password)
                .whenComplete(() async {
              await FirebaseFirestore.instance
                  .collection('users')
                  .doc('user')
                  .collection('Data')
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .get()
                  .then((value) {
                usertype = value.data()!['user'].toString();
              }).whenComplete(() {
                if (usertype == 'Women') {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => WomenDashboard()));
                } else if (usertype == "Police") {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PoliceDashboard()));
                }
              });
            });
          } catch (e) {
            Fluttertoast.showToast(msg: 'Incorrect Password');
          }
        } else {
          Fluttertoast.showToast(msg: 'E-mail does not exists');
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => RegisterPage()));
        }
      } catch (e) {
        return null;
      }
    }
  }
}
