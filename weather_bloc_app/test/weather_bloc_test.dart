import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:weather_bloc_app/presentation/blocs/weather_bloc.dart';
import 'package:weather_bloc_app/domain/usecases/get_weather.dart';
import 'package:weather_bloc_app/domain/entities/weather.dart';
import 'package:mocktail/mocktail.dart';

class MockGetWeather extends Mock implements GetWeather {}

void main() {
  late WeatherBloc weatherBloc;
  late MockGetWeather mockGetWeather;

  setUpAll(() {
    registerFallbackValue(GetWeatherEvent(''));
  });

  setUp(() {
    mockGetWeather = MockGetWeather();
    weatherBloc = WeatherBloc(getWeather: mockGetWeather);
  });

  tearDown(() {
    weatherBloc.close();
  });

  test('initial state is WeatherInitial', () {
    expect(weatherBloc.state, WeatherInitial());
  });

  group('GetWeatherEvent', () {
    const tCityName = 'London';
    final tWeather = Weather(cityName: tCityName, temperature: 20);

    blocTest<WeatherBloc, WeatherState>(
      'emits [WeatherLoading, WeatherLoaded] when getWeather is successful',
      build: () {
        when(() => mockGetWeather.execute(tCityName))
            .thenAnswer((_) async => tWeather);
        return weatherBloc;
      },
      act: (bloc) => bloc.add(GetWeatherEvent(tCityName)),
      expect: () => [
        WeatherLoading(),
        WeatherLoaded(tWeather),
      ],
      verify: (_) {
        verify(() => mockGetWeather.execute(tCityName)).called(1);
      },
    );

    blocTest<WeatherBloc, WeatherState>(
      'emits [WeatherLoading, WeatherError] when getWeather fails',
      build: () {
        when(() => mockGetWeather.execute('Unknown'))
            .thenThrow(Exception('Error'));
        return weatherBloc;
      },
      act: (bloc) => bloc.add(GetWeatherEvent('Unknown')),
      expect: () => [
        WeatherLoading(),
        WeatherError('Could not fetch weather'),
      ],
      verify: (_) {
        verify(() => mockGetWeather.execute('Unknown')).called(1);
      },
    );

    blocTest<WeatherBloc, WeatherState>(
      'emits [WeatherLoading, WeatherError] when city name is empty',
      build: () {
        when(() => mockGetWeather.execute(''))
            .thenThrow(Exception('Error'));
        return weatherBloc;
      },
      act: (bloc) => bloc.add(GetWeatherEvent('')),
      expect: () => [
        WeatherLoading(),
        WeatherError('Could not fetch weather'),
      ],
      verify: (_) {
        verify(() => mockGetWeather.execute('')).called(1);
      },
    );
  });
}