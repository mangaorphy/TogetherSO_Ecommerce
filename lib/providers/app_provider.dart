import 'package:flutter/material.dart';

class AppProvider with ChangeNotifier {
  int _selectedIndex = 0;
  // ignore: prefer_final_fields
  List<String> _searchHistory = [
    "Tomatoes",
    "Fresh Eggs",
    "Organic Rice",
    "Mangoes",
  ];

  int get selectedIndex => _selectedIndex;

  List<String> get searchHistory => [..._searchHistory];

  void updateIndex(int newIndex) {
    _selectedIndex = newIndex;
    notifyListeners();
  }

  void addToSearchHistory(String term) {
    if (term.isNotEmpty && !_searchHistory.contains(term)) {
      _searchHistory.insert(0, term);
      notifyListeners();
    }
  }

  void clearSearchHistory() {
    _searchHistory.clear();
    notifyListeners();
  }

  void removeSearchTerm(String term) {
    _searchHistory.remove(term);
    notifyListeners();
  }
}