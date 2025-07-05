import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LocationPage(),
    );
  }
}

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  late WebSocketChannel channel;
  Position? _currentPosition;

  @override
  void initState() {
    super.initState();
    _initLocation();
    // Replace with your server's IP address
        channel = WebSocketChannel.connect(Uri.parse('ws://192.168.1.5:8080'));
  }

  Future<void> _initLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Geolocator.getPositionStream().listen((Position position) {
      setState(() {
        _currentPosition = position;
      });
      final locationData = {
        'latitude': position.latitude,
        'longitude': position.longitude,
      };
      channel.sink.add(jsonEncode(locationData));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Live Location Tracker'),
      ),
      body: Center(
        child: _currentPosition == null
            ? const CircularProgressIndicator()
            : Text(
                'Latitude: ${_currentPosition!.latitude}\nLongitude: ${_currentPosition!.longitude}'),
      ),
    );
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }
}