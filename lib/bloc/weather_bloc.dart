import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:trial/Repository/weather_repository.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherInitial());

  WeatherRepo weatherRepo = WeatherRepo();
  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
    if (event is GetCityNameEvent) {
      yield WeatherLoading();
      try {
        final data = await weatherRepo.getWeather(event._cityName);
        yield WeatherLoaded(data);
      } catch (e) {
        yield WeatherNotLoaded();
      }
    } else if (event is ResetWeather) {
      yield WeatherInitial();
    }
  }
}
