import 'dart:ffi';
import 'dart:io';
import 'package:ffi/ffi.dart';
import 'package:native_try/struct_ffi_for_temp.dart';

typedef TemperatureFunction = Double Function();
typedef TemperatureFunctionDart = double Function();

typedef TypeOfDayWeather = Pointer<Utf8> Function();
typedef TypeOfDayWeatherDart = Pointer<Utf8> Function();

typedef TypedefForAddingDart = int Function(int a, int b);
typedef TypedefForAddingC = Int32 Function(Int32 a, Int32 b);

typedef TypedefForCubeDart = int Function(int a);
typedef TypedefForCubeFFI = Int32 Function(Int32 a);

// TODO: Add new typedef declarations here

// TODO: Add ThreeDayForecast here

class FFIBridge {
  late TemperatureFunctionDart _getTemperature;
  late TypeOfDayWeatherDart _getTypeWeather;
  late TypedefForAddingDart _getAddingVal;
  late TempForOtherDart _getCppStruct;
  late TypedefForCubeDart _getCubeDart;

  // TODO: Add _getForecast declaration here
  // TODO: Add _getThreeDayForecast here

  FFIBridge(this._getTemperature, this._getTypeWeather, this._getAddingVal,
      this._getCubeDart);

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
    _getTypeWeather = dl.lookupFunction<TypeOfDayWeather, TypeOfDayWeatherDart>(
        'get_type_wether');

    _getAddingVal =
        dl.lookupFunction<TypedefForAddingC, TypedefForAddingDart>('sum');

    _getCppStruct =
        dl.lookupFunction<TempFor, TempForOtherDart>("get_three_days_forecast");

    _getCubeDart =
        dl.lookupFunction<TypedefForCubeFFI, TypedefForCubeDart>('get_cube');
  } // 5

  ThreeDaysForecast getThreeDaysForecast(bool useSelcius) {
    return _getCppStruct(useSelcius ? 1 : 0);
  }

  double getTemperature() => _getTemperature();

  String getTypeWeather() {
    final ptr = _getTypeWeather();
    final forecast = ptr.toDartString();
    calloc.free(ptr);
    return forecast;
  }

  int getAddValue(int a, int b) {
    final val = _getAddingVal;
    return val(a, b);
  }

  int getCube(int a) {
    final valueCubed = this._getCubeDart;
    return valueCubed(a);
  }
}
