import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/weather.dart';
import '../../domain/usecases/get_weather.dart';

// Events
abstract class WeatherEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetWeatherEvent extends WeatherEvent {
  final String cityName;

  GetWeatherEvent(this.cityName);

  @override
  List<Object?> get props => [cityName];
}

// States
abstract class WeatherState extends Equatable {
  @override
  List<Object?> get props => [];
}

class WeatherInitial extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final Weather weather;

  WeatherLoaded(this.weather);

  @override
  List<Object?> get props => [weather];
}

class WeatherError extends WeatherState {
  final String message;

  WeatherError(this.message);

  @override
  List<Object?> get props => [message];
}

// Bloc
class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetWeather getWeather;

  WeatherBloc({required this.getWeather}) : super(WeatherInitial()) {
    on<GetWeatherEvent>((event, emit) async {
      emit(WeatherLoading());
      try {
        final weather = await getWeather.execute(event.cityName);
        emit(WeatherLoaded(weather));
      } catch (e) {
        emit(WeatherError('Could not fetch weather'));
      }
    });
  }
}