import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:native_try/other.dart';
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
    return Scaffold(
      body:Center(
         child: Text(_ffiBridge.getTemperature().toString()),
      ),
    );
  }
}



