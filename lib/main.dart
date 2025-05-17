import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Hive.initFlutter();
    await Hive.openBox('favoritesBox');
    runApp(MyApp());
  } catch (e) {
    runApp(ErrorApp(errorMessage: 'Database initialization error: $e'));
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Find the Recipe',
      theme: ThemeData(
        primaryColor: const Color(0xFF16425B),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: const Color(0xFF3A7CA5),
        ),
        scaffoldBackgroundColor: const Color(0xFFD9DCD6),
        textTheme: const TextTheme(
          titleLarge: TextStyle(color: Color(0xFF16425B)),
          bodyMedium: TextStyle(color: Color(0xFF2F6690)),
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

class ErrorApp extends StatelessWidget {
  final String errorMessage;

  const ErrorApp({Key? key, required this.errorMessage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Application error')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              errorMessage,
              style: const TextStyle(color: Colors.red, fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
