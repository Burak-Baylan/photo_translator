// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:photo_translator/core/extensions/context_extension.dart';
import 'package:photo_translator/main.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class PurchaseHelper {
  static var shared = PurchaseHelper();
  var isPremium = false;
  Package? yearlyPackage;
  Package? threeMonthlyPackage;
  Package? weeklyPackage;

  //*DONE
  Future<void> initPurchase() async {
    try {
      await Purchases.setDebugLogsEnabled(true);
      await Purchases.setup("-");
      await checkIsPremium();
    } catch (e) {
    }
  }

//* DONE
  Future<void> loadProducts() async {
    try {
      var offerings = await Purchases.getOfferings();
      yearlyPackage = offerings.all["default"]?.annual;
      weeklyPackage = offerings.all["default"]?.weekly;
      threeMonthlyPackage = offerings.all["default"]?.threeMonth;
    } on PlatformException catch (e) {}
  }

  //* DONE
  Future<bool> checkIsPremium() async {
    try {
      var purchaserInfo = await Purchases.getCustomerInfo();
      isPremium = purchaserInfo.entitlements.all["premium"]?.isActive ?? false;
      globalVm.changeIsPremiumState(isPremium);
      GetStorage().write("isPremium", isPremium);
      print('k9421 is premium active $isPremium');
      return isPremium;
    } catch (e) {
      isPremium = GetStorage().read("isPremium") ?? false;
      globalVm.changeIsPremiumState(isPremium);
      print('k9421 is premium error $e');
      return isPremium;
    }
  }

  //* DONE
  Future<bool> purchase(Package? packageToPurchase, BuildContext context) async {
    try {
      if (packageToPurchase == null) {
        return false;
      }
      var info = await Purchases.purchasePackage(packageToPurchase);
      isPremium = info.entitlements.all['premium']?.isActive ?? false;
      globalVm.changeIsPremiumState(isPremium);
      context.pop;
      return isPremium;
    } on PlatformException catch (e) {
      return false;
    }
  }

  //* DONE
  Future<bool> restorePurchase() async {
    try {
      CustomerInfo restoredInfo = await Purchases.restorePurchases();
      restoredInfo.activeSubscriptions;
      isPremium = restoredInfo.entitlements.all['premium']?.isActive ?? false;
      globalVm.changeIsPremiumState(isPremium);
      return restoredInfo.entitlements.all['premium']?.isActive ?? false;
    } on PlatformException catch (e) {
      print(e);
      isPremium = false;
      globalVm.changeIsPremiumState(isPremium);
      return false;
    }
  }

  String get getWeeklyPriceStr {
    try {
      String price = weeklyPackage!.storeProduct.priceString;
      return '$price / Week';
    } catch (e) {
      return "";
    }
  }

  String get get3MonthsPriceStr {
    try {
      String price = threeMonthlyPackage!.storeProduct.priceString;
      return '$price / 3 Months';
    } catch (e) {
      return "";
    }
  }

  String get getYearlyPriceStr {
    try {
      String price = yearlyPackage!.storeProduct.priceString;
      return '$price / 12 Months';
    } catch (e) {
      return "";
    }
  }

  String get getYearlyPriceAsWeeklyStr {
    return '${getYearlyPriceAsWeekly.toStringAsFixed(2)} / Week';
  }

  String get get3MonthsPriceAsWeeklyStr {
    return '${get3MonthPriceAsWeekly.toStringAsFixed(2)} / Week';
  }

  double get getYearlyPriceAsWeekly => yearlyPackage!.storeProduct.price / 52;
  double get get3MonthPriceAsWeekly => threeMonthlyPackage!.storeProduct.price / 12;

  String get getYearlyDiscountRatio {
    try {
      var weeklyPrice = weeklyPackage!.storeProduct.price;
      return (100 - ((getYearlyPriceAsWeekly / weeklyPrice) * 100)).toStringAsFixed(1);
    } catch (e) {
      return "";
    }
  }

  String get get3MonthlyDiscountRatio {
    try {
      var weeklyPrice = weeklyPackage!.storeProduct.price;
      return (100 - ((get3MonthPriceAsWeekly / weeklyPrice) * 100)).toStringAsFixed(1);
    } catch (e) {
      return "";
    }
  }
}
