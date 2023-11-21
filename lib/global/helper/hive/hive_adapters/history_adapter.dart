import 'package:hive_flutter/adapters.dart';
import 'country_model_adapter.dart';

class HistoryModel {
  @HiveField(0)
  String? imagePath;
  @HiveField(1)
  List<dynamic> positionedBlockWidgets = [];
  @HiveField(2)
  List<dynamic> positionedLineWidgets = [];
  @HiveField(3)
  List<dynamic> positionedTextWidgets = [];
  @HiveField(4)
  DateTime storedDate;
  @HiveField(5)
  LanguageModel fromLanguageModel;
  @HiveField(6)
  LanguageModel toLanguageModel;
  @HiveField(7)
  String? translateToText;
  @HiveField(8)
  String? translateFromText;

  // List<dynamic> = List<HistoryPositionedWidgetModel>

  HistoryModel({
    required this.imagePath,
    required this.positionedBlockWidgets,
    required this.positionedLineWidgets,
    required this.positionedTextWidgets,
    required this.storedDate,
    required this.fromLanguageModel,
    required this.toLanguageModel,
    this.translateToText,
    this.translateFromText,
  });
}

@HiveType(typeId: 0, adapterName: 'HistoryModelAdapter')
class HistoryModelAdapter extends TypeAdapter<HistoryModel> {
  @override
  HistoryModel read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HistoryModel(
      imagePath: fields[0] as String?,
      positionedBlockWidgets: fields[1] as List<dynamic>,
      positionedLineWidgets: fields[2] as List<dynamic>,
      positionedTextWidgets: fields[3] as List<dynamic>,
      storedDate: fields[4] as DateTime,
      fromLanguageModel: fields[5] as LanguageModel,
      toLanguageModel: fields[6] as LanguageModel,
      translateToText: fields[7] as String?,
      translateFromText: fields[8] as String?,
    );
  }

  @override
  int get typeId => 0;

  @override
  void write(BinaryWriter writer, obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.imagePath)
      ..writeByte(1)
      ..write(obj.positionedBlockWidgets)
      ..writeByte(2)
      ..write(obj.positionedLineWidgets)
      ..writeByte(3)
      ..write(obj.positionedTextWidgets)
      ..writeByte(4)
      ..write(obj.storedDate)
      ..writeByte(5)
      ..write(obj.fromLanguageModel)
      ..writeByte(6)
      ..write(obj.toLanguageModel)
      ..writeByte(7)
      ..write(obj.translateToText)
      ..writeByte(8)
      ..write(obj.translateFromText);
  }
}
