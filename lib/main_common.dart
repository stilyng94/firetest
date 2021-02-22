import 'package:firebase_core/firebase_core.dart';
import 'package:firetest/core/my_app_flavors/main_app.dart';
import 'package:firetest/services/init_services.dart';
import 'package:flutter/material.dart';

///Start General Services
Future<void> mainCommon(String assetName) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await initServices(assetName);
  return runApp(MyApp());
}

//TODO: Firebase Remote Config
//TODO: Firebase Auth REST API
//TODO: pyrebase
