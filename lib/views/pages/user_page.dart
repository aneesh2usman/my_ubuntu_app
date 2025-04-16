import 'package:flutter/material.dart';
import 'package:my_ubuntu_app/views/providers/userlistprovider.dart';
import 'package:my_ubuntu_app/widgets/users/add_user_popup.dart';
import 'package:my_ubuntu_app/widgets/users/edit_user_popup.dart';
import 'package:provider/provider.dart';

class UserListPaginationwithProvider extends StatelessWidget {
  const UserListPaginationwithProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserListProvider(),
      child: _UserListPaginationConsumer(),
    );
  }
}

class _UserListPaginationConsumer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserListProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
        // actions: [
        //   IconButton(
        //     icon: const Icon(Icons.refresh),
        //     onPressed: userProvider.reloadCurrentPage,
        //     tooltip: 'Refresh',
        //   ),
        // ],
      ),
      body: Column(
        children: [
          if (userProvider.isLoading)
            const LinearProgressIndicator(minHeight: 4),
          Expanded(
            child: userProvider.items.isEmpty
                ? const Center(child: Text('No users found'))
                : ListView.separated( // Using ListView.separated for dividers
                    itemCount: userProvider.items.length,
                    separatorBuilder: (context, index) => const Divider(
                      height: 1,
                      color: Colors.grey,
                    ),
                    itemBuilder: (context, index) {
                      final item = userProvider.items[index];
                      return Container(
                        decoration: BoxDecoration(
                          color: index % 2 == 0 ? Colors.grey[100] : Colors.white, // Subtle alternating row colors
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2, // Adjust flex values for column widths
                                child: Text(
                                  item.username ?? 'No Username',
                                  style: const TextStyle(fontWeight: FontWeight.w500),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Text(
                                  item.roles.map((a) => a.name).join(", "),
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                              ),
                              const SizedBox(width: 16),
                              PopupMenuButton<String>(
                                icon: const Icon(Icons.more_vert), // More intuitive icon
                                onSelected: (value) {
                                  if (value == 'delete') {
                                    userProvider.deleteUser(item.id!);
                                  } else if (value == 'edit') {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return EditUserPopup(context, userProvider, index);
                                      },
                                    );
                                  }
                                },
                                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                                  const PopupMenuItem<String>(
                                    value: 'edit',
                                    child: Row(
                                      children: [
                                        Icon(Icons.edit, color: Colors.blue),
                                        SizedBox(width: 8),
                                        Text('Edit'),
                                      ],
                                    ),
                                  ),
                                  const PopupMenuItem<String>(
                                    value: 'delete',
                                    child: Row(
                                      children: [
                                        Icon(Icons.delete, color: Colors.redAccent),
                                        SizedBox(width: 8),
                                        Text('Delete'),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    'Total: ${userProvider.count} users'),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.first_page),
                      onPressed: userProvider.currentPage > 1
                          ? userProvider.firstPage
                          : null,
                      tooltip: 'First page',
                    ),
                    IconButton(
                      icon: const Icon(Icons.chevron_left),
                      onPressed: userProvider.currentPage > 1
                          ? userProvider.prevPage
                          : null,
                      tooltip: 'Previous page',
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                          'Page ${userProvider.currentPage} of ${userProvider.totalPages}'),
                    ),
                    IconButton(
                      icon: const Icon(Icons.chevron_right),
                      onPressed:
                          userProvider.currentPage < userProvider.totalPages
                              ? userProvider.nextPage
                              : null,
                      tooltip: 'Next page',
                    ),
                    IconButton(
                      icon: const Icon(Icons.last_page),
                      onPressed:
                          userProvider.currentPage < userProvider.totalPages
                              ? userProvider.lastPage
                              : null,
                      tooltip: 'Last page',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AddUserPopup(context, userProvider);
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}



