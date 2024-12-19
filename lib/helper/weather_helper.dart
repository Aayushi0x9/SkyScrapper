import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/model/weather_model.dart';

class Helper {
  Future<WeatherModel?> weatherFetch([cityName]) async {
    String link =
        "https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=d20694b074e77e33ab520b64b505c6e0&units=metric";
    http.Response res = await http.get(Uri.parse(link));
    if (res.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(res.body);
      WeatherModel model = WeatherModel.maptoModal(data);
      return model;
    }
    return null;
  }
}
