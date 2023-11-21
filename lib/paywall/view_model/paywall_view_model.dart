import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import '../../global/helper/purchase_helper.dart';
part 'paywall_view_model.g.dart';

class PaywallViewModel = _PaywallViewModelBase with _$PaywallViewModel;

abstract class _PaywallViewModelBase with Store {
  @observable
  bool isCloseButtonVisible = false;

  BuildContext? contextt;

  @observable
  PackageEnum selectedPackage = PackageEnum.yearly;

  @observable
  bool isLoading = false;

  void changeIsLoadingState(bool state) => isLoading = state;

  void setSelectedPackage(PackageEnum packageEnum) =>
      selectedPackage = packageEnum;

  void setContext(BuildContext context) => contextt = context;

  bool get isPackageWeekly {
    return selectedPackage == PackageEnum.weekly;
  }

  Future<void> init(BuildContext context) async {
    setContext(context);
    startCloseButtonTimer();
  }

  Future<void> purchase() async {
    changeIsLoadingState(true);
    var premiumResponse = await PurchaseHelper.shared.checkIsPremium();
    if (premiumResponse) {
      await showYouAreAlreadyPremiumDialog();
      changeIsLoadingState(false);
      return;
    }
    var selectedPackage = this.selectedPackage == PackageEnum.yearly
        ? PurchaseHelper.shared.yearlyPackage
        : this.selectedPackage == PackageEnum.monthly
            ? PurchaseHelper.shared.threeMonthlyPackage
            : PurchaseHelper.shared.weeklyPackage;
    bool response =
        await PurchaseHelper.shared.purchase(selectedPackage, contextt!);
    if (response) {
      await showSuccessAlertDialog();
    } else {
      await showErrorAlertDialog();
      changeIsLoadingState(false);
    }
  }

  Future<void> restore() async {
    changeIsLoadingState(true);
    var premiumResponse = await PurchaseHelper.shared.checkIsPremium();
    if (premiumResponse) {
      await showYouAreAlreadyPremiumDialog();
      changeIsLoadingState(false);
      return;
    }
    bool response = await PurchaseHelper.shared.restorePurchase();
    changeIsLoadingState(false);
    if (response) {
      await showSuccessAlertDialog();
    } else {
      await showErrorAlertDialog();
      changeIsLoadingState(false);
    }
  }

  void startCloseButtonTimer() {
    int timerSc = 0;
    Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (timerSc == 3) {
          isCloseButtonVisible = true;
          timer.cancel();
        }
        timerSc++;
      },
    );
  }

  Future<void> showSuccessAlertDialog() async {
    await showDialog(
      context: contextt!,
      builder: (context) => AlertDialog(
        title: const Text('Success'),
        content: const Text('Congratulations, you are premium now.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<void> showErrorAlertDialog() async {
    await showDialog(
      context: contextt!,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: const Text('Something went wrong. Please try again.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<void> showYouAreAlreadyPremiumDialog() async {
    await showDialog(
      context: contextt!,
      builder: (context) => AlertDialog(
        title: const Text('Info'),
        content: const Text('You are already premium.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}

enum PackageEnum { yearly, monthly, weekly }
