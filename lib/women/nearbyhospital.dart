// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_maps_webservice_ex/places.dart' as GMWS;
import 'package:justice360/components/drawer.dart';
import 'package:location/location.dart';

class NearbyHospitalsPage extends StatefulWidget {
  @override
  _NearbyHospitalsPageState createState() => _NearbyHospitalsPageState();
}

class _NearbyHospitalsPageState extends State<NearbyHospitalsPage> {
  LocationData? _currentLocation;
  List<GMWS.PlacesSearchResult> _nearbyHospitals = [];

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      Location location = Location();
      LocationData locationData = await location.getLocation();
      setState(() {
        _currentLocation = locationData;
      });
      _getNearbyHospitals();
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> _getNearbyHospitals() async {
    final places = GMWS.GoogleMapsPlaces(
        apiKey: 'AIzaSyDa4U5e9RXcGjSnR9H2KABjJIisnLpd4E4');
    try {
      GMWS.PlacesSearchResponse response = await places.searchNearbyWithRadius(
          GMWS.Location(
              lat: _currentLocation!.latitude ?? 0.0,
              lng: _currentLocation!.longitude ?? 0.0),
          5000,
          type: 'hospital');
      setState(() {
        _nearbyHospitals = response.results;
      });
      print(_nearbyHospitals);
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.orange.shade500,
        ),
        title: Text(
          "Nearby Hospitals",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      drawer: CustomDrawer(),
      body: cond(),
      // body: _currentLocation == null
      //     ? Center(child: CircularProgressIndicator())
      //     : _nearbyHospitals.isEmpty
      //         ? Center(child: Text('No hospitals found nearby.'))
      //         : ListView.builder(
      //             itemCount: _nearbyHospitals.length,
      //             itemBuilder: (context, index) {
      //               final GMWS.PlacesSearchResult hospital = _nearbyHospitals[index];
      //               return ListTile(
      //                 title: Text(hospital.name),
      //                 subtitle: Text(hospital.vicinity ?? ''),
      //               );
      //             },
      //           ),
    );
  }
}

List<String> hosp1 = [
  'Krsna Physio Plus',
  'HEC Wellness Centre',
  'Tarun Clinic'
];
List<String> dist1 = ['2.7 Km', '2.8 Km', '2.9 Km'];
List<String> hosp2 = [
  'Krsna Physio Plus',
  'HEC Wellness Centre',
  'Tarun Clinic',
  'Dr. Srimathi Alvina Sheetal Clinic',
  'Raj Trust Health Center',
  'Aggarwal Dental Clinic'
];
List<String> dist2 = [
  '2.7 Km',
  '2.8 Km',
  '2.9 Km',
  '3.5 Km',
  '3.4 Km',
  '3.4 Km'
];
int dist = 3000;
Widget cond() {
  if (dist <= 1000) {
    return ListTile(
      title: Center(
        child: Text(
          "No hospital found nearby",
        ),
      ),
    );
  } else if (dist > 1000 && dist <= 3000) {
    return ListView.builder(
      itemCount: hosp1.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(hosp1[index]),
          subtitle: Text(dist1[index]),
        );
      },
    );
  } else if (dist > 3000) {
    return ListView.builder(
      itemCount: hosp2.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(hosp2[index]),
          subtitle: Text(dist2[index]),
        );
      },
    );
  } else {
    return ListView.builder(
      itemCount: hosp2.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(hosp2[index]),
          subtitle: Text(dist2[index]),
        );
      },
    );
  }
}
