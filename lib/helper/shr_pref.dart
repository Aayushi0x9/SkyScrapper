import 'package:shared_preferences/shared_preferences.dart';

class ShrHelper {
  Future<Future<bool>> setBookmarkedCities(List<String> cities) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setStringList('bookmarkKey', cities);
  }

  Future<List<String>> getBookmarkedCities() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('bookmarkKey') ?? [];
  }

  Future<Future<bool>> setBookmarkedTemp(List<double> temp) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> tempStrings = temp.map((e) => e.toString()).toList();
    return prefs.setStringList('bookmarkTemp', tempStrings);
  }

  Future<List<double>> getBookmarkedTemp() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? tempStrings = prefs.getStringList('bookmarkTemp');
    return tempStrings?.map((e) => double.parse(e)).toList() ?? [];
  }

  Future<Future<bool>> setBookmarkedWeather(List<String> weather) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setStringList('bookmarkWeather', weather);
  }

  Future<List<String>> getBookmarkedWeather() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('bookmarkWeather') ?? [];
  }
}
