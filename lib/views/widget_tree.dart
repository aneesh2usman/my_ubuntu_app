import 'package:flutter/material.dart';
import 'package:my_ubuntu_app/data/constant.dart';
import 'package:my_ubuntu_app/data/notifier.dart';
import 'package:my_ubuntu_app/views/pages/home_page.dart';
import 'package:my_ubuntu_app/views/pages/login_page.dart';
import 'package:my_ubuntu_app/views/pages/profile_page.dart';
import 'package:my_ubuntu_app/views/pages/settings_page.dart';
// import 'package:my_ubuntu_app/views/pages/task_page.dart';
// import 'package:my_ubuntu_app/views/pages/task_page_with_pagination.dart';
// import 'package:my_ubuntu_app/views/pages/task_page_with_pagination_provider.dart';
import 'package:my_ubuntu_app/views/pages/user_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'widgets/navbar_widget.dart';

List<Widget> pages = [
  HomePage(),
  ProfilePage(),
  UserListPaginationwithProvider()
  // TaskListPage(),
  // TaskListPagination(),
  // TaskListPaginationwithProvider(),
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
                onPressed: () async {
                  final SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  await prefs.setBool(
                      AppConstants.themeMode, isDarkModeNotifier.value);
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
                      return SettingsPage(
                        title: "Settings",
                      );
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
