import 'dart:ffi';

typedef TempFor = ThreeDaysForecast Function(Uint8 useSeclius);
typedef TempForOtherDart = ThreeDaysForecast Function(int useSelcius);

class ThreeDaysForecast extends Struct {
  @Double()
  external double get getDayBefore;

  external set setDayBefore(double value);

  @Double()
  external double get getTuday;

  external set setToday(double value);

  @Double()
  external double get getTomorrow;

  external set setTomorrow(double value);

  @override
  String toStringTemp() => 'Today : ${getDayBefore.toStringAsFixed(1)}\n'
      'Tomorrow : ${getTuday.toStringAsFixed(1)}\n'
      'Day After ${getTomorrow.toStringAsFixed(1)}';
}
