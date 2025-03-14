import 'package:flutter/material.dart';
import 'package:my_ubuntu_app/data/notifier.dart';
import 'package:my_ubuntu_app/views/pages/login_page.dart';

import 'views/widget_tree.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {

    return ValueListenableBuilder(
      valueListenable: isDarkModeNotifier,
      builder: (context, isDarkMode, child) {
        return MaterialApp(
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.teal, 
              brightness: isDarkMode ? Brightness.dark : Brightness.light
              ),
            
          ),
          debugShowCheckedModeBanner: false,
          home: LoginPage(),
        );
      },
    );
  }
}
