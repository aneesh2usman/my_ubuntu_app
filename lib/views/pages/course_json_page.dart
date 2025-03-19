import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CoursePage extends StatefulWidget {
  const CoursePage({super.key});

  @override
  State<CoursePage> createState() => _CoursePageState();
}

Future<Map<String, dynamic>> getCourse() async {
  try {
    var url = Uri.https('secrets-api.appbrewery.com', 'random');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      return jsonDecode(response.body);
    } else {
      print('Failed to load course. Status code: ${response.statusCode}');
      return {}; // Return an empty map on failure
    }
  } catch (e) {
    print('Error fetching course: $e');
    return {}; // Return an empty map on error
  }
}

class _CoursePageState extends State<CoursePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Course Page'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: getCourse(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            final data = snapshot.data!;
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Username: ${data['username'] ?? 'N/A'}'),
                  // Add more fields as needed
                ],
              ),
            );
          } else {
            return const Center(child: Text('No data found.'));
          }
        },
      ),
    );
  }
}