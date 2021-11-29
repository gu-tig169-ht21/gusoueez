import 'package:flutter/cupertino.dart';
import 'package:my_first_app/models/items.dart';
import 'package:my_first_app/models/response_provider.dart';
import 'dart:convert';

class ItemsProvider extends ChangeNotifier {
  List<Items> _aktiviteter = [];
  String _filterBy = 'all';
  final String _key = 'ebe1a990-2a5d-486d-bc99-a1c4de909bbb';
  String get key => _key;
  List<Items> get list => _aktiviteter;

  Future getAktiviteter() async {
    List<Items> list = await ResponseProvider().fetchItems(key);
    _aktiviteter = list;
    notifyListeners();
  }

  String get filterBy => _filterBy;

  void addItem(String title, bool done) async {
    Map data = {
      'title': title,
      'done': done,
    };
    var body = jsonEncode(data);
    List<Items> list = await ResponseProvider().addItem(body, key);
    _aktiviteter = list;

    notifyListeners();
  }

  void updateItem(Items item, bool done) async {
    Map data = {
      'id': item.id,
      'title': item.title,
      'done': done,
    };
    var body = jsonEncode(data);
    List<Items> list = await ResponseProvider().updateItem(body, item.id, key);
    _aktiviteter = list;

    notifyListeners();
  }

  void removeItem(Items item) async {
    List<Items> list = await ResponseProvider().removeItem(item.id, key);
    _aktiviteter = list;

    notifyListeners();
  }

  //void updateAll(bool check) {
  //for (var a in _aktiviteter) {
  //a.checked = check;
  //}
  //notifyListeners();
  //}

  void setFilterBy(String filterBy) {
    this._filterBy = filterBy;
    notifyListeners();
  }
}
