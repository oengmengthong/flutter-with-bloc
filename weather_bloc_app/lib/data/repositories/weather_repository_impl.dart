import '../../domain/entities/weather.dart';
import '../../domain/repositories/weather_repository.dart';
import '../weather_api_client.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherApiClient apiClient;

  WeatherRepositoryImpl({required this.apiClient});

  @override
  Future<Weather> getWeather(String cityName) async {
    final weatherModel = await apiClient.fetchWeather(cityName);
    return Weather(
      cityName: weatherModel.cityName,
      temperature: weatherModel.temperature,
    );
  }
}