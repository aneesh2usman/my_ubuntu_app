import 'dart:async';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:my_ubuntu_app/data/db/app_database.dart';
import 'package:my_ubuntu_app/data/db/models/user_models.dart';

class InfiniteScrollPaginationView3 extends StatefulWidget {
  const InfiniteScrollPaginationView3({super.key});

  @override
  State<InfiniteScrollPaginationView3> createState() =>
      _InfiniteScrollPaginationView3State();
}

class _InfiniteScrollPaginationView3State
    extends State<InfiniteScrollPaginationView3> {
  final AppDatabase _database = AppDatabase();
  Map<String, String>? _filters;
  final int _pageSize = 9;
  bool _isRefreshing = false;
  
  // Create separate controller for refresh and pagination
  final ScrollController _scrollController = ScrollController();
  final PagingController<int, UserWithRolesModel> _pagingController =
      PagingController(firstPageKey: 0);
  
  // Refresh indicator key
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = 
      GlobalKey<RefreshIndicatorState>();

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
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      await Future.delayed(const Duration(seconds: 2));
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

  // Complete page refresh that resets everything
  Future<void> _refreshEntirePage() async {
    if (_isRefreshing) return;
    
    setState(() {
      _isRefreshing = true;
    });
    
    try {
      // Reset pagination controller and reload from the beginning
      _pagingController.refresh();
      
      // Simulate a full page refresh with a short delay
      await Future.delayed(const Duration(milliseconds: 500));
    } finally {
      if (mounted) {
        setState(() {
          _isRefreshing = false;
        });
      }
    }
    
    // Show a snackbar to confirm refresh
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Page refreshed'),
          duration: Duration(seconds: 1),
        ),
      );
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
        title: const Text('Ubuntu Users List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => _showFilterDialog(),
          ),
          IconButton(
            icon: _isRefreshing 
              ? const SizedBox(
                  width: 24, 
                  height: 24, 
                  child: CircularProgressIndicator(
                    strokeWidth: 2.0,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : const Icon(Icons.refresh),
            onPressed: _isRefreshing ? null : () {
              _refreshIndicatorKey.currentState?.show();
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          // Use RefreshIndicator as the outermost wrapper
          RefreshIndicator(
            key: _refreshIndicatorKey,
            onRefresh: _refreshEntirePage,
            // Use a displacement value that works well on Ubuntu
            displacement: 40.0,
            // Increase the refresh trigger threshold for desktop
            edgeOffset: 20.0,
            // Add a stronger visual feedback appropriate for Ubuntu
            strokeWidth: 3.0,
            child: _buildListView(),
          ),
          // Add refresh overlay if needed
          if (_isRefreshing)
            const Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: LinearProgressIndicator(),
            ),
        ],
      ),
    );
  }

  Widget _buildListView() {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification notification) {
        // Add additional scroll handling if needed
        return false;
      },
      child: CustomScrollView(
        controller: _scrollController,
        // Use physics that works well on Ubuntu
        physics: const AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        slivers: [
          // Add extra padding at the top to make pull-to-refresh more obvious
          const SliverToBoxAdapter(
            child: SizedBox(height: 10),
          ),
          // Use PagedSliverList
          PagedSliverList<int, UserWithRolesModel>(
            pagingController: _pagingController,
            builderDelegate: PagedChildBuilderDelegate<UserWithRolesModel>(
              itemBuilder: (context, user, index) => Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: Colors.white,
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
              firstPageErrorIndicatorBuilder: (context) => Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error_outline, size: 64, color: Colors.red),
                      const SizedBox(height: 16),
                      Text('Error: ${_pagingController.error}'),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () => _pagingController.refresh(),
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                ),
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
          ),
          // Add padding at the bottom
          const SliverToBoxAdapter(
            child: SizedBox(height: 20),
          ),
        ],
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
      builder: (context) => Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
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
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
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
          ],
        ),
      ),
    );
  }
}

// Optional - a more complete refresh indicator for Ubuntu
class UbuntuPullToRefreshIndicator extends StatelessWidget {
  final Widget child;
  final Future<void> Function() onRefresh;

  const UbuntuPullToRefreshIndicator({
    super.key,
    required this.child,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      // These parameters work better on Ubuntu
      displacement: 50.0,
      edgeOffset: 20.0,
      strokeWidth: 3.0,
      backgroundColor: Theme.of(context).colorScheme.surface,
      color: Theme.of(context).colorScheme.primary,
      child: child,
    );
  }
}