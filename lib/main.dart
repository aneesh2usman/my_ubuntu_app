
import 'package:flutter/material.dart';
import 'package:my_ubuntu_app/data/constant.dart';
import 'package:my_ubuntu_app/data/db/app_database.dart';
import 'package:my_ubuntu_app/data/notifier.dart';
import 'package:my_ubuntu_app/views/pages/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';



void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final database = AppDatabase();

  debugPrint('Before ensuring database is open');
  // await database.executor.ensureOpen(); // Use 'executor.ensureOpen()' instead
  debugPrint('After ensuring database is open');
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  void initApp() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    isDarkModeNotifier.value = prefs.getBool(AppConstants.themeMode) ?? false;
  }
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
