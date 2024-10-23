import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'presentation/blocs/weather_bloc.dart';
import 'presentation/pages/weather_page.dart';
import 'data/weather_api_client.dart';
import 'data/repositories/weather_repository_impl.dart';
import 'domain/usecases/get_weather.dart';
import 'package:http/http.dart' as http;

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  final WeatherApiClient apiClient = WeatherApiClient(
    httpClient: http.Client(),
  );
  final weatherRepository = WeatherRepositoryImpl(apiClient: apiClient);
  final getWeather = GetWeather(weatherRepository);

  runApp(MyApp(getWeather: getWeather));
}

class MyApp extends StatelessWidget {
  final GetWeather getWeather;

  MyApp({required this.getWeather});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (_) => WeatherBloc(getWeather: getWeather),
        child: WeatherPage(),
      ),
    );
  }
}