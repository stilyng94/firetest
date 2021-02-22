import 'dart:convert';

import 'package:flutter/services.dart';

Future<Map<String, dynamic>> assetReader(String assetPath) async {
  final asset = await rootBundle.loadString(assetPath);
  final jsonData = json.decode(asset) as Map<String, dynamic>;
  return jsonData;
}
