import 'dart:ffi';
import 'dart:io';
import 'package:ffi/ffi.dart';

typedef TemperatureFunction = Double Function();
typedef TemperatureFunctionDart = double Function();

typedef TypeOfDayWeather=Pointer<Utf8> Function();
typedef TypeOfDayWeatherDart=Pointer<Utf8> Function();
// TODO: Add new typedef declarations here

// TODO: Add ThreeDayForecast here

class FFIBridge {
  late TemperatureFunctionDart _getTemperature;
  late TypeOfDayWeatherDart _getTypeWeather;

  // TODO: Add _getForecast declaration here
  // TODO: Add _getThreeDayForecast here

  FFIBridge(this._getTemperature, this._getTypeWeather);

  FFIBridge.init() {
    // 1
    final dl = Platform.isAndroid
        ? DynamicLibrary.open('libweather.so')
        : DynamicLibrary.process();

    _getTemperature = dl
    // 2
        .lookupFunction<
    // 3
        TemperatureFunction,
    // 4
        TemperatureFunctionDart>('get_temp');

    // TODO: Assign value to _getForecast

    // TODO: Assign value to _getThreeDayForecast here

    _getTypeWeather = dl.lookupFunction<TypeOfDayWeather, TypeOfDayWeatherDart>(
        'get_type_wether');
  } // 5

  double getTemperature() => _getTemperature();

  String getTypeWeather() {
    final ptr = _getTypeWeather();
    final forecast = ptr.toDartString();
    calloc.free(ptr);
    return forecast;
  }
}