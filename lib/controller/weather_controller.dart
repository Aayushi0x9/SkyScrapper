import 'package:flutter/material.dart';
import 'package:weather_app/helper/shr_pref.dart';
import 'package:weather_app/helper/weather_helper.dart';
import 'package:weather_app/model/weather_model.dart';

class WeatherController with ChangeNotifier {
  Helper helper = Helper();
  WeatherModel? weather;
  String cityName = 'Surat';
  double? temp1;
  String? weather1;
  List<String> bookMarkedCities = [];
  List<String> bookMarkedWeather = [];
  List<double> bookMarkedTemp = [];
  ShrHelper shr = ShrHelper();

  WeatherController() {
    getBookMarkCities();
    getBookMarkedTemp();
    getBookMarkWeather();
  }

  Future<void> loadWether([String? cityName]) async {
    weather = await helper.weatherFetch(cityName);
    print('== WetherData ==========$weather');
    temp1 = weather?.main?.temp;
    notifyListeners();
  }

  Future<void> getBookMarkCities() async {
    bookMarkedCities = await shr.getBookmarkedCities();
    notifyListeners();
  }

  Future<void> getBookMarkedTemp() async {
    bookMarkedTemp = await shr.getBookmarkedTemp();
    notifyListeners();
  }

  Future<void> getBookMarkWeather() async {
    bookMarkedWeather = await shr.getBookmarkedWeather();
    notifyListeners();
  }

  void addCity({required String city, required context}) async {
    if (!bookMarkedCities.contains(city)) {
      bookMarkedCities.add(city);
      bookMarkedTemp.add(temp1!);
      shr.setBookmarkedTemp(bookMarkedTemp);
      shr.setBookmarkedCities(bookMarkedCities);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.green,
          content: Text(
            'BookMark $cityName',
          ),
        ),
      );
      notifyListeners();
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.red,
        content: Text(
          'BookMark already added $cityName',
        ),
      ),
    );
  }

  Future<void> removeCity(int index) async {
    bookMarkedCities.removeAt(index);
    notifyListeners();
  }

  void saveBookMArkTemp({required double temp}) {
    if (!bookMarkedTemp.contains(temp)) {
      bookMarkedTemp.add(temp);
      shr.setBookmarkedTemp(bookMarkedTemp);
      notifyListeners();
    }
  }

  void removeBookMarkedTemp({required int index}) {
    bookMarkedTemp.removeAt(index);
    notifyListeners();
  }

  void saveBookMArkWeather({required String weather}) {
    if (!bookMarkedWeather.contains(weather)) {
      bookMarkedWeather.add(weather);
      shr.setBookmarkedWeather(bookMarkedWeather);
      notifyListeners();
    }
  }

  void removeBookMarkedWeather({required int index}) {
    bookMarkedWeather.removeAt(index);
    notifyListeners();
  }
}
