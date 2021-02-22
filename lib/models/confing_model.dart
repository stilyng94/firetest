class ConfigModel {
  final String environment;
  final bool enableCrashlytics;
  final String baseUrl;

  ConfigModel(
    this.environment,
    this.enableCrashlytics,
    this.baseUrl,
  );
  factory ConfigModel.fromJson(Map<String, dynamic> jsonData) {
    return ConfigModel(jsonData["environment"], jsonData["enableCrashlytics"],
        jsonData["baseUrl"]);
  }
}
