import 'package:flutter/material.dart';
import 'package:flutter_weather/services/location.dart';

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
  }

  void getLocation() async {
    Location location = Location();
    await location.getCurrentLocation();
    print(location.latitude);
  }

  @override
  Widget build(BuildContext context) {
    String myMargin = 'abc';
    double myMarginAsDouble;
    try {
      myMarginAsDouble = double.parse(myMargin);
    } catch (e) {
      print(e);
    }

    return Scaffold(
      body: Container(
        color: Colors.red,
        margin: EdgeInsets.all(
          myMarginAsDouble ?? 30.0,
        ),
      ),
    );
  }
}
