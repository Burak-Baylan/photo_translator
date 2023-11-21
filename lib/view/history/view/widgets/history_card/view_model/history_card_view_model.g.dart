// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_card_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HistoryCardViewModel on _HistoryCardViewModelBase, Store {
  late final _$isTtsPlayingAtom =
      Atom(name: '_HistoryCardViewModelBase.isTtsPlaying', context: context);

  @override
  bool get isTtsPlaying {
    _$isTtsPlayingAtom.reportRead();
    return super.isTtsPlaying;
  }

  @override
  set isTtsPlaying(bool value) {
    _$isTtsPlayingAtom.reportWrite(value, super.isTtsPlaying, () {
      super.isTtsPlaying = value;
    });
  }

  @override
  String toString() {
    return '''
isTtsPlaying: ${isTtsPlaying}
    ''';
  }
}
