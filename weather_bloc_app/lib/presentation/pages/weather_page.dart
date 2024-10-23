import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/weather.dart';
import '../blocs/weather_bloc.dart';

class WeatherPage extends StatelessWidget {
  final TextEditingController _cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Weather BLoC App')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _cityController,
              decoration: InputDecoration(labelText: 'Enter City Name'),
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  context.read<WeatherBloc>().add(GetWeatherEvent(value));
                }
              },
            ),
            SizedBox(height: 20),
            // BlocBuilder
            BlocBuilder<WeatherBloc, WeatherState>(
              builder: (context, state) {
                if (state is WeatherInitial) {
                  return Text('Please enter a city name');
                } else if (state is WeatherLoading) {
                  return CircularProgressIndicator();
                } else if (state is WeatherLoaded) {
                  return Column(
                    children: [
                      Text(
                        state.weather.cityName,
                        style: TextStyle(fontSize: 24),
                      ),
                      Text(
                        '${state.weather.temperature} °C',
                        style: TextStyle(fontSize: 48),
                      ),
                    ],
                  );
                } else if (state is WeatherError) {
                  return Text(state.message);
                } else {
                  return Container();
                }
              },
            ),
            // BlocSelector
            BlocSelector<WeatherBloc, WeatherState, Weather?>(
              selector: (state) {
                if (state is WeatherLoaded) {
                  return state.weather;
                } else {
                  return null;
                }
              },
              builder: (context, weather) {
                if (weather != null) {
                  return Column(
                    children: [
                      Text(
                        weather.cityName,
                        style: TextStyle(fontSize: 24),
                      ),
                      Text(
                        '${weather.temperature} °C',
                        style: TextStyle(fontSize: 48),
                      ),
                    ],
                  );
                } else {
                  return Container();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}