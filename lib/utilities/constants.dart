import 'package:flutter/material.dart';

const kTempTextStyle = TextStyle(
  fontFamily: 'Roboto',
  fontSize: 100.0,
);

const kMessageTextStyle = TextStyle(
  fontFamily: 'Roboto',
  fontSize: 60.0,
);

const kButtonTextStyle = TextStyle(
  fontSize: 30.0,
  fontFamily: 'Roboto',
);

const kConditionTextStyle = TextStyle(
  fontSize: 100.0,
);

const kTextFieldInputDecoration = InputDecoration(
  filled: true,
  fillColor: Colors.white,
  icon: Icon(
    Icons.location_city,
    color: Colors.white,
  ),
  hintText: 'Enter City Name',
  hintStyle: TextStyle(
    color: Colors.grey,
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
    borderSide: BorderSide.none,
  ),
);

const String appid = '0e1ba6a9adf8a6cc75b086c7a68acecc';
const weatherAuthority = 'openweathermap.org';
const weatherAPIAuthority = 'api.openweathermap.org';
