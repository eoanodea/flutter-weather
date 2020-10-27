import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_weather/services/location.dart';
import 'package:http/http.dart' as http;

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

bool hasLocation = false;

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getLocation();
    getData();
  }

  void getLocation() async {
    Location location = Location();
    await location.getCurrentLocation();
    print(location.latitude);
  }

  void getData() async {
    http.Response response = await http.get(
        'https://samples.openweathermap.org/data/2.5/weather?q=London,uk&appid=439d4b804bc8187953eb36d2a8c26a02');
    if (response.statusCode == 200) {
      String data = response.body;
    } else {
      print(response.statusCode);
    }
  }

  List<Color> colours = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.pink,
    Colors.teal,
    Colors.black,
    Colors.orange
  ];

  Color randomColour() {
    final _random = new Random();
    return colours[_random.nextInt(colours.length)];
  }

  Color selectedColour = Colors.red;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          setState(() {
            selectedColour = randomColour();
          });
        },
        child: Container(
          color: selectedColour,
        ),
      ),
    );
  }
}
