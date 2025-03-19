import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:my_ubuntu_app/data/notifier.dart';
import 'package:my_ubuntu_app/views/widget_tree.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        // Center the content horizontally
        child: SingleChildScrollView(
            padding: const EdgeInsets.all(32.0), // More padding for desktop
            child: LayoutBuilder(
              builder: (context, BoxConstraints constraints) {
                return FractionallySizedBox(
                  widthFactor: constraints.maxWidth > 500 ? 0.3 : 0.8,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment
                        .stretch, // Stretch children horizontally within the maxWidth
                    children: [
                      Lottie.asset(
                        'assets/lottie/login.json',
                        height: 200, // Adjust height for better fit
                      ),
                      const SizedBox(height: 30),
                      TextFormField(
                        controller: _usernameController,
                        decoration: const InputDecoration(
                          labelText: 'Username',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: () {
                          String username = _usernameController.text;
                          String password = _passwordController.text;
                          print('Username: $username, Password: $password');
                          if (username.isNotEmpty && password.isNotEmpty) {
                            selectedPageNotifier.value = 0;
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const WidgetTree()),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content:
                                    Text('Please enter username and password.'),
                              ),
                            );
                          }
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(
                              12.0), // Add padding to the button text
                          child: Text(
                            'Login',
                            style: TextStyle(
                                fontSize: 16), // Adjust button text size
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            )),
      ),
    );
  }
}
