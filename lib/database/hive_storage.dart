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
    debugPrint("Save Response");
    await _box.put(response.id, response);
  }

  ResponseBody? getResponse(String key) {
    return _box.get(key);
  }

  bool isResponsePresent(String key) {
    return _box.containsKey(key);
  }

  Future<List<ResponseBody>> getAllResponse() async {
    return _box.values.toList();
  }

  Future<void> deleteResponse(String key) async {
    debugPrint("Deleted Response");
    return _box.delete(key);
  }

  Future<void> deleteAllResponse() async {
    return _box.deleteFromDisk();
  }
}
