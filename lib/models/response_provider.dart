import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:my_first_app/models/items.dart';

class ResponseProvider {
  Future<List<Items>> fetchItems(String key) async {
    final response = await http.get(Uri.parse(
        'https://todoapp-api-pyq5q.ondigitalocean.app/todos?key=$key'));

    var json = jsonDecode(response.body);
    return json.map<Items>((data) {
      return Items.fromJson(data);
    }).toList();
  }

  Future<String> fetchKey() async {
    final response = await http.get(
        Uri.parse('https://todoapp-api-pyq5q.ondigitalocean.app/register'));
    return response.body;
  }

  Future<List<Items>> addItem(Object body, String key) async {
    final response = await http.post(
        Uri.parse(
            'https://todoapp-api-pyq5q.ondigitalocean.app/todos?key=$key'),
        headers: {'Content-Type': 'application/json'},
        body: body);
    var json = jsonDecode(response.body);
    return json.map<Items>((data) {
      return Items.fromJson(data);
    }).toList();
  }

  Future<List<Items>> updateItem(Object body, String id, String key) async {
    final response = await http.put(
        Uri.parse(
            'https://todoapp-api-pyq5q.ondigitalocean.app/todos/$id?key=$key'),
        headers: {'Content-Type': 'application/json'},
        body: body);
    var json = jsonDecode(response.body);
    return json.map<Items>((data) {
      return Items.fromJson(data);
    }).toList();
  }

  Future<List<Items>> removeItem(String id, String key) async {
    final response = await http.delete(Uri.parse(
        'https://todoapp-api-pyq5q.ondigitalocean.app/todos/$id?key=$key'));
    var json = jsonDecode(response.body);
    return json.map<Items>((data) {
      return Items.fromJson(data);
    }).toList();
  }
}
