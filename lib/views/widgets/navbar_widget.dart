import 'package:flutter/material.dart';
import 'package:my_ubuntu_app/data/notifier.dart';

class NavbarWidget extends StatelessWidget {
  const NavbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: selectedPageNotifier,
      builder: (context, selectedPage, child) {
        return NavigationBar(
          destinations: [
            NavigationDestination(icon: Icon(Icons.home), label: "Home"),
            NavigationDestination(icon: Icon(Icons.person), label: "Profile"),
            // NavigationDestination(icon: Icon(Icons.task), label: "Tasks"),
            // NavigationDestination(icon: Icon(Icons.task), label: "Tasks with pagination"),
            // NavigationDestination(icon: Icon(Icons.task), label: "Tasks with pagination provider"),
            NavigationDestination(icon: Icon(Icons.people_alt), label: "Users"),
            NavigationDestination(icon: Icon(Icons.people_alt), label: "Users scroll 1"),
            NavigationDestination(icon: Icon(Icons.people_alt), label: "Users scroll 2"),
            NavigationDestination(icon: Icon(Icons.people_alt), label: "Users scroll 3"),
            NavigationDestination(icon: Icon(Icons.people_alt), label: "Users scroll 4"),
            NavigationDestination(icon: Icon(Icons.people_alt), label: "weight"),
            NavigationDestination(icon: Icon(Icons.people_alt), label: "weight2"),
            NavigationDestination(icon: Icon(Icons.people_alt), label: "weight3"),
          ],
          onDestinationSelected: (int value) {
            selectedPageNotifier.value = value;
          },
          selectedIndex: selectedPage,
        );
      },
    );
  }
}
