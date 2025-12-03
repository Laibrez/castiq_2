import 'package:flutter/foundation.dart';
import '../models/portfolio_item.dart';

class PortfolioProvider extends ChangeNotifier {
  List<PortfolioItem> _items = [];
  bool _isLoading = false;

  List<PortfolioItem> get items => _items;
  bool get isLoading => _isLoading;

  Future<void> loadPortfolio(String userId) async {
    _isLoading = true;
    notifyListeners();

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));
      
      // Mock data - replace with actual API call
      _items = [];
      
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addItem(PortfolioItem item) async {
    _items.add(item);
    notifyListeners();
    
    // Simulate API call to save
    await Future.delayed(const Duration(milliseconds: 500));
  }

  Future<void> removeItem(String itemId) async {
    _items.removeWhere((item) => item.id == itemId);
    notifyListeners();
    
    // Simulate API call to delete
    await Future.delayed(const Duration(milliseconds: 500));
  }
}
