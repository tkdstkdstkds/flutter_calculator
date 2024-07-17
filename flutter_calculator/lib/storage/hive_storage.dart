import 'package:flutter_calculator/storage/a_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveStorage implements AStorage {

  final String _path;
  late Box _box;
  HiveStorage(this._path);

  @override
  Future<void> init() async {
    // for hot reload case, make sure box data is saved before reopen
    if(Hive.isBoxOpen(_path)) {
      await close();
    }
    
    _box = await Hive.openBox(_path);
  }

  @override
  Future<void> put<T>(String key, {T? value}) async {
    await _box.put(key, value);
    
  }

  @override
  Future<void> delete(String key) async {
    await _box.delete(key);
  }

  @override
  Future<T?> get<T>(String key, {T? defaultValue}) async {
    var result = await _box.get(key, defaultValue: defaultValue);
    if (result == null) {
      return defaultValue;
    }
    return result as T?;
  }

  @override
  Future<void> flush() async {
    return await _box.flush();
  }
  
  @override
  Future<void> close() async{
    await _box.close();
  }
}