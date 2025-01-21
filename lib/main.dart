import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Znajdź Przepis',
      theme: ThemeData(
        primaryColor: const Color(0xFF16425B),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: const Color(0xFF3A7CA5),
        ),
        scaffoldBackgroundColor: const Color(0xFFD9DCD6),
        textTheme: const TextTheme(
          headline6: TextStyle(color: Color(0xFF16425B)),
          bodyText2: TextStyle(color: Color(0xFF2F6690)),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF16425B),
          foregroundColor: Colors.white,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF3A7CA5),
            foregroundColor: Colors.white,
          ),
        ),
      ),
      home: HomeScreen(),
    );
  }
}
