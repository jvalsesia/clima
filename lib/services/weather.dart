import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';
import 'package:clima/utilities/constants.dart';

class Weather {
  Future<dynamic> getWeatherData(String url) async {
    Networking networking = Networking(url);
    var weatherData = await networking.getData();
    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();
    loggerNoStack.d('latitude: ${location.latitude}');
    loggerNoStack.d('longitude: ${location.longitude}');

    String url =
        'https://$weatherAPIAuthority/data/2.5/weather?lat=${location.latitude}&lon=${location.longitude}&appid=$appid&units=metric';

    return await getWeatherData(url);
  }

  Future<dynamic> getCityWeather(String cityName) async {
    String url =
        'https://$weatherAPIAuthority/data/2.5/weather?q=$cityName&appid=$appid&units=metric';
    return await getWeatherData(url);
  }
}
