import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:native_try/other.dart';

///https://www.raywenderlich.com/21512310-calling-native-libraries-in-flutter-with-dart-ffi
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

final FFIBridge _ffiBridge = FFIBridge.init();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AdditionalDialogs {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
            height: size.height,
            width: size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Transform.scale(
                  scale: 1.5,
                  child: TextButton(
                      onPressed: () {},
                      child: Text(
                        _ffiBridge.getTemperature().toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 20),
                      )),
                ),
                Transform.scale(
                  scale: 1.5,
                  child: TextButton(
                      onPressed: () {},
                      child: Text(
                        _ffiBridge.getTypeWeather().toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 20),
                      )),
                ),
                Builder(
                  builder: (context) => TextButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
                            action: SnackBarAction(
                              label: 'undo',
                              onPressed: () {},
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(15)),
                            ),
                            backgroundColor: Colors.black,
                            content: Text(
                              _ffiBridge.getTemperature().toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 20),
                            )));
                      },
                      child: Text(
                        'get it',
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 25),
                      )),
                ),
                Builder(
                  builder: (context) => TextButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
                            action: SnackBarAction(
                              label: 'undo',
                              onPressed: () {},
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(15)),
                            ),
                            backgroundColor: Colors.black,
                            content: Text(
                              _ffiBridge.getAddValue(12, 23).toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 20),
                            )));
                      },
                      child: Text(
                        '12+23',
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 25),
                      )),
                ),
                Transform.scale(
                  scale: 1.5,
                  child: TextButton(
                      onPressed: () => AdditionalDialogs.showDioForFFi(context,
                          _ffiBridge.getThreeDaysForecast(true).toString()),
                      child: Text(
                        'without selcius',
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 20),
                      )),
                ),
                Transform.scale(
                  scale: 1.5,
                  child: TextButton(
                      onPressed: () => AdditionalDialogs.showDioForFFi(context,
                          _ffiBridge.getThreeDaysForecast(false).toString()),
                      child: Text(
                        'with selcius',
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 20),
                      )),
                ),
              ],
            )),
      ),
    );
  }
}

mixin AdditionalDialogs {
  static void showDioForFFi(BuildContext context, info) {
    final Size size = MediaQuery.of(context).size;
    showDialog<SimpleDialog>(
        context: context,
        builder: (context) => SimpleDialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              children: [
                SizedBox(
                  height: size.width * 0.5,
                  child: Text(
                    info!.toString(),
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                  ),
                )
              ],
            ));
  }
}
