// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paywall_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PaywallViewModel on _PaywallViewModelBase, Store {
  late final _$isCloseButtonVisibleAtom = Atom(
      name: '_PaywallViewModelBase.isCloseButtonVisible', context: context);

  @override
  bool get isCloseButtonVisible {
    _$isCloseButtonVisibleAtom.reportRead();
    return super.isCloseButtonVisible;
  }

  @override
  set isCloseButtonVisible(bool value) {
    _$isCloseButtonVisibleAtom.reportWrite(value, super.isCloseButtonVisible,
        () {
      super.isCloseButtonVisible = value;
    });
  }

  late final _$selectedPackageAtom =
      Atom(name: '_PaywallViewModelBase.selectedPackage', context: context);

  @override
  PackageEnum get selectedPackage {
    _$selectedPackageAtom.reportRead();
    return super.selectedPackage;
  }

  @override
  set selectedPackage(PackageEnum value) {
    _$selectedPackageAtom.reportWrite(value, super.selectedPackage, () {
      super.selectedPackage = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_PaywallViewModelBase.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  @override
  String toString() {
    return '''
isCloseButtonVisible: ${isCloseButtonVisible},
selectedPackage: ${selectedPackage},
isLoading: ${isLoading}
    ''';
  }
}
