import 'package:flutter/material.dart';
import 'screens/search_screen.dart';

void main() {
  runApp(ZnajdzPrzepisApp());
}

class ZnajdzPrzepisApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Znajdź Przepis',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SearchScreen(),
    );
  }
}
