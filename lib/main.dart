//import 'package:advanced_todo/totoAppui.dart';
import 'package:advance_todo_sqflite/todo_ui.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TodoAppUi()
    );
  }
}
