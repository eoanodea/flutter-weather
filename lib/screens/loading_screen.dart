import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_weather/screens/location_screen.dart';
import 'package:flutter_weather/services/location.dart';
import 'package:flutter_weather/services/networking.dart';

const apiKey = "937438c5aa7c587fe8632f387109d432";

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

bool hasLocation = false;

class _LoadingScreenState extends State<LoadingScreen> {
  double latitude;
  double longitude;

  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  void getLocationData() async {
    Location location = Location();
    await location.getCurrentLocation();

    latitude = location.latitude;
    longitude = location.longitude;

    NetworkHelper networkHelper = NetworkHelper(
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey');

    var weatherData = await networkHelper;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return LocationScreen();
        },
      ),
    );
  }

  List<Color> colours = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.pink,
    Colors.teal,
    Colors.orange,
    Colors.lime,
    Colors.cyan,
    Colors.yellow
  ];

  Color randomColour() {
    final _random = new Random();
    return colours[_random.nextInt(colours.length)];
  }

  Color selectedColour = Colors.red;
  int taps = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          setState(() {
            selectedColour = randomColour();
            taps++;
          });
        },
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: selectedColour,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SpinKitDoubleBounce(color: Colors.white, size: 100.0),
              Text('Loading data...'),
              SizedBox(
                height: 50.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    taps.toString(),
                    style:
                        TextStyle(fontSize: 50.0, fontWeight: FontWeight.bold),
                  ),
                  Text('taps'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
