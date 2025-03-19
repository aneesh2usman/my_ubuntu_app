import 'package:flutter/material.dart';
import 'package:my_ubuntu_app/views/pages/course_page.dart';

class TitleDescriptionCard extends StatelessWidget {
  final String title;
  final String? description;
  final Widget? child; // Optional widget below title and description

  const TitleDescriptionCard({
    super.key,
    required this.title,
    this.description,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextStyle defaultTitleStyle = const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold);

    final TextStyle defaultDescriptionStyle = const TextStyle(fontSize: 14.0);

    return Container(
      width: double.infinity,
      child: Card(
        
        margin: const EdgeInsets.all(8.0), // Default margin
        color: theme.cardColor, // Default card color from theme
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)), // Default shape
        clipBehavior: Clip.antiAlias, // Default clip behavior
        child: InkWell(
          onTap: () {
            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const CoursePage()),
                            );
          },
          child: Padding(
            
            padding: const EdgeInsets.all(16.0), // Default padding
            child: Column(
              mainAxisSize: MainAxisSize.min,
              
              
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                  Text(
                    title,
                    style: defaultTitleStyle,
                    
                  ),
                  if (description != null && description!.isNotEmpty) ...[
                    const SizedBox(height: 8.0),
                    Text(
                      description!,
                      style: defaultDescriptionStyle,
                    ),
                  ],
                  if (child != null) ...[
                    const SizedBox(height: 16.0),
                    child!,
                  ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}