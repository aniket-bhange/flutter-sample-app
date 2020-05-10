
import 'package:flutter/material.dart';
import 'package:nutritionapp/Auth/LoginScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:nutritionapp/Shared/Routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final Routes _routes = new Routes();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getPrefs(),
      builder: (BuildContext context, AsyncSnapshot<bool> prefs){
        if (prefs.hasData && prefs.data){
          return MyHomePage();
        }
        return new MediaQuery(
          data: new MediaQueryData(),
          child: new MaterialApp(home: new LoginScreen(), debugShowCheckedModeBanner: false, routes: _routes.routes,)
        );
      }
    );
  }

  Future<bool> _getPrefs() async{
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    var userToken = sharedPrefs.getString('usertoken');
    return userToken is String;
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  Routes _routes = new Routes();
  
  @override
  Widget build(BuildContext context) {
    String initRoute = '/home';
    return MaterialApp(
      initialRoute: initRoute,
      debugShowCheckedModeBanner: false,
      routes: _routes.routes,
    );
  }
}
