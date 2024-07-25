import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:myapp/modals/response_modal.dart';

class HiveStorage {
  static const String _boxName = "database";
  late Box<ResponseBody> _box;

  HiveStorage() {
    _box = Hive.box<ResponseBody>(_boxName);
  }

  Future<void> saveArticle(ResponseBody response) async {
    debugPrint(response.title);
    await _box.put(response.id, response);
  }

  ResponseBody? getResponse(String key) {
    return _box.get(key);
  }

  bool isResponsePresent(String key) {
    return _box.containsKey(key);
  }

  List<ResponseBody> getAllResponse() {
    var list = _box.values.toList();
    print(list.toString());
    return list;
  }

  Future<void> deleteResponse(String key) async {
    debugPrint("Deleted Response");
    return _box.delete(key);
  }

  Future<void> deleteAllResponse() async {
    return _box.deleteFromDisk();
  }
}
