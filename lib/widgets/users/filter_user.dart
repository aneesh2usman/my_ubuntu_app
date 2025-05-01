import 'package:flutter/material.dart';
import 'package:my_ubuntu_app/views/providers/userlistprovider.dart';

Widget UserListFilter({
  Key? key,
  required UserListProvider userProvider,
  required TextEditingController usernameFilterController,
  required TextEditingController emailFilterController,
  required TextEditingController firstNameFilterController,
  required TextEditingController lastNameFilterController,
  required TextEditingController phoneFilterController,
  required Function(UserListProvider) applyFilters,
}) {
  return ExpansionTile(
    title: const Text('Filter Users'),
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: usernameFilterController,
              decoration: const InputDecoration(
                labelText: 'Filter by Username',
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(),
              ),
              // onChanged: (_) => applyFilters(userProvider),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: emailFilterController,
              decoration: const InputDecoration(
                labelText: 'Filter by Email',
                prefixIcon: Icon(Icons.email),
                border: OutlineInputBorder(),
              ),
              // onChanged: (_) => applyFilters(userProvider),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: firstNameFilterController,
                    decoration: const InputDecoration(
                      labelText: 'Filter by First Name',
                      prefixIcon: Icon(Icons.account_circle),
                      border: OutlineInputBorder(),
                    ),
                    // onChanged: (_) => applyFilters(userProvider),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: lastNameFilterController,
                    decoration: const InputDecoration(
                      labelText: 'Filter by Last Name',
                      prefixIcon: Icon(Icons.account_circle_outlined),
                      border: OutlineInputBorder(),
                    ),
                    // onChanged: (_) => applyFilters(userProvider),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            TextField(
              controller: phoneFilterController,
              decoration: const InputDecoration(
                labelText: 'Filter by Phone Number',
                prefixIcon: Icon(Icons.phone),
                border: OutlineInputBorder(),
              ),
              // onChanged: (_) => applyFilters(userProvider),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    
                    applyFilters(userProvider);
                  },
                  child: const Text('Search'),
                ),
                ElevatedButton(
                  onPressed: () {
                    usernameFilterController.clear();
                    emailFilterController.clear();
                    firstNameFilterController.clear();
                    lastNameFilterController.clear();
                    phoneFilterController.clear();
                    applyFilters(userProvider);
                  },
                  child: const Text('Clear Filters'),
                ),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}
