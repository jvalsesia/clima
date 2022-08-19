import 'package:clima/screens/loading_screen.dart';
import 'package:clima/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

var logger = Logger(
  printer: PrettyPrinter(),
);

class LocationScreen extends StatefulWidget {
  final locationWeather;

  const LocationScreen({Key? key, this.locationWeather}) : super(key: key);

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  var main;
  var description;
  var icon;
  var temp;
  var tempMin;
  var tempMax;
  var cityName;
  var country;

  @override
  void initState() {
    super.initState();
    var weatherData = widget.locationWeather;
    loggerNoStack.i(weatherData);
    updateUI(weatherData);
  }

  void updateUI(dynamic weatherData) {
    setState(() => {
          main = weatherData['weather'][0]['main'],
          description = weatherData['weather'][0]['description'],
          icon =  weatherData['weather'][0]['icon'],
          temp = weatherData['main']['temp'],
          tempMin = weatherData['main']['temp_min'],
          tempMax = weatherData['main']['temp_max'],
          cityName = weatherData['name'],
          country = weatherData['sys']['country'],
        });

    loggerNoStack.i(
        'Weather: $main, $description at $cityName - $country | temperature: $temp | min: $tempMin | max: $tempMax');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () {},
                    child: const Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temp°',
                      style: kTempTextStyle,
                    ),
                    TextButton(
                      onPressed: () {
                      },
                      child: Image.network('http://$weatherAuthority/img/w/$icon.png'),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: Text(
                  '$cityName',
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
