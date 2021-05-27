import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherRepo {
  Future<dynamic> getWeather(String city) async {
    final result = await http.get(Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?q=$city&APPID=43ea6baaad7663dc17637e22ee6f78f2"));
    if (result.statusCode != 200) {
      throw Exception();
    }
    var jsondata = jsonDecode(result.body);
    var requiredData = jsondata["main"];

    return requiredData;
  }
}
