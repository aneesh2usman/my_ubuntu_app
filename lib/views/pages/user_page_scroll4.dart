import 'dart:async';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:my_ubuntu_app/data/db/app_database.dart';
import 'package:my_ubuntu_app/data/db/models/user_models.dart';

class InfiniteScrollPaginationView4 extends StatefulWidget {
  const InfiniteScrollPaginationView4({super.key});

  @override
  State<InfiniteScrollPaginationView4> createState() =>
      _InfiniteScrollPaginationView4State();
}

class _InfiniteScrollPaginationView4State
    extends State<InfiniteScrollPaginationView4> with SingleTickerProviderStateMixin {
  final AppDatabase _database = AppDatabase();
  Map<String, String>? _filters;
  final int _pageSize = 9;
  bool _isRefreshing = false;
  
  // Create controller for pagination
  final PagingController<int, UserWithRolesModel> _pagingController =
      PagingController(firstPageKey: 0);
  
  // Custom scroll controller to detect overscrolls
  late ScrollController _scrollController;
  
  // Animation controller for refresh indicator
  late AnimationController _refreshAnimationController;
  
  // Track if we're currently overscrolling and by how much
  bool _isOverscrolling = false;
  double _overscrollAmount = 0.0;
  
  // Refresh threshold
  final double _refreshThreshold = 100.0;

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    
    // Initialize scroll controller
    _scrollController = ScrollController()
      ..addListener(_handleScrollUpdate);
    
    // Initialize animation controller for refresh indicator
    _refreshAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    _scrollController.dispose();
    _refreshAnimationController.dispose();
    super.dispose();
  }

  void _handleScrollUpdate() {
    // Detect overscroll at the top
    if (_scrollController.position.pixels < 0) {
      if (!_isOverscrolling) {
        setState(() {
          _isOverscrolling = true;
        });
      }
      setState(() {
        _overscrollAmount = -_scrollController.position.pixels;
      });
      
      // If overscroll passes threshold, trigger refresh
      if (_overscrollAmount >= _refreshThreshold && !_isRefreshing) {
        _refreshContent();
      }
    } else if (_isOverscrolling) {
      setState(() {
        _isOverscrolling = false;
        _overscrollAmount = 0.0;
      });
    }
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

  // Custom refresh function that works with mouse drag
  Future<void> _refreshContent() async {
    if (_isRefreshing) return;
    
    setState(() {
      _isRefreshing = true;
    });
    
    // Start refresh animation
    _refreshAnimationController.forward();
    
    try {
      // Reset pagination controller and reload from the beginning
      _pagingController.refresh();
      
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 1500));
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Page refreshed'),
            duration: Duration(seconds: 1),
          ),
        );
      }
    } catch (error) {
      // Handle error
    } finally {
      if (mounted) {
        setState(() {
          _isRefreshing = false;
          _isOverscrolling = false;
          _overscrollAmount = 0.0;
        });
        // Reset animation
        _refreshAnimationController.reset();
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
            onPressed: _isRefreshing ? null : _refreshContent,
          ),
        ],
      ),
      body: Stack(
        children: [
          _buildCustomScrollableList(),
          
          // Custom Ubuntu-style refresh indicator
          if (_isOverscrolling || _isRefreshing)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: _buildCustomRefreshIndicator(),
            ),
          
          // Linear progress indicator during refresh
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

  Widget _buildCustomRefreshIndicator() {
    // Show progress as percentage of the refresh threshold
    final progress = (_overscrollAmount / _refreshThreshold).clamp(0.0, 1.0);
    
    return Container(
      height: _isRefreshing ? 60.0 : _overscrollAmount.clamp(0.0, 80.0),
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Center(
        child: _isRefreshing
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.0,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    'Refreshing...',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              )
            : Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      value: progress,
                      strokeWidth: 2.0,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  if (progress >= 1.0)
                    const Icon(
                      Icons.arrow_upward,
                      size: 14,
                    ),
                ],
              ),
      ),
    );
  }

  Widget _buildCustomScrollableList() {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification notification) {
        // Additional logic for scroll notifications could be added here
        return false;
      },
      child: PagedListView<int, UserWithRolesModel>(
        pagingController: _pagingController,
        scrollController: _scrollController,
        // This physics setting is crucial for mouse drag to work on Ubuntu
        physics: const AlwaysScrollableScrollPhysics(
          parent: ClampingScrollPhysics(),
        ),
        padding: const EdgeInsets.all(8.0),
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