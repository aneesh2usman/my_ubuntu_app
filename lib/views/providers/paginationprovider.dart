import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// Generic Pagination Provider
abstract class PaginationProvider<T> extends ChangeNotifier {
  final int itemsPerPage;
  List<T> _items = [];
  List<T> _filteredItems = [];
  Map<String, String> filter_data = {};
  bool _isLoading = false;
  int _currentPage = 1;
  int _totalPages = 1;
  int _count = 0;
  bool _isFiltering = false;

  PaginationProvider({this.itemsPerPage = 15}) {
    init();
  }

  List<T> get items => _items;
  List<T> get filteredItems => _filteredItems;
  bool get isLoading => _isLoading;
  int get currentPage => _currentPage;
  int get totalPages => _totalPages;
  
  int get count => _count;
  bool get isFiltering => _isFiltering;
  Map<String, String> get filters => filter_data;

  Future<int> getTotalItemCount({Map<String, String>? filters});
  Future<List<T>> getPaginatedItems(int page, int pageSize, {Map<String, String>? filters});

  bool isItemMatch(T item, Map<String, String> filters);
  void filterItems(Map<String, String> filters);
  Future<void> init() async {
    loadPage(1);
  }

  Future<void> loadPage(int page) async {
    if (_isLoading) return;

    _setLoading(true);

    try {
      _count = await getTotalItemCount(filters: filter_data.isNotEmpty ? filter_data : null);
      _totalPages = (_count / itemsPerPage).ceil();

      if (page < 1) page = 1;
      if (page > _totalPages && _totalPages > 0) page = _totalPages;

      final items = await getPaginatedItems(
        page - 1, // Assuming your database uses 0-based indexing
        itemsPerPage,
        filters: filter_data.isNotEmpty ? filter_data : null,
      );

      _items = items;
      _filteredItems = filter_data.isEmpty
          ? _items
          : _items.where((item) => isItemMatch(item, filter_data)).toList();
      _currentPage = page;
    } catch (e) {
      print('Error loading items: $e');
    } finally {
      _setLoading(false);
    }
  }

   Future<void> reloadCurrentPage() async {
    await loadPage(_currentPage);
  }

  Future<void> nextPage() async {
    if (_currentPage < _totalPages && !_isFiltering) {
      await loadPage(_currentPage + 1);
    }
  }

  Future<void> prevPage() async {
    if (_currentPage > 1 && !_isFiltering) {
      await loadPage(_currentPage - 1);
    }
  }

  Future<void> firstPage() async {
    if (!_isFiltering) {
      await loadPage(1);
    }
  }

  Future<void> lastPage() async {
    if (!_isFiltering && _totalPages > 0) {
      await loadPage(_totalPages);
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void setFiltering(bool value) {
    _isFiltering = value;
    notifyListeners();
  }

  

  
}