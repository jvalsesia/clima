import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';
import 'package:clima/services/vault.dart';
import 'package:clima/utilities/constants.dart';

class Weather {

  Vault vault = Vault();

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

    String appId = await vault.getAppId();
    String url =
        'https://$weatherAPIAuthority/data/2.5/weather?lat=${location.latitude}&lon=${location.longitude}&appid=$appId&units=metric';

    return await getWeatherData(url);
  }

  Future<dynamic> getCityWeather(String cityName) async {
    String appId = await vault.getAppId();
    String url =
        'https://$weatherAPIAuthority/data/2.5/weather?q=$cityName&appid=$appId&units=metric';
    return await getWeatherData(url);
  }
}
