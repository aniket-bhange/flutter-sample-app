import 'package:flutter/widgets.dart';
import 'package:nutritionapp/Auth/RegisterUserScreen.dart';
import 'package:nutritionapp/Home/FoodDetail.dart';
import 'package:nutritionapp/Home/HomeScreen.dart';
import 'package:flutter/material.dart';

class Routes {
  final routes = <String, WidgetBuilder>{
    '/home': (context)=> HomeScreen(),
    '/food-details': (context)=> FoodDetailScreen(ModalRoute.of(context).settings.arguments),
    '/register': (context)=> RegisteruserScreen()
  };
  Routes();
}