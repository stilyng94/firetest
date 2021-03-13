import 'package:firetest/services/config_service.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class DBService extends GetxService {
  Future<DBService> initDBService() async {
    final environment = Get.find<ConfigService>().configModel;
    await GetStorage.init(environment.environment);
    return this;
  }

  GetStorage get dbStorage =>
      GetStorage(Get.find<ConfigService>().configModel.environment);
}
