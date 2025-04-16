import 'package:flutter/material.dart';
import 'package:my_ubuntu_app/data/db/models/user_models.dart';
import 'package:my_ubuntu_app/views/providers/userlistprovider.dart';

Widget EditUserPopup(
    BuildContext context, UserListProvider userProvider, int index) {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final UserWithRolesModel item = userProvider.items[index];
  final TextEditingController usernameController =
      TextEditingController(text: item.username);
  final TextEditingController emailController =
      TextEditingController(text: item.email);
  final TextEditingController firstNameController =
      TextEditingController(text: item.firstname);
  final TextEditingController lastNameController =
      TextEditingController(text: item.lastname);
  final TextEditingController phoneController =
      TextEditingController(text: item.phoneNumber);
  int? selectedRoleId;

  if (item.roles.isNotEmpty) {
    selectedRoleId = item.roles.first?.id;
  } else {
    selectedRoleId = null;
  }

  final formFields = [
    TextFormField(
      controller: usernameController,
      decoration: const InputDecoration(labelText: 'Username'),
      enabled: false,
    ),
    TextFormField(
      controller: emailController,
      decoration: const InputDecoration(labelText: 'Email'),
      enabled: false,
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
      items: userProvider.roles.map((role) {
        return DropdownMenuItem<int>(
          value: role.id,
          child: Text(role.name),
        );
      }).toList(),
      onChanged: (value) {
        selectedRoleId = value;
      },
      validator: (value) {
        if (value == null) {
          return 'Please select a user role';
        }
        return null;
      },
    ),
  ];

  return AlertDialog(
    title: const Text('Edit User'),
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
                  else
                    formFields[0],
                  if (isWideScreen) const SizedBox(height: 16),
                  if (isWideScreen)
                    Row(
                      children: [
                        Expanded(child: formFields[2]),
                        const SizedBox(width: 16),
                        Expanded(child: formFields[3]),
                      ],
                    )
                  else ...[
                    const SizedBox(height: 16),
                    formFields[2],
                    const SizedBox(height: 16),
                    formFields[3],
                  ],
                  const SizedBox(height: 16),
                  formFields[4],
                  const SizedBox(height: 16),
                  formFields[5],
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
            if (usernameController.text.isNotEmpty && selectedRoleId != null) {
              userProvider.updateUser(
                index: index,
                userId: item.id,
                roleId: selectedRoleId!,
                firstname: firstNameController.text.isNotEmpty
                    ? firstNameController.text
                    : null,
                lastname: lastNameController.text.isNotEmpty
                    ? lastNameController.text
                    : null,
                phoneNumber: phoneController.text.isNotEmpty
                    ? phoneController.text
                    : null,
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
        child: const Text('Save'),
      ),
    ],
  );
}