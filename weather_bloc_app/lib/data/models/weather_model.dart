class WeatherModel {
  final String cityName;
  final double temperature;

  WeatherModel({required this.cityName, required this.temperature});

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      cityName: json['name'],
      temperature: json['main']['temp'].toDouble(),
    );
  }
}