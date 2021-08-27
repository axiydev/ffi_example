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

// TODO: Add new typedef declarations here

// TODO: Add ThreeDayForecast here

class FFIBridge {
  late TemperatureFunctionDart _getTemperature;
  late TypeOfDayWeatherDart _getTypeWeather;
  late TypedefForAddingDart _getAddingVal;
  late TempForOtherDart _getCppStruct;

  // TODO: Add _getForecast declaration here
  // TODO: Add _getThreeDayForecast here

  FFIBridge(this._getTemperature, this._getTypeWeather, this._getAddingVal);

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

    _getAddingVal=dl.lookupFunction<TypedefForAddingC,TypedefForAddingDart>('sum');

    _getCppStruct=dl.lookupFunction<TempFor,TempForOtherDart>("get_three_days_forecast");
  } // 5

  ThreeDaysForecast getThreeDaysForecast(bool useSelcius){
    return _getCppStruct(useSelcius?1:0);
  }
  double getTemperature() => _getTemperature();

  String getTypeWeather() {
    final ptr = _getTypeWeather();
    final forecast = ptr.toDartString();
    calloc.free(ptr);
    return forecast;
  }

  int getAddValue(int a,int b){
    final val=_getAddingVal;
    return val(a,b);
  }
}
