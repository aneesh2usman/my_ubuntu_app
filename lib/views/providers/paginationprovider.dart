import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// Generic Pagination Provider
abstract class PaginationProvider<T> extends ChangeNotifier {
  final int itemsPerPage;
  List<T> _items = [];
  bool _isLoading = false;
  int _currentPage = 1;
  int _totalPages = 1;
  int _count = 0;
  

  PaginationProvider({this.itemsPerPage = 15}) {
    init();
  }

  List<T> get items => _items;
  bool get isLoading => _isLoading;
  int get currentPage => _currentPage;
  int get totalPages => _totalPages;
  
  int get count => _count;

  Future<int> getTotalItemCount();
  Future<List<T>> getPaginatedItems(int page, int pageSize);
  Future<void> init() async {
    loadPage(1);
  }

  Future<void> loadPage(int page) async {
    if (_isLoading) return;

    _setLoading(true);

    try {
      _count = await getTotalItemCount();
      _totalPages = (_count / itemsPerPage).ceil();

      if (page < 1) page = 1;
      if (page > _totalPages && _totalPages > 0) page = _totalPages;

      final items = await getPaginatedItems(
        page - 1, // Assuming your database uses 0-based indexing
        itemsPerPage,
      );

      _items = items;
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
    if (_currentPage < _totalPages) {
      await loadPage(_currentPage + 1);
    }
  }

  Future<void> prevPage() async {
    if (_currentPage > 1) {
      await loadPage(_currentPage - 1);
    }
  }

  Future<void> firstPage() async {
    await loadPage(1);
  }

  Future<void> lastPage() async {
    await loadPage(_totalPages);
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}