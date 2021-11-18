import 'package:flutter/cupertino.dart';
import 'package:my_first_app/models/items.dart';

class ItemsProvider extends ChangeNotifier {
  final List<Items> _aktiviteter = [];
  List<Items> get getAktiviteter {
    return _aktiviteter;
  }

  void addItem(String aktivitet, bool checked) {
    Items item = Items(aktivitet, checked);

    _aktiviteter.add(item);

    notifyListeners();
  }

  void removeItem(int index) {
    _aktiviteter.removeAt(index);

    notifyListeners();
  }

  void updateAll(bool check) {
    for (var a in _aktiviteter) {
      a.checked = check;
    }
    notifyListeners();
  }
}
