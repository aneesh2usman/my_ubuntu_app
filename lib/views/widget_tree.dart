import 'package:flutter/material.dart';
import 'package:my_ubuntu_app/data/notifier.dart';
import 'package:my_ubuntu_app/views/pages/home_page.dart';
import 'package:my_ubuntu_app/views/pages/login_page.dart';
import 'package:my_ubuntu_app/views/pages/profile_page.dart';
import 'package:my_ubuntu_app/views/pages/settings_page.dart';

import 'widgets/navbar_widget.dart';

List<Widget> pages = [
  HomePage(),
  ProfilePage(),
];

class WidgetTree extends StatelessWidget {
  const WidgetTree({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("flutter"),
          centerTitle: true,
          backgroundColor: Colors.teal,
          actions: [
            IconButton(
                onPressed: () {
                  isDarkModeNotifier.value = !isDarkModeNotifier.value;
                },
                icon: ValueListenableBuilder(
                  valueListenable: isDarkModeNotifier,
                  builder: (context, value, child) {
                    return Icon(isDarkModeNotifier.value
                        ? Icons.dark_mode
                        : Icons.light_mode);
                  },
                )),
            IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return SettingsPage(title: "Settings",);
                    },
                  ));
                },
                icon: Icon(Icons.settings)),  
                IconButton(
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context) {
                      return LoginPage();
                    },
                  ));
                },
                icon: Icon(Icons.logout)),
          ]),
      body: ValueListenableBuilder(
        valueListenable: selectedPageNotifier,
        builder: (context, selectedPage, child) {
          return pages.elementAt(selectedPage);
        },
      ),
      bottomNavigationBar: NavbarWidget(),
    );
  }
}
