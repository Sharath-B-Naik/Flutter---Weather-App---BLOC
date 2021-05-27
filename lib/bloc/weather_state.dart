part of 'weather_bloc.dart';

abstract class WeatherState extends Equatable {
  final temp;
  final pressure;
  final humidity;
  final tempMax;
  final tempMin;
  WeatherState(
    this.temp,
    this.pressure,
    this.humidity,
    this.tempMax,
    this.tempMin,
  );

  @override
  List<Object> get props => [
        temp,
        pressure,
        humidity,
        tempMax,
        tempMin,
      ];
}

class WeatherInitial extends WeatherState {
  WeatherInitial() : super(0, 0, 0, 0, 0);
}

class WeatherLoading extends WeatherState {
  WeatherLoading() : super(0, 0, 0, 0, 0);
}

class WeatherLoaded extends WeatherState {
  final finalData;

  WeatherLoaded(this.finalData)
      : super(
          finalData["temp"],
          finalData["pressure"],
          finalData["humidity"],
          finalData["temp_max"],
          finalData["temp_min"],
        );
}

class WeatherNotLoaded extends WeatherState {
  WeatherNotLoaded() : super(0, 0, 0, 0, 0);
}
