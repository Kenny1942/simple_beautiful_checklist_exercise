import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'database_repository.dart';

class SharedPreferencesRepository implements DatabaseRepository {
  static const String _key = 'items';

  // get/load items SharedPreferences
  Future<List<String>> _loadItems() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_key) ?? [];
  }

  // save items list
  Future<void> _saveItems(List<String> items) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_key, items);
  }

  //////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////
  @override
  Future<int> getItemCount() async {
    final items = await _loadItems();
    return items.length;
  }

  @override
  Future<List<String>> getItems() async {
    return await _loadItems();
  }

  @override
  Future<void> addItem(String item) async {
    final items = await _loadItems();
    items.add(item);
    await _saveItems(items);
  }

  @override
  Future<void> deleteItem(int index) async {
    final items = await _loadItems();
    if (index >= 0 && index < items.length) {
      items.removeAt(index);
      await _saveItems(items);
    }
  }

  @override
  Future<void> editItem(int index, String newItem) async {
    final items = await _loadItems();
    if (index >= 0 && index < items.length) {
      items[index] = newItem;
      await _saveItems(items);
    }
  }
}
