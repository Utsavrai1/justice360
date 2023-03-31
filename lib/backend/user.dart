// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Userfunc {
  setemergency(
      BuildContext context,
      var _form,
      var contactnumber,
      var contactname,
      var relationship,
      var _currentCity,
      var _currentColony,
      var _latitude,
      var _longitude) async {
    final isValid = _form.currentState?.validate();
    if (!isValid) {
      return null;
    } else {
      await FirebaseFirestore.instance
          .collection('users')
          .doc('user')
          .collection('Data')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
        'contactnumber': contactnumber.text,
        'contactname': contactname.text,
        'relationship': relationship.text,
        'currentCity': _currentCity,
        'currentColony': _currentColony,
        'latitude': _latitude,
        'longitude': _longitude,
      }, SetOptions(merge: true)).whenComplete(() {
        Navigator.pop(context);
        contactnumber.clear();
        contactname.clear();
        relationship.clear();
      });
    }
  }
}
