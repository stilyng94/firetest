import 'dart:convert';

import 'package:get_storage/get_storage.dart';

import 'package:meta/meta.dart';

abstract class IGeneralLocalDataSource {
  Future<void> delete({@required String key});

  Map<String, dynamic> read({@required String key});

  Future<void> write(
      {@required String key, @required Map<String, dynamic> jsonData});
}

class GeneralLocalDataSource implements IGeneralLocalDataSource {
  final GetStorage dbStorage;

  GeneralLocalDataSource(this.dbStorage);
  @override
  Future<void> delete({String key}) async {
    return await this.dbStorage.remove(key);
  }

  @override
  Map<String, dynamic> read({String key}) {
    final jsonData = this.dbStorage.read(key);
    if (jsonData != null) {
      return jsonDecode(jsonData);
    }
    return null;
  }

  @override
  Future<void> write({String key, Map<String, dynamic> jsonData}) async {
    final data = jsonEncode(jsonData);
    return await this.dbStorage.write(key, data);
  }
}
