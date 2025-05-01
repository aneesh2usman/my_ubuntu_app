import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:my_ubuntu_app/data/db/app_database.dart';
import 'package:my_ubuntu_app/data/db/models/user_models.dart';

class InfiniteScrollPaginationView2 extends StatefulWidget {
  const InfiniteScrollPaginationView2({super.key});

  @override
  State<InfiniteScrollPaginationView2> createState() =>
      _InfiniteScrollPaginationView2State();
}

class _InfiniteScrollPaginationView2State
    extends State<InfiniteScrollPaginationView2> {
  final AppDatabase _database = AppDatabase();
  Map<String, String>? _filters;
  final int _pageSize = 9;
  bool _isRefreshing = false;
  
  final PagingController<int, UserWithRolesModel> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await _database.userDao.getPaginatedUsers(
        page: pageKey,
        pageSize: _pageSize,
        filters: _filters,
      );

      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  Future<void> _refreshData() async {
    setState(() {
      _isRefreshing = true;
    });
    
    try {
      await Future.sync(() => _pagingController.refresh());
    } finally {
      if (mounted) {
        setState(() {
          _isRefreshing = false;
        });
      }
    }
  }

  void _applyFilters(Map<String, String> newFilters) {
    setState(() {
      _filters = newFilters;
      _pagingController.refresh();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Advanced Pagination'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => _showFilterDialog(),
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _refreshData,
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: PagedListView<int, UserWithRolesModel>.separated(
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate<UserWithRolesModel>(
            itemBuilder: (context, user, index) => Card(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
              child: ListTile(
                leading: CircleAvatar(
                  child: Text(user.username?[0].toUpperCase() ?? '?'),
                ),
                title: Text(user.username ?? 'No username'),
                subtitle: Text(
                  user.roles.isNotEmpty
                      ? user.roles.map((role) => role.name).join(', ')
                      : 'No roles',
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.info_outline),
                  onPressed: () => _showUserDetails(user),
                ),
              ),
            ),
            firstPageProgressIndicatorBuilder: (context) => const Center(
              child: Padding(
                padding: EdgeInsets.all(32.0),
                child: CircularProgressIndicator(),
              ),
            ),
            firstPageErrorIndicatorBuilder: (context) => ErrorWidget(
              onRetry: () => _pagingController.refresh(),
              error: _pagingController.error,
            ),
            noItemsFoundIndicatorBuilder: (context) => const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.person_off, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text('No users found'),
                ],
              ),
            ),
            newPageProgressIndicatorBuilder: (context) => const Padding(
              padding: EdgeInsets.all(16),
              child: Center(child: CircularProgressIndicator()),
            ),
            newPageErrorIndicatorBuilder: (context) => Padding(
              padding: const EdgeInsets.all(16),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Error loading more items'),
                    ElevatedButton(
                      onPressed: () => _pagingController.retryLastFailedRequest(),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            ),
          ),
          separatorBuilder: (context, index) => const Divider(height: 1),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _refreshData,
        child: Icon(_isRefreshing ? Icons.refresh : Icons.refresh),
      ),
    );
  }

  void _showFilterDialog() {
    final nameController = TextEditingController(text: _filters?['name']);
    final roleController = TextEditingController(text: _filters?['role']);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Filter Users'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: roleController,
              decoration: const InputDecoration(labelText: 'Role'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _applyFilters({});
            },
            child: const Text('CLEAR'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('CANCEL'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              final newFilters = <String, String>{};
              if (nameController.text.isNotEmpty) {
                newFilters['name'] = nameController.text;
              }
              if (roleController.text.isNotEmpty) {
                newFilters['role'] = roleController.text;
              }
              _applyFilters(newFilters);
            },
            child: const Text('APPLY'),
          ),
        ],
      ),
    );
  }

  void _showUserDetails(UserWithRolesModel user) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.5,
        minChildSize: 0.3,
        maxChildSize: 0.9,
        expand: false,
        builder: (context, scrollController) => SingleChildScrollView(
          controller: scrollController,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Container(
                    width: 60,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: const EdgeInsets.only(bottom: 20),
                  ),
                ),
                Center(
                  child: CircleAvatar(
                    radius: 40,
                    child: Text(
                      user.username?[0].toUpperCase() ?? '?',
                      style: const TextStyle(fontSize: 32),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                ListTile(
                  title: const Text('Username'),
                  subtitle: Text(user.username ?? 'No username'),
                ),
                ListTile(
                  title: const Text('Roles'),
                  subtitle: Text(
                    user.roles.isNotEmpty
                        ? user.roles.map((role) => role.name).join(', ')
                        : 'No roles',
                  ),
                ),
                // Add additional user details here
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ErrorWidget extends StatelessWidget {
  final Function onRetry;
  final dynamic error;

  const ErrorWidget({
    super.key,
    required this.onRetry,
    required this.error,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 64, color: Colors.red),
          const SizedBox(height: 16),
          Text('Something went wrong: ${error.toString()}'),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => onRetry(),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}