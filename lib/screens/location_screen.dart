import 'package:flutter/material.dart';
import 'package:flutter_weather/services/weather.dart';
import 'package:flutter_weather/utilities/constants.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen(this.locationWeather);
  final locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  int temperature;
  String weatherIcon;
  String message;
  String cityName;

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        weatherIcon = 'Error';
        message = 'Unable to get weather data';
        cityName = '';
        return;
      }
      double temp = weatherData['main']['temp'];

      temperature = temp.toInt();
      message = weather.getMessage(temperature);

      cityName = weatherData['name'];

      var condition = weatherData['weather'][0]['id'];
      weatherIcon = weather.getWeatherIcon(condition);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Weather App'),
        leading: FlatButton(
          onPressed: () async {
            var weatherData = await weather.getLocationWeather();
            updateUI(weatherData);
          },
          child: Icon(
            Icons.near_me,
          ),
        ),
        actions: [
          FlatButton(
            onPressed: () {},
            child: Icon(
              Icons.location_city,
            ),
          ),
        ],
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    '$temperature°',
                    style: kTempTextStyle,
                  ),
                  Text(
                    weatherIcon,
                    style: kConditionTextStyle,
                  ),
                ],
              ),
              Text(
                '$message in $cityName',
                style: kMessageTextStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// double temperature = decodedData['main']['temp'];
// int condition = decodedData['weather'][0]['id'];
// String cityName = decodedData['name'];
