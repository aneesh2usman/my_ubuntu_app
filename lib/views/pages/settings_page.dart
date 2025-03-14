import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({
    super.key,
    required this.title,
  });
  final String title;
  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  TextEditingController nameContoller = TextEditingController();
  bool? isChecked = false;
  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Success"),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                    child: Text('Open Snack Bar')),
                Divider(),
                ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AboutDialog();
                        },
                      );
                    },
                    child: Text('Open Dialog')),
                Divider(),
                ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            content: Text('Alert Arumukan'),
                            title: Text('Alert Title'),
                            actions: [
                              FilledButton(onPressed: () {
                                Navigator.pop(context);
                              }, child: Text('Close'))
                            ],
                          );
                        },
                      );
                    },
                    child: Text('Open Alert')),
                TextField(
                  controller: nameContoller,
                  decoration: InputDecoration(border: OutlineInputBorder()),
                  onEditingComplete: () {
                    setState(() {});
                  },
                ),
                Text(nameContoller.text),
                CheckboxListTile(
                  value: isChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      isChecked = value;
                    });
                  },
                  title: Text("click me"),
                ),
                SwitchListTile(
                  value: isSwitched,
                  title: Text('Switch'),
                  onChanged: (value) {
                    setState(() {
                      isSwitched = value;
                    });
                  },
                ),
                Image.asset(
                  'assets/images/bg.jpg',
                ),
              ],
            )),
      ),
    );
  }
}
