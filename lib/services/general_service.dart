import 'package:firetest/generated/l10n.dart';
import 'package:firetest/models/general_model.dart';
import 'package:firetest/repositories/general_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GeneralService extends GetxService {
  final IGeneralRepo iGeneralRepo;
  final onBoarded = false.obs;
  final currentLocale = Rx<Locale>();
  final _generalModel = GeneralModel().obs;

  GeneralService(this.iGeneralRepo);

  Future<GeneralService> init() async {
    await _getGeneralInfo();
    return this;
  }

  //! updates the language stored
  Future<void> updateLanguage(String value) async {
    final locale = LangTranslator.delegate.supportedLocales
        .firstWhere((locale) => locale.languageCode == value);
    _generalModel.update((val) {
      val.currentLocale = locale.languageCode;
    });
    currentLocale.value = locale;
    await iGeneralRepo.write(generalModel: _generalModel.value);
    await LangTranslator.load(currentLocale.value);
    return;
  }

  Future<void> updateOnBoardedStatus() async {
    onBoarded.toggle();
    _generalModel.update((val) {
      val.onBoarded = onBoarded.value;
    });
    await iGeneralRepo.write(generalModel: _generalModel.value);
    return;
  }

  Future<void> _getGeneralInfo() async {
    final failureOrSuccess = iGeneralRepo.read();
    final devLocale = Get.deviceLocale;
    if (failureOrSuccess == null) {
      currentLocale.value = LangTranslator.delegate.supportedLocales.firstWhere(
          (locale) => locale.languageCode == devLocale.languageCode,
          orElse: () => LangTranslator.delegate.supportedLocales.first);

      _generalModel.update((val) {
        val.currentLocale = currentLocale.value.languageCode;
        val.onBoarded = onBoarded.value;
      });
      await iGeneralRepo.write(generalModel: _generalModel.value);
    } else {
      currentLocale.value = LangTranslator.delegate.supportedLocales.firstWhere(
          (locale) => locale.languageCode == failureOrSuccess.currentLocale,
          orElse: () => LangTranslator.delegate.supportedLocales.first);
      onBoarded.value = false;
      _generalModel.update((val) {
        val.currentLocale = currentLocale.value.languageCode;
        val.onBoarded = onBoarded.value;
      });
    }
    await LangTranslator.load(currentLocale.value);
    return;
  }
}
