import 'package:flutter/material.dart';
import 'package:simple_calculator/codes/Animation.dart';
import 'package:simple_calculator/codes/Calender.dart';
import 'package:simple_calculator/codes/Form.dart';
import 'package:simple_calculator/codes/Layouts.dart';
import 'package:simple_calculator/codes/Quiz.dart';
import 'package:simple_calculator/codes/TemperatureConverter.dart';
import 'package:simple_calculator/codes/SimpleCalculator.dart';
import 'package:simple_calculator/codes/TodoList.dart';
import 'package:simple_calculator/codes/TodoListMongoDB.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Simple Calculator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}