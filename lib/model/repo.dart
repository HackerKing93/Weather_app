import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/model/weather_model.dart';

class Repo {
  Future<WeatherModel> getWeather(String? city) async {
    if (city == null) {
      throw ArgumentError.notNull('city');
    }

    var url =
        "https://api.openweathermap.org/data/2.5/weather?q=$city&APPID=43ea6baaad7663dc17637e22ee6f78f2";

    final res = await http.get(Uri.parse(url));

    var resBody = res.body;

    if (res.statusCode == 200) {
      return WeatherModel.fromJson(json.decode(resBody));
    } else {
      throw Exception();
    }
  }
}
