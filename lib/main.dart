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
  final TextEditingController controller = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics:
              BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          child: Container(
              height: size.height,
              width: size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10)),
                    margin: EdgeInsets.only(left: 100, right: 100),
                    child: TextField(
                      controller: this.controller,
                      cursorColor: Colors.white,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'input number',
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                      width: 200,
                      height: 60,
                      child: CupertinoButton(
                          color: Colors.red,
                          child: Text(
                            'press',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            AdditionalDialogs.showDioForFFi(
                                context,
                                _ffiBridge
                                    .getCube(int.parse(controller.text))
                                    .toString());
                          })),
                  Transform.scale(
                    scale: 1.5,
                    child: TextButton(
                        onPressed: () {
                          AdditionalDialogs.showDioForFFi(
                            context,
                            _ffiBridge.getTemperature().toString(),
                          );
                        },
                        child: Text(
                          _ffiBridge.getTemperature().toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 20),
                        )),
                  ),
                  Transform.scale(
                    scale: 1.5,
                    child: TextButton(
                        onPressed: () {
                          AdditionalDialogs.showDioForFFi(
                            context,
                            _ffiBridge.getTypeWeather().toString(),
                          );
                        },
                        child: Text(
                          _ffiBridge.getTypeWeather().toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 20),
                        )),
                  ),
                  Builder(
                    builder: (context) => TextButton(
                        onPressed: () {
                          AdditionalDialogs.showDioForFFi(
                            context,
                            _ffiBridge.getTemperature().toString(),
                          );
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
                          AdditionalDialogs.showDioForFFi(context,
                              _ffiBridge.getAddValue(12, 23).toString());
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
                        onPressed: () => AdditionalDialogs.showDioForFFi(
                            context,
                            _ffiBridge
                                .getThreeDaysForecast(true)
                                .toStringTemp()),
                        child: Text(
                          'without Celsius',
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 20),
                        )),
                  ),
                  Transform.scale(
                    scale: 1.5,
                    child: TextButton(
                        onPressed: () => AdditionalDialogs.showDioForFFi(
                            context,
                            _ffiBridge
                                .getThreeDaysForecast(false)
                                .toStringTemp()),
                        child: Text(
                          'with Celsius',
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 20),
                        )),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}

mixin AdditionalDialogs {
  static void showDioForFFi(BuildContext context, String? info) {
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
                  child: Center(
                    child: Text(
                      info!.toString(),
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                    ),
                  ),
                )
              ],
            ));
  }
}
