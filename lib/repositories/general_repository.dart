import 'package:firetest/core/constants/box_constants.dart';
import 'package:firetest/local_data_sources/general_data_source.dart';
import 'package:firetest/models/general_model.dart';

import 'package:meta/meta.dart';

abstract class IGeneralRepo {
  Future<void> delete();

  GeneralModel read();

  Future<void> write({@required GeneralModel generalModel});
}

class GeneralRepo implements IGeneralRepo {
  final IGeneralLocalDataSource iGeneralLocalDataSource;

  GeneralRepo(this.iGeneralLocalDataSource);

  @override
  Future<void> delete() async {
    return await iGeneralLocalDataSource.delete(key: BoxConstatnts.GENERAL_KEY);
  }

  @override
  GeneralModel read() {
    final data = iGeneralLocalDataSource.read(key: BoxConstatnts.GENERAL_KEY);
    if (data != null) {
      return GeneralModel.fromJson(data);
    }
    return null;
  }

  @override
  Future<void> write({GeneralModel generalModel}) async {
    final jsonData = generalModel.toJson();
    return await iGeneralLocalDataSource.write(
        key: BoxConstatnts.GENERAL_KEY, jsonData: jsonData);
  }
}
