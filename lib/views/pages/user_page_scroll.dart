import 'package:flutter/material.dart';
import 'package:my_ubuntu_app/data/db/app_database.dart';
import 'package:my_ubuntu_app/data/db/models/user_models.dart';

class InfiniteScrollPaginationView extends StatefulWidget {
  const InfiniteScrollPaginationView({super.key});

  @override
  State<InfiniteScrollPaginationView> createState() =>
      _InfiniteScrollPaginationViewState();
}

class _InfiniteScrollPaginationViewState
    extends State<InfiniteScrollPaginationView> {
  final _scrollController = ScrollController();
  final AppDatabase _database = AppDatabase();
  Map<String, String>? _filters;
  List<UserWithRolesModel> _items = [];
  int _currentPage = 0;
  bool _isLoading = false;
  bool _hasMore = true;
  final int _pageSize = 9;
  bool _isFirstLoad = true;

  @override
  void initState() {
    super.initState();
    _loadInitialData();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  // Separate scroll listener from data loading logic
  void _onScroll() {
    if (!_isLoading &&
        _hasMore &&
        _scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200) {
      _loadMore();
    }
  }

  Future<void> _loadInitialData() async {
    if (mounted) {
      setState(() {
        _isLoading = true;
        _isFirstLoad = true;
        _currentPage = 0;
        _items = [];
        _hasMore = true;
      });
    }

    try {
      final initialItems = await _database.userDao.getPaginatedUsers(
        page: _currentPage,
        pageSize: _pageSize,
        filters: _filters,
      );

      if (mounted) {
        setState(() {
          _items = initialItems;
          _isLoading = false;
          _isFirstLoad = false;
          _hasMore = initialItems.length >= _pageSize;
        });
      }
    } catch (e) {
      print("Error fetching initial data: $e");
      if (mounted) {
        setState(() {
          _isLoading = false;
          _isFirstLoad = false;
          _hasMore = false;
        });
      }
    }
  }

  Future<void> _loadMore() async {
    if (_isLoading || !_hasMore) return;

    if (mounted) {
      setState(() {
        _isLoading = true;
      });
    }

    try {
      // Introduce a 2-second delay
      await Future.delayed(const Duration(seconds: 2));
      final nextPage = _currentPage + 1;
      final newItems = await _database.userDao.getPaginatedUsers(
        page: nextPage,
        pageSize: _pageSize,
        filters: _filters,
      );

      if (mounted) {
        setState(() {
          if (newItems.isNotEmpty) {
            _items.addAll(newItems);
            _currentPage = nextPage;
            _hasMore = newItems.length >= _pageSize;
          } else {
            _hasMore = false;
          }
          _isLoading = false;
        });
      }
    } catch (e) {
      print("Error fetching more data: $e");
      if (mounted) {
        setState(() {
          _isLoading = false;
          _hasMore = false;
        });
      }
    }
  }

  Future<void> refresh() async {
    setState(() {
      _currentPage = 0;
      _items = [];
      _hasMore = true;
    });
    await _loadInitialData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Infinite Scroll'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: refresh,
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: refresh,
        child: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    if (_isFirstLoad && _isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_items.isEmpty && !_isLoading) {
      return const Center(
        child: Text('No data available'),
      );
    }

    return ListView.builder(
      controller: _scrollController,
      itemCount: _items.length + (_isLoading && !_isFirstLoad ? 1 : 0),
      itemBuilder: (context, index) {
        if (index < _items.length) {
          final user = _items[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ListTile(
              title: Text(user.username ?? 'No username'),
              subtitle: Text(
                user.roles.isNotEmpty
                    ? user.roles.map((role) => role.name).join(', ')
                    : 'No roles',
              ),
            ),
          );
        } else {
          return const Padding(
            padding: EdgeInsets.all(16.0),
            child: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }
}
