import 'package:flutter/material.dart';
import 'package:photo_translator/global/helper/languages_list_helper/languages_list_helper.dart';
import 'package:photo_translator/global/helper/purchase_helper.dart';
import 'package:photo_translator/main/global_view_model.dart';
import 'package:photo_translator/view/home/view/home_view.dart';
import 'package:photo_translator/view/on_boarding_page/view/on_boarding_page.dart';

import 'global/helper/hive/hive_helper.dart';

GlobalViewModel globalVm = GlobalViewModel();

void main() async {
  await HiveHelper.instance.initHive();
  await globalVm.startCamera();
  await PurchaseHelper.shared.initPurchase();
  await PurchaseHelper.shared.loadProducts();
  globalVm.getRemainingCameraTranslation();
  await globalVm.getFirstInit();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  void init(BuildContext context) {
    CountriesListHelper.setCountriesList();
    globalVm.init(context);
  }

  @override
  Widget build(BuildContext context) {
    init(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Photo Translator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: globalVm.isFirstInit ? OnBoardingPage() : HomeView(),
    );
  }
}
