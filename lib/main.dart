import 'package:flutter/material.dart';
import 'homepage.dart'; // Import the homepage.dart file

void main() => runApp(TodoApp());

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To-Do List App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: TextTheme(
          bodyLarge: TextStyle(fontFamily: 'Roboto'),
        ),
      ),
      home: TodoHomePage(), // Use the TodoHomePage widget here
    );
  }
}