import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:my_ubuntu_app/data/dataclass/course_dataclass.dart';

class CoursePage extends StatefulWidget {
  const CoursePage({super.key});

  @override
  State<CoursePage> createState() => _CoursePageState();
}

Future<Course?> getCourse() async {
  try {
    var url = Uri.https('secrets-api.appbrewery.com', 'random');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      // return jsonDecode(response.body);
      Course course = Course.fromJson(jsonDecode(response.body));
      return course;
    } else {
      print('Failed to load course. Status code: ${response.statusCode}');
      return null; // Return an empty map on failure
    }
  } catch (e) {
    print('Error fetching course: $e');
    return null; // Return an empty map on error
  }
}

class _CoursePageState extends State<CoursePage> {
  Future<Course?>? _coursedata;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _coursedata = getCourse();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Course Page'),
      ),
      body: FutureBuilder<Course?>(
        future: _coursedata,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(
              strokeWidth: 10.0,
            ));
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            return courseDetail(snapshot);
          } else {
            return const Center(child: Text('No data found'));
          }
        },
      ),
    );
  }

  Widget courseDetail(snapshot) {
    Course course = snapshot.data!;
    return SingleChildScrollView(
      // Allow scrolling
      child: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start, // Align text to the left
          children: <Widget>[
            _buildDetailRow('ID', course.id.toString()),
            _buildDetailRow('Secret', course.secret),
            _buildDetailRow('EM Score', course.emScore.toString()),
            _buildDetailRow('Username', course.username),
            _buildDetailRow('Timestamp', course.timestamp.toString()),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    _coursedata = getCourse();
                  });
                },
                child: Text("Refresh"))
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: ',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 800),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
              child: Text(
                value,
                key: ValueKey<String>(value), // Important for animation
              ),
            ),
          ),
        ],
      ),
    );
  }
}
