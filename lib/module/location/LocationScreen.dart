import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({Key? key}) : super(key: key);

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  final CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection('Locations');
  late final QuerySnapshot _dataStream;
  Completer<GoogleMapController> myController = Completer();
  late final allData;
  Location location = Location();
  late LocationData currentLocation;
  double long = 0;
  double lat = 0;
  bool _isLoading = true;

  getData() async {
    currentLocation = await location.getLocation();
    _dataStream = await _collectionReference.get();
    allData = _dataStream.docs.map((e) => e.data()).toList();
    int i = 0;
    for (var data in allData) {
      setState(() {
        long = currentLocation.longitude!;
        lat = currentLocation.latitude!;
        _markers.add(Marker(
            markerId: MarkerId(i.toString()),
            position: LatLng(data['lat'], data['long']),
            infoWindow: InfoWindow(title: 'Dogs!', snippet: '${i + 1}')));
      });
      i++;
    }
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
    });
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Red markers in map present dogs shelter home'),
      behavior: SnackBarBehavior.floating,
    ));
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  void _onMapCreated(GoogleMapController controller) {
    myController.complete(controller);
  }

  final Set<Marker> _markers = {
    const Marker(
        markerId: MarkerId("Kathmandu Animal Treatment Centre"),
        position: LatLng(27.765416460149083, 85.36540718351857),
        infoWindow: InfoWindow(
            title: 'Kathmandu Animal Treatment Centre!', snippet: '')),
    const Marker(
        markerId: MarkerId("Sneha's Care"),
        position: LatLng(27.65252923803723, 85.29293884973414),
        infoWindow: InfoWindow(title: "Sneha's Care", snippet: '')),
    const Marker(
        markerId: MarkerId("Shree's Animal Rescue"),
        position: LatLng(27.75809776523943, 85.39482152769804),
        infoWindow: InfoWindow(title: "Shree's Animal Rescue", snippet: '')),
    const Marker(
        markerId: MarkerId("Kopan Community Dog Welfare Center"),
        position: LatLng(27.740503131339487, 85.37157427002577),
        infoWindow: InfoWindow(
            title: "Kopan Community Dog Welfare Center", snippet: ''))
  };

  @override
  Widget build(BuildContext context) {
    final LatLng center = LatLng(lat, long);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Location'),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height - 60,
        width: double.infinity,
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition:
                    CameraPosition(target: center, zoom: 15.0),
                markers: _markers,
              ),
      ),
    );
  }
}
