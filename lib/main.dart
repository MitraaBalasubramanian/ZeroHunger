import 'package:flutter/material.dart';
import 'package:zerohunger/screens/login_screen.dart';
import 'package:zerohunger/screens/signup_screen.dart'; // Added SignUp screen import
import 'package:zerohunger/screens/dashboard_user.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ZeroHunger',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white, // White background
        primaryColor: Colors.teal, // Primary Teal
        colorScheme: ColorScheme.light(
          primary: Colors.teal,
          secondary: const Color(0xFFFFEAD4), // Cream color
          onPrimary: Colors.white, // Text color on primary
          onSecondary: Colors.black, // Text color on secondary
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.teal, // Teal app bar
          iconTheme: IconThemeData(color: Colors.black), // Black icons
          titleTextStyle: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.teal, // Teal buttons
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            textStyle: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginPage(),
        '/signup': (context) => const SignUpPage(), // SignUp page route
        '/user_dashboard': (context) => DashboardUser(),
      },
    );
  }
}
