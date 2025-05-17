import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'firebase_options.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    await Hive.initFlutter();
    await Hive.openBox('favoritesBox');

    runApp(const MyApp());
  } catch (e) {
    runApp(ErrorApp(errorMessage: 'Initialization error: $e'));
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
            backgroundColor: Color(0xFF3A7CA5),
            foregroundColor: Colors.white,
          ),
        ),
      ),
      home: const AuthWrapper(),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final user = snapshot.data;
          if (user == null) {
            return const LoginScreen();
          } else {
            return const HomeScreen();
          }
        }
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}

class ErrorApp extends StatelessWidget {
  final String errorMessage;

  const ErrorApp({super.key, required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Application Error')),
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
