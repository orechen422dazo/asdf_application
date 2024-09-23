import 'package:asdf_application/example/custom_calendar.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CustomCalendar(
        initialDate: DateTime.now(), // 必須の引数を追加
      ),
    );
  }
}

