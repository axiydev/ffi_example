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
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                TextButton(
                    onPressed: () {},
                    child: Text(_ffiBridge.getTemperature().toString())),
                TextButton(
                    onPressed: () {},
                    child: Text(_ffiBridge.getTypeWeather().toString())),
              ],
            )),
      ),
    );
  }
}
