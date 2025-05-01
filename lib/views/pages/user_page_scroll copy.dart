import 'package:flutter/material.dart';
import 'package:my_ubuntu_app/data/db/app_database.dart';
import 'package:my_ubuntu_app/data/db/models/user_models.dart';
import 'package:my_ubuntu_app/views/providers/userlistprovider.dart';
import 'package:my_ubuntu_app/widgets/users/add_user_popup.dart';
import 'package:my_ubuntu_app/widgets/users/edit_user_popup.dart';
import 'package:my_ubuntu_app/widgets/users/filter_user.dart';
import 'package:provider/provider.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class UserList extends StatefulWidget {
  const UserList({Key? key}) : super(key: key);

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  final AppDatabase _database = AppDatabase();
  Map<String, String>? _filters; // To hold the filter values
  static const _pageSize = 15;

  // Simplify the controller creation without relying on convenience methods
  late final _pagingController = PagingController<int, UserWithRolesModel>(
    // Calculate next page key or return null if we've reached the end
    getNextPageKey: (state) => (state.keys?.last ?? 0) + 1,
    // Fetch the page using our database method
    fetchPage: (pageKey) async {
      print("******pageKey*******$pageKey******");
      try {
        final items = await _database.userDao.getPaginatedUsers(
          page: pageKey -1,
          pageSize: _pageSize,
          filters: _filters,
        );
        print(items);
        return items;
      } catch (e) {
        print("Error fetching page: $e");
        throw e;
      }
    },
  );


  @override
  void initState() {
    super.initState();
    _pagingController.addListener(_showError);
  }

  Future<void> _showError() async {
    if (_pagingController.value.status == PagingStatus.subsequentPageError) {
      if (!mounted) return;
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Error loading users.'),
          action: SnackBarAction(
            label: 'Retry',
            onPressed: () => _pagingController.fetchNextPage(),
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("******UserList*************");
    return Column(
      children: [
       
        Expanded(
          child: RefreshIndicator(
            onRefresh: () async => _pagingController.refresh(),
            child: PagingListener(
              controller: _pagingController,
              builder: (context, state, fetchNextPage) => 
                PagedListView<int, UserWithRolesModel>.separated(
                  state: state,
                  fetchNextPage: fetchNextPage,
                  builderDelegate: PagedChildBuilderDelegate(
                    animateTransitions: true,
                    itemBuilder: (context, item, index) => ImageListTile(item: item),
                    firstPageErrorIndicatorBuilder: (context) => Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Error loading users.'),
                          ElevatedButton(
                            onPressed: () => _pagingController.refresh(),
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    ),
                    noItemsFoundIndicatorBuilder: (context) => const Center(
                      child: Text('No users found.'),
                    ),
                    noMoreItemsIndicatorBuilder: (context) => const Center(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('No more users.'),
                      ),
                    ),
                  ),
                  separatorBuilder: (context, index) => const Divider(),
                ),
            ),
          ),
        ),
      ],
    );
  }
}

class ImageListTile extends StatelessWidget {
  final UserWithRolesModel item;
  const ImageListTile({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(item.username ?? ""),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Email: ${item.email}'),
          if (item.roles.isNotEmpty)
            Text('Roles: ${item.roles.map((role) => role.name).join(", ")}'),
        ],
      ),
    );
  }
}
