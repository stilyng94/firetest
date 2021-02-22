import 'package:firetest/models/confing_model.dart';
import 'package:firetest/utils/asset_reader.dart';
import 'package:get/get.dart';

class ConfigService extends GetxService {
  ConfigModel configModel;
  Future<ConfigService> init(String assetName) async {
    final jsonData = await assetReader(assetName);
    this.configModel = ConfigModel.fromJson(jsonData);
    return this;
  }
}
