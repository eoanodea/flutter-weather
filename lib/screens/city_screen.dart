import 'package:flutter/material.dart';
import 'package:flutter_weather/utilities/constants.dart';

class CityScreen extends StatefulWidget {
  @override
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  String cityName = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Search For City'),
        actions: [
          FlatButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return CityScreen();
                  },
                ),
              );
            },
            child: Icon(
              Icons.location_city,
            ),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              decoration: kTextFieldInputDecoration,
              onChanged: (value) {
                cityName = value;
              },
            ),
            SizedBox(height: 50.0),
            FlatButton(
              color: Colors.teal,
              onPressed: () {
                Navigator.pop(context, cityName);
              },
              child: Text(
                'Search',
                style: kButtonTextStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
