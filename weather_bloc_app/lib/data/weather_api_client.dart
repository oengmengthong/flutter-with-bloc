import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'models/weather_model.dart';

class WeatherApiClient {
  static const baseUrl = 'https://api.openweathermap.org/data/2.5/weather';
  final http.Client httpClient;

  WeatherApiClient({required this.httpClient});

  Future<WeatherModel> fetchWeather(String city) async {
    var apiKey = dotenv.env['API_KEY'];
    final url = '$baseUrl?q=$city&appid=$apiKey&units=metric';
    final response = await httpClient.get(Uri.parse(url));

    if (response.statusCode != 200) {
      throw Exception('Error fetching weather');
    }

    final json = jsonDecode(response.body);
    return WeatherModel.fromJson(json);
  }
}