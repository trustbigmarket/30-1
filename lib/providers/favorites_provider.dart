import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/dhikr.dart';

class FavoritesProvider with ChangeNotifier {
  final Set<Dhikr> _favorites = {};
  static const String _prefsKey = 'favorites';

  Set<Dhikr> get favorites => _favorites;

  FavoritesProvider() {
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favoritesJson = prefs.getStringList(_prefsKey) ?? [];
    
    _favorites.clear();
    for (var json in favoritesJson) {
      _favorites.add(Dhikr.fromJson(jsonDecode(json)));
    }
    notifyListeners();
  }

  Future<void> _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favoritesJson = _favorites.map((dhikr) => 
      jsonEncode(dhikr.toJson())
    ).toList();
    
    await prefs.setStringList(_prefsKey, favoritesJson);
  }

  void toggleFavorite(Dhikr dhikr) {
    if (_favorites.contains(dhikr)) {
      _favorites.remove(dhikr);
    } else {
      _favorites.add(dhikr);
    }
    _saveFavorites();
    notifyListeners();
  }

  bool isFavorite(Dhikr dhikr) {
    return _favorites.contains(dhikr);
  }
}
