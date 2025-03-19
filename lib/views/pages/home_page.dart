import 'package:flutter/material.dart';
import 'package:my_ubuntu_app/views/widgets/container_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true, // Important for using ListView inside a Column
              physics: const NeverScrollableScrollPhysics(), // Disable ListView's scrolling
              itemCount: 10,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    TitleDescriptionCard(
                      title: 'Card Title  $index',
                      description: 'This is the description for the card. $index',
                    ),
                    if (index < 9) const SizedBox(height: 16.0),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}