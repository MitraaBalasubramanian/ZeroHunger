import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:zerohunger/screens/login_screen.dart';
import 'package:zerohunger/screens/signup_screen.dart';
import 'package:zerohunger/screens/dashboard.dart';
import 'package:zerohunger/screens/chat/chat_screen.dart';
import 'package:zerohunger/providers/auth_provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ZeroHunger',
        theme: ThemeData(
          primaryColor: Colors.teal,
          scaffoldBackgroundColor: Colors.white,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => LoginScreen(),
          '/signup': (context) => SignupScreen(),
          '/dashboard': (context) => DashboardScreen(),
          '/chat': (context) => ChatScreen(),
        },
      ),
    );
  }
}
