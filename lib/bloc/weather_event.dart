part of 'weather_bloc.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object> get props => [];
}

class GetCityNameEvent extends WeatherEvent {
  final _cityName;
  GetCityNameEvent(this._cityName);

  @override
  List<Object> get props => [_cityName];

}

class ResetWeather extends WeatherEvent {}
