import 'package:clima/screens/city_screen.dart';
import 'package:clima/screens/loading_screen.dart';
import 'package:clima/services/weather.dart';
import 'package:clima/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

var logger = Logger(
  printer: PrettyPrinter(),
);

class LocationScreen extends StatefulWidget {
  final dynamic locationWeather;

  const LocationScreen({Key? key, this.locationWeather}) : super(key: key);

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  var main = '';
  var description = '';
  var icon = 'Error';
  var temp = 0.0;
  var tempMin = 0.0;
  var tempMax = 0.0;
  var cityName = '';
  var country = '';

  Weather weather = Weather();

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
  }

  Future<void> getWeatherData() async {
    dynamic weatherData = await weather.getLocationWeather();
    updateUI(weatherData);
  }

  Future<void> getCityWeatherData(String cityName) async {
    dynamic weatherData = await weather.getCityWeather(cityName);
    updateUI(weatherData);
  }

  static double checkDouble(dynamic value) {
    if (value is String) {
      return double.parse(value);
    } else if (value is int) {
      return 0.0 + value;
    } else {
      return value;
    }
  }

  void updateUI(dynamic weatherData) {
    setState(() => {
          main = weatherData['weather'][0]['main'],
          description = weatherData['weather'][0]['description'],
          icon = weatherData['weather'][0]['icon'],
          temp = checkDouble(weatherData['main']['temp']),
          tempMin = checkDouble(weatherData['main']['temp_min']),
          tempMax = checkDouble(weatherData['main']['temp_max']),
          cityName = weatherData['name'],
          country = weatherData['sys']['country'],
        });

    loggerNoStack.i(
        'Weather: $main, $description at $cityName - $country | temperature: $temp | min: $tempMin | max: $tempMax');
  }

  Future<void> getCity() async {
    dynamic cityName =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return const CityScreen();
    }));
    if(cityName != null) {
      await getCityWeatherData(cityName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: const AssetImage('images/location_background.png'),
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
                      onPressed: () async {
                        await getWeatherData();
                      },
                      child: const Icon(
                        Icons.near_me,
                        size: 50.0,
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        await getCity();
                      },
                      child: const Icon(
                        Icons.location_city,
                        size: 50.0,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Column(
                    children: <Widget>[
                      Image.network(
                        'http://$weatherAuthority/img/w/$icon.png',
                      ),
                      Text(
                        description,
                        style: kButtonTextStyle,
                      ),
                      Text(
                        '$temp°',
                        style: kTempTextStyle,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: Text(
                    cityName,
                    textAlign: TextAlign.right,
                    style: kMessageTextStyle,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
