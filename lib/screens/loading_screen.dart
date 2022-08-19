import 'package:clima/screens/location_screen.dart';
import 'package:clima/services/networking.dart';
import 'package:clima/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import '../services/location.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

const String appid = '0e1ba6a9adf8a6cc75b086c7a68acecc';

var logger = Logger(
  printer: PrettyPrinter(),
);

var loggerNoStack = Logger(
  printer: PrettyPrinter(methodCount: 0),
);

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getLocation();
  }

  void getLocation() async {
    Location location = Location();
    await location.getCurrentLocation();
    loggerNoStack.d('latitude: ${location.latitude}');
    loggerNoStack.d('longitude: ${location.longitude}');

    String url =
        'https://$weatherAPIAuthority/data/2.5/weather?lat=${location.latitude}&lon=${location.longitude}&appid=$appid&units=metric';
    Networking networking = Networking(url);
    var weatherData = await networking.getData();

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(
        locationWeather: weatherData,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 100.0,
        ),
      ),
    );
  }
}
