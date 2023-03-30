import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:noticeboard/screens/Base.dart';
import 'package:nepali_utils/nepali_utils.dart';
import 'package:go_router/go_router.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:noticeboard/screens/Slider.dart';
import 'package:noticeboard/screens/home.dart';

void main() {
  NepaliUtils(Language.nepali);
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const SplashScreen();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'base',
          builder: (BuildContext context, GoRouterState state) {
            return const Base();
          },
        ),
      ],
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // ignore: prefer_const_constructors

  late StreamSubscription subscription;
  bool isDeviceConnected = false;

  bool _hasconnection = false;
  bool _dialogshowing = false;

  get loading => SpinKitCubeGrid(
        color: Colors.blue,
        size: 30,
      );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getConnectivity();
  }

  getConnectivity() async {
    isDeviceConnected = await InternetConnectionChecker().hasConnection;
    if (!isDeviceConnected) {
      print(isDeviceConnected);
      Timer.periodic(Duration(seconds: 2), (timer) {
        getConnectivity();

        if (isDeviceConnected) {
          timer.cancel();
        }
      });
      setState(() {
        _hasconnection = false;
      });
    } else {
      setState(() {
        _hasconnection = true;
        print(_hasconnection);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const HomeScreen()));
      });
    }
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Material(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Image.asset('assets/images/new_logo.png'),
              ),
              loading,
              // ignore: prefer_const_constructors
              SizedBox(height: 20),
              Text('Loading..'),
              if (_hasconnection == false)
                Column(
                  // ignore: prefer_const_literals_to_create_immutables
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      width: 500,
                      height: 150,
                      margin: EdgeInsets.all(10),
                      child: Container(
                        color: Color.fromARGB(255, 243, 243, 243),
                        child: Row(
                          children: [
                            Image.asset('assets/images/splash_screen.gif'),
                            SizedBox(width: 20),
                            Text(
                              'No internet!!',
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                )
            ]),
      ),
    );
  }
}
