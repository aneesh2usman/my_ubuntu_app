import 'package:flutter/material.dart';
import 'package:my_ubuntu_app/views/providers/userlistprovider.dart';

Widget AddUserPopup(BuildContext context, UserListProvider userProvider) {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  int? selectedRoleId;

  final formFields = [
    TextFormField(
      controller: usernameController,
      decoration: const InputDecoration(labelText: 'Username'),
      validator: (value) => value?.isEmpty == true ? 'Please enter a username' : null,
    ),
    TextFormField(
      controller: emailController,
      decoration: const InputDecoration(labelText: 'Email'),
      validator: (value) {
        if (value?.isEmpty == true) {
          return 'Please enter an email';
        }
        if (!value!.contains('@')) {
          return 'Please enter a valid email';
        }
        return null;
      },
    ),
    TextFormField(
      controller: passwordController,
      decoration: const InputDecoration(labelText: 'Password'),
      obscureText: true,
      validator: (value) => value?.isEmpty == true ? 'Please enter a password' : null,
    ),
    TextFormField(
      controller: firstNameController,
      decoration: const InputDecoration(labelText: 'First Name'),
    ),
    TextFormField(
      controller: lastNameController,
      decoration: const InputDecoration(labelText: 'Last Name'),
    ),
    TextFormField(
      controller: phoneController,
      decoration: const InputDecoration(labelText: 'Phone Number'),
    ),
    DropdownButtonFormField<int>(
      decoration: const InputDecoration(
        labelText: 'User Role',
        border: OutlineInputBorder(),
      ),
      value: selectedRoleId,
      items: userProvider.roles.map((role) => DropdownMenuItem(value: role.id, child: Text(role.name))).toList(),
      onChanged: (value) => selectedRoleId = value,
      validator: (value) => value == null ? 'Please select a user role' : null,
    ),
  ];

  return AlertDialog(
    title: const Text('Add New User'),
    content: SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      child: SingleChildScrollView(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            final isWideScreen = constraints.maxWidth > 600;
            return Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (isWideScreen)
                    Row(
                      children: [
                        Expanded(child: formFields[0]),
                        const SizedBox(width: 16),
                        Expanded(child: formFields[1]),
                      ],
                    )
                  else ...[
                    formFields[0],
                    const SizedBox(height: 16),
                    formFields[1],
                  ],
                  const SizedBox(height: 16),
                  if (isWideScreen)
                    Row(
                      children: [
                        Expanded(child: formFields[2]),
                        const SizedBox(width: 16),
                        Expanded(child: formFields[3]),
                      ],
                    )
                  else ...[
                    formFields[2],
                    const SizedBox(height: 16),
                    formFields[3],
                  ],
                  const SizedBox(height: 16),
                  if (isWideScreen)
                    Row(
                      children: [
                        Expanded(child: formFields[4]),
                        const SizedBox(width: 16),
                        Expanded(child: formFields[5]),
                      ],
                    )
                  else ...[
                    formFields[4],
                    const SizedBox(height: 16),
                    formFields[5],
                  ],
                  const SizedBox(height: 16),
                  formFields[6],
                ],
              ),
            );
          },
        ),
      ),
    ),
    actions: [
      TextButton(
        onPressed: () => Navigator.pop(context),
        child: const Text('Cancel'),
      ),
      ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            if (usernameController.text.isNotEmpty &&
                emailController.text.isNotEmpty &&
                passwordController.text.isNotEmpty &&
                selectedRoleId != null) {
              userProvider.addUser(
                username: usernameController.text,
                email: emailController.text,
                password: passwordController.text,
                firstname: firstNameController.text.isNotEmpty ? firstNameController.text : null,
                lastname: lastNameController.text.isNotEmpty ? lastNameController.text : null,
                phoneNumber: phoneController.text.isNotEmpty ? phoneController.text : null,
                roleId: selectedRoleId!,
              );
              Navigator.pop(context);
            } else {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Error'),
                    content: const Text('Please fill in all required fields.'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('OK'),
                      ),
                    ],
                  );
                },
              );
            }
          }
        },
        child: const Text('Add'),
      ),
    ],
  );
}