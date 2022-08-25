import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:flutter/services.dart';

class Vault {
  Future<List> loadSecretsJsonData() async {
    var jsonText = await rootBundle.loadString('assets/vault/secrets.json');
    List data = json.decode(jsonText);
    return data;
  }

  Future<String> getAppId() async {
    List data = await loadSecretsJsonData();
    return data[0]['appid'];
  }
}
