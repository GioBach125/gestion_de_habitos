import 'package:flutter/material.dart';
import 'screens/profile_screen.dart';

void main() {
  runApp(GestionDeHabitosApp());
}

class GestionDeHabitosApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestión de Hábitos',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ProfileScreen(),
    );
  }
}
