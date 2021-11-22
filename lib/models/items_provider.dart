import 'package:flutter/cupertino.dart';
import 'package:my_first_app/models/items.dart';

class ItemsProvider extends ChangeNotifier {
  final List<Items> _aktiviteter = [];
  String _filterBy = 'all';
  List<Items> get getAktiviteter {
    return _aktiviteter;
  }

  String get filterBy => _filterBy;

  void addItem(String aktivitet, bool checked) {
    Items item = Items(aktivitet, checked);

    _aktiviteter.add(item);

    notifyListeners();
  }

  void removeItem(Items item) {
    _aktiviteter.remove(item);

    notifyListeners();
  }

  void updateAll(bool check) {
    for (var a in _aktiviteter) {
      a.checked = check;
    }
    notifyListeners();
  }

  void setFilterBy(String filterBy) {
    this._filterBy = filterBy;
    notifyListeners();
  }

  bool checkAllMarked() {
    bool value = false;
    if (_aktiviteter.every((element) => element.checked == false)) {
      value = false;
    }
    if (_aktiviteter.every((element) => element.checked == true)) {
      value = true;
    }
    return value;
  }
}
